//
//  UberRideOptions.swift
//  Ex_Uber_Demo
//
//  Created by Ahmad Ellashy on 26/09/2024.
//

import Foundation

enum UberRideOptions: CaseIterable{
    case uber
    case uberx
    case uberblack
    case ubercomfort
    
    var title: String  {
        switch self{
        case .uber :
            return "Uber"
        case .uberx :
            return "UberX"
        case .uberblack:
            return "Uber Black"
        case .ubercomfort:
            return "Uber Comfort"
        }
    }
    var image: String {
        switch self{
        case .uber :
            return "uber-x"
        case .uberx :
            return "uber-x"
        case .uberblack :
            return "uber-black"
        case .ubercomfort :
            return "uber-black"
        }
    }
    var basePrice: Double {
        switch self{
        case .uber :
            return 10.80
        case .uberx:
            return 18.4
        case .uberblack:
            return 23.75
        case .ubercomfort :
            return 28.98
        }
    }
    func calculateRidePrice(distance: Double) -> Double{
        let distanceInMiles = distance / 1600
        return distanceInMiles * basePrice
    
    }
}
