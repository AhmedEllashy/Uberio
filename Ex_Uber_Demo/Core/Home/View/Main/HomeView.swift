//
//  HomeView.swift
//  Ex_Uber_Demo
//
//  Created by Ahmad Ellashy on 23/09/2024.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var locationSearchViewModel: LocationSearchViewModel
    @State var state: AppStates = .initState
    var body: some View {
        ZStack (alignment:.bottom) {
            ZStack(alignment:.topLeading){
                MapView(appState: $state)
                //
                if state ==  .initState{
                    RectangleInitalView()
                        .padding(.top,140)
                        .padding(.horizontal,10)
                        .onTapGesture {
                            self.state = .SearchLocationViewState
                        }
                }
                else if state == .SearchLocationViewState {
                    LocationSearchView(state: $state)
                }
                DynamicMainButton(state: self.$state)
                    .padding(.leading,30)
                    .padding(.top,60)

            }
            if state == .SelectedLocationState {
                RideView()
               
            }

        }
        .ignoresSafeArea()
        .onReceive(LocationManager.shared.$userLocation, perform: { location in
            locationSearchViewModel.userLocationCoordinates = location
        })
        

    }
}

#Preview {
    HomeView()
}
