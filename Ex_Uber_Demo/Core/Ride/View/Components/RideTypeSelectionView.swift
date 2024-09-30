//
//  RideTypeSelectionView.swift
//  Ex_Uber_Demo
//
//  Created by Ahmad Ellashy on 26/09/2024.
//

import SwiftUI

struct RideTypeSelectionView: View {
    
    @EnvironmentObject var locationSearchViewModel: LocationSearchViewModel
    @State var selectedRide: UberRideOptions = .uber
    var size = UIScreen.main.bounds
    
    var body: some View {
        ScrollView(.horizontal){
            HStack{
                ForEach(UberRideOptions.allCases,id:\.self){type in
                    VStack(alignment:.leading){
                        Image(type.image)
                            .resizable()
                            .scaledToFit()
                            .scaleEffect(selectedRide == type ? 1.2 : 1.0)
                            
                        VStack(alignment:.leading){
                            Text(type.title)
                                .font(.system(size: selectedRide == type ? 19: 17))
                                .fontWeight(.semibold)
                                .padding(.top,10)
                            Text(locationSearchViewModel.calculateDistance(for: type).toCurreny())
                                .font(.subheadline)
                        }
                        .padding(.horizontal,10)
                        .padding(.bottom,10)
                   
                    }
                    .frame(width: size.width / 2.7,height: size.width / 2.6)
                    .background(selectedRide == type ? Color.blue : Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 10)
                    .padding()
                    
                    .onTapGesture {
                        withAnimation {
                            selectedRide = type
                        }
                    }

                }
            }
        }
        .scrollIndicators(.hidden)
        
    }
}

#Preview {
    RideTypeSelectionView()
}
