//
//  LocationManager.swift
//  Ex_Uber_Demo
//
//  Created by Ahmad Ellashy on 23/09/2024.
//

import UIKit
import CoreLocation

class LocationManager: NSObject, ObservableObject {
    let locationManager: CLLocationManager = CLLocationManager()
    
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
        
    }
}
