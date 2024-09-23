//
//  LocationSearchTextFieldsView.swift
//  Ex_Uber_Demo
//
//  Created by Ahmad Ellashy on 23/09/2024.
//

import SwiftUI

struct LocationSearchTextFieldsView: View {
   @State var currentLocation: String = ""
   @Binding var destinationLocation: String
    var body: some View {
        VStack(spacing:10){
            
            TextField("  Current Location", text: $currentLocation)
                .font(.system(size: 14,weight: .light))
                .frame(height: 40)
                .background(Color(.systemGroupedBackground))
            TextField(" Destination", text: $destinationLocation)
                .frame(height: 40)
                .background(Color(.systemGroupedBackground))
        }
        .padding()
        
    }
}

#Preview {
    LocationSearchTextFieldsView(currentLocation:"Current Location", destinationLocation: .constant(""))
}
