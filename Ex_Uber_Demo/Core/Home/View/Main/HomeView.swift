//
//  HomeView.swift
//  Ex_Uber_Demo
//
//  Created by Ahmad Ellashy on 23/09/2024.
//

import SwiftUI

struct HomeView: View {
    @State var state: AppStates = .initState
    var body: some View {
        ZStack(alignment:.topLeading){
            MapView(appState: $state)
            //
            switch state {
            case .initState:
                RectangleInitalView()
                    .padding(.top,140)
                    .padding(.horizontal,10)
                    .onTapGesture {
                        self.state = .SearchLocationViewState
                    }
            case .SearchLocationViewState:
                LocationSearchView(state: $state)
            case .SelectedLocationState:
                Rectangle()
                    .frame(width: 20,height: 20)
            }
            DynamicMainButton(state: self.$state)
                .padding(.leading,30)
                .padding(.top,60)

        }
        .ignoresSafeArea()
    }
}

#Preview {
    HomeView()
}
