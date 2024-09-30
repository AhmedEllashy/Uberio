//
//  RideView.swift
//  Ex_Uber_Demo
//
//  Created by Ahmad Ellashy on 26/09/2024.
//

import SwiftUI

struct RideView: View {
    var body: some View {
        VStack{
           RoundedRectangle(cornerRadius: 25.0)
                .frame(width: 50,height: 5)
                .padding(.vertical,10)
            
            RideLocationDetailsView()
            Divider()
            RideTypeSelectionView()
            Divider()
            HStack(spacing:30){
                Text("visa".capitalized)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(8)
                    .background(Color.blue)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                Text("******* 15368")
                    .font(.title3)
                    .fontWeight(.semibold)

                Spacer()
                Image(systemName: "chevron.right")
                    .font(.title3)
                    .padding(.trailing,10)
                
            }
            .padding(8)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .shadow(radius: 10)
            .padding(.horizontal,10)
            Divider()
            Button {
                
            } label: {
                Text("Confirm Ride")
                    .font(.title3)
                    .fontWeight(.bold)
            }
            .frame(maxWidth: .infinity,minHeight: 50)
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .foregroundStyle(.white)
            .shadow(radius: 10)
            .padding(8)
            .padding(.bottom,50)
            



            
      
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    
        
    }
}

#Preview {
    RideView()
}
