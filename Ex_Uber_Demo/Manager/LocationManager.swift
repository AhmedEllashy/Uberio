//
//  LocationManager.swift
//  Ex_Uber_Demo
//
//  Created by Ahmad Ellashy on 23/09/2024.
//

import UIKit
import CoreLocation

class LocationManager: NSObject, ObservableObject {
    static let shared = LocationManager()
    let locationManager: CLLocationManager = CLLocationManager()
    @Published var userLocation: CLLocationCoordinate2D?
    
   override init() {
       super.init()
       locationManager.delegate = self
       locationManager.desiredAccuracy = kCLLocationAccuracyBest
       locationManager.requestWhenInUseAuthorization()
       locationManager.startUpdatingLocation()
    }
    
}

extension LocationManager: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard  !locations.isEmpty else{return}
        userLocation = locations.first?.coordinate
        manager.stopUpdatingLocation()
        
    }
}
