//
//  RideViewModel.swift
//  Ex_Uber_Demo
//
//  Created by Ahmad Ellashy on 01/10/2024.
//

import Foundation


class RideViewModel: NSObject, ObservableObject{
    
    @Published var destinationArrivalTime: String?
    static let shared = RideViewModel()
    
    func calculateArrivalTime(expectedTravelTime: TimeInterval) {
            let dt = Date().addingTimeInterval(expectedTravelTime)
        print("dt is \(dt.convertToHourandMinutes())")
            destinationArrivalTime = dt.convertToHourandMinutes()
    }

}
