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
            break
        case .SearchLocationViewState:
            break
        case .SelectedLocationState:
            guard let destinationLocation = locationSearchViewModel.destinationLocation else {
                print("Error Maser")
                return
            }
            print("Debug: Destination is \(destinationLocation.coordinates)")
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
            parenView.mapView.setRegion(region, animated: true)
            self.userLocation = userLocation.coordinate
                
        }
        
        //MARK: - Helpers
        func addAnnotation(for destination: UberLoctionModel){
            let annotation = MKPointAnnotation()
            annotation.coordinate = destination.coordinates
            parenView.mapView.addAnnotation(annotation)
            parenView.mapView.selectAnnotation(annotation, animated: true)
        }
        
        func configPoyline(to destination: CLLocationCoordinate2D){
            guard let safeUserLocation = userLocation else{return}
            getRoute(form: safeUserLocation, to: destination) {[weak self] route in
                guard let self = self else{return}
                self.parenView.mapView.addOverlay(route.polyline)
                let rect = self.parenView.mapView.mapRectThatFits(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30))
                parenView.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
            }
        }
        
        func getRoute(form userLocation: CLLocationCoordinate2D,to destination: CLLocationCoordinate2D,completion: @escaping (MKRoute) -> Void){
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
                    completion(route)
                }
            }
        }
    }
}
