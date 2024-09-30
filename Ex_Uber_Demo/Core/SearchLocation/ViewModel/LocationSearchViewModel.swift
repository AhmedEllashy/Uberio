//
//  LocationSearchViewModel.swift
//  Ex_Uber_Demo
//
//  Created by Ahmad Ellashy on 24/09/2024.
//

import Foundation
import MapKit


class LocationSearchViewModel: NSObject,ObservableObject{
    //MARK: - Properties
    @Published var searchResults = [MKLocalSearchCompletion]()
    @Published var destinationLocation: UberLoctionModel?
    @Published var userLocationCoordinates: CLLocationCoordinate2D?
    var searchCompleter = MKLocalSearchCompleter()
    var searchQuery: String =  "" {
        didSet{
           searchCompleter.queryFragment = searchQuery
        }
    }
    //MARK: - Life Cycle
    override init(){
        super.init()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = searchQuery
    }
 
    //MARK: - Helpers
    func didSelectLocation(with selectedLocation: MKLocalSearchCompletion){
        self.createSearchRequest(with: selectedLocation) {[weak self] response, error in
            guard let self = self else{return}
            
            if let res = response{
                guard let result = res.mapItems.first else{return}
                let location = result.placemark
                
                self.destinationLocation = UberLoctionModel(
                    title: location.title ?? "",
                    subTitle: location.subtitle ?? "",
                    coordinates: location.coordinate)
                print("Debug: Destination location is \(self.destinationLocation)")
            }else{
                print(error ?? "")
            }

        }
    }
    private func createSearchRequest(with selectedLocation: MKLocalSearchCompletion, completion: @escaping MKLocalSearch.CompletionHandler){
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = selectedLocation.title.appending(selectedLocation.subtitle)
        let search = MKLocalSearch(request: request)
        search.start(completionHandler: completion)
        
    }
    func cleanViewModel(){
        destinationLocation = nil
    }
    func calculateDistance(for ride: UberRideOptions) -> Double{
        guard let uLocation = userLocationCoordinates else{return 0.0}
        guard let dLocation = destinationLocation?.coordinates else{return 0.0}
        
        let userLocation = CLLocation(latitude: uLocation.latitude, longitude: uLocation.longitude)
        let destLocation = CLLocation(latitude: dLocation.latitude, longitude: dLocation.longitude)
        
        let distance = userLocation.distance(from: destLocation)
        return ride.calculateRidePrice(distance: distance)

    }
    
}
extension LocationSearchViewModel: MKLocalSearchCompleterDelegate{
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
    }
}
