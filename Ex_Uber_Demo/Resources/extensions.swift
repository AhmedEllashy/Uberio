//
//  extensions.swift
//  Ex_Uber_Demo
//
//  Created by Ahmad Ellashy on 30/09/2024.
//

import Foundation


extension Double{
    private var currencyFormatter: NumberFormatter{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    func toCurreny() -> String{
        return currencyFormatter.string(for: self) ?? ""
    }
}

extension Date {
    private var formatter: DateFormatter{
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = "HH:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        return formatter
    }
    func convertToHourandMinutes() -> String{
        return formatter.string(for: self) ?? ""
    }
    
}
