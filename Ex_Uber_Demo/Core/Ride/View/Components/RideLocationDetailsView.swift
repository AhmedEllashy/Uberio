//
//  RideLocationDetailsView.swift
//  Ex_Uber_Demo
//
//  Created by Ahmad Ellashy on 26/09/2024.
//

import SwiftUI

struct RideLocationDetailsView: View {
    @EnvironmentObject var searchViewModel: LocationSearchViewModel
    @State var destinationEstimatedTime: String = ""
    var body: some View {
        HStack(spacing:20){
            TwoPointsShapeView()
            VStack(alignment:.leading,spacing: 20){
                HStack{
                    Text("Current Location")
                        .font(.system(size: 15))
                        .fontWeight(.medium)
                        .foregroundStyle(.gray.opacity(0.9))

                    Spacer()
                    Text(Date().convertToHourandMinutes())
                        .font(.system(size: 15))
                        .fontWeight(.medium)
                        .foregroundStyle(.gray.opacity(0.9))

                }
                HStack {
                    Text(searchViewModel.destinationLocation?.title ?? "Destination")
                        .font(.system(size: 15))
                        .fontWeight(.medium)
                        .lineLimit(2)
                        .padding(.trailing,40)
                    Spacer()
                    Text(destinationEstimatedTime)
                        .font(.system(size: 15))
                        .fontWeight(.medium)
                    
                }
            }//VStack
            
        }
        .padding()
        .onReceive(RideViewModel.shared.$destinationArrivalTime, perform: { time in
            destinationEstimatedTime = time ?? "00:00"
        })
    }
}

#Preview {
    RideLocationDetailsView()
}
