//
//  HelpersViews.swift
//  Ex_Uber_Demo
//
//  Created by Ahmad Ellashy on 26/09/2024.
//

import Foundation
import SwiftUI


func topSectionLocationDetails() -> some View{
    return HStack(spacing:20){
        TwoPointsShapeView()
        VStack(alignment:.leading,spacing: 35){
            HStack{
                Text("Current Location")
                    .font(.system(size: 18))
                    .fontWeight(.medium)
                    .foregroundStyle(.gray.opacity(0.9))

                Spacer()
                Text("2:35PM")
                    .font(.system(size: 16))
                    .fontWeight(.medium)
                    .foregroundStyle(.gray.opacity(0.9))

            }
            HStack {
                Text("Destination")
                    .font(.system(size: 18))
                    .fontWeight(.medium)
                Spacer()
                Text("2:35PM")
                    .font(.system(size: 16))
                    .fontWeight(.medium)
                
            }
        }//VStack
        
    }
    .padding()
}
