//
//  MapView.swift
//  Ex_Uber_Demo
//
//  Created by Ahmad Ellashy on 23/09/2024.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable{
   //MARK: - Properties
    var mapView = MKMapView()
    let locationManager = LocationManager()
    @Binding var appState: AppStates
    @EnvironmentObject var locationSearchViewModel: LocationSearchViewModel


    //MARK: - Life Cycle
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        return mapView
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        switch appState {
        case .initState:
            context.coordinator.clearMapView()
            DispatchQueue.main.async {
                if locationSearchViewModel.destinationLocation != nil {
                    locationSearchViewModel.cleanViewModel()
                }
            }
        case .SearchLocationViewState:
            break
        case .SelectedLocationState:
            guard let destinationLocation = locationSearchViewModel.destinationLocation else {
                print("Error Maser")
                return
            }
            context.coordinator.addAnnotation(for: destinationLocation)
            context.coordinator.configPoyline(to: destinationLocation.coordinates)
            
        }
    }
    
    func makeCoordinator() -> mapViewCoordinator {
        return mapViewCoordinator(parenView: self)
    }
}

extension MapView{
    class mapViewCoordinator: NSObject, MKMapViewDelegate{
        
        //MARK: - Properties
        let parenView: MapView
        var userLocation: CLLocationCoordinate2D?

        
        
        //MARK: - Life Cycle
        init(parenView: MapView) {
            self.parenView = parenView
        }
        
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: userLocation.coordinate.latitude,
                    longitude: userLocation.coordinate.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
//            var timer = Timer(timeInterval: 10, repeats: true) { timer in
//                self.userLocation = CLLocationCoordinate2D(latitude: (self.userLocation?.longitude ?? 10) + 1 , longitude: (self.userLocation?.longitude ?? 10) + 1)
//            }
//            RunLoop.main.run()
            parenView.mapView.setRegion(region, animated: true)
            self.userLocation = userLocation.coordinate
                
        }
        func mapView(_ mapView: MKMapView, rendererFor overlay: any MKOverlay) -> MKOverlayRenderer {
            let poyline = MKPolylineRenderer(overlay: overlay)
            poyline.strokeColor = .black
            poyline.lineWidth = 10
            return poyline
        }
        
        //MARK: - Helpers
        func addAnnotation(for destination: UberLoctionModel){
            let annotation = MKPointAnnotation()
            annotation.title = "destination"
            annotation.coordinate = destination.coordinates
            parenView.mapView.addAnnotation(annotation)
            parenView.mapView.selectAnnotation(annotation, animated: true)
        }
        
        func configPoyline(to destination: CLLocationCoordinate2D){
            guard let safeUserLocation = userLocation else{return}
            MapView.mapViewCoordinator.getRoute(form: safeUserLocation, to: destination) {[weak self] route in
                guard let self = self else{return}
                self.parenView.mapView.addOverlay(route.polyline)
                let rect = self.parenView.mapView.mapRectThatFits(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: 60, left: 33, bottom: 550, right: 33))
                parenView.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
            }
        }
        
       static func getRoute(
            form userLocation: CLLocationCoordinate2D,
            to destination: CLLocationCoordinate2D,
            completion: @escaping (MKRoute) -> Void
        ){
            let userMark = MKPlacemark(coordinate:userLocation)
            let destinationMark = MKPlacemark(coordinate: destination)
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: userMark)
            request.destination = MKMapItem(placemark: destinationMark)
            let direction = MKDirections(request: request)
            direction.calculate { res, error in
                if let error = error{
                    print(error)
                    return
                }else{
                    guard let route = res?.routes.first else{return}
                    RideViewModel.shared.calculateArrivalTime(expectedTravelTime: route.expectedTravelTime)
                    completion(route)
                }
            }
        }
        func clearMapView(){
            let mapView = parenView.mapView
            mapView.removeAnnotations(mapView.annotations)
            mapView.removeOverlays(mapView.overlays)
            
        }
        func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
            var myAnnotation = parenView.mapView.dequeueReusableAnnotationView(withIdentifier: "custom")
            if myAnnotation == nil{
                myAnnotation = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
            }else{
                myAnnotation?.annotation = annotation
            }
     
            if myAnnotation?.annotation?.title == "destination"{
                return nil
            }else{
                guard let image = UIImage(named: "uber-x") else { return nil }
                guard let resizedImage =  ResizeImage(image, targetSize: CGSize(width: 90, height: 90))else{return nil}
                myAnnotation?.image = resizedImage
                return myAnnotation
            }
        }
        func ResizeImage(_ image: UIImage, targetSize: CGSize) -> UIImage? {
            let size = image.size

            let widthRatio  = targetSize.width  / image.size.width
            let heightRatio = targetSize.height / image.size.height

            // Figure out what our orientation is, and use that to form the rectangle
            var newSize: CGSize
            if(widthRatio > heightRatio) {
                newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
            } else {
                newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
            }

            // This is the rect that we've calculated out and this is what is actually used below
            let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

            // Actually do the resizing to the rect using the ImageContext stuff
            UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
            image.draw(in: rect)
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            return newImage
        }
    }

}

