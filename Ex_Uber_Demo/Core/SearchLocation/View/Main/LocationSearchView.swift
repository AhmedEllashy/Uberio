//
//  LocationSearchView.swift
//  Ex_Uber_Demo
//
//  Created by Ahmad Ellashy on 23/09/2024.
//

import SwiftUI

struct LocationSearchView: View {
    //MARK: - Properties
    @EnvironmentObject var vm: LocationSearchViewModel
    @Binding var state: AppStates
    var body: some View {
        VStack{
            HStack{
                TwoPointsShapeView()
                LocationSearchTextFieldsView(currentLocation: "Current Location", destinationLocation: $vm.searchQuery)
            }
            .padding(.horizontal,10)
            ScrollView{
                ForEach(vm.searchResults,id: \.self){ result in
                    LocationSearchItemView(
                        location: result
                    )
                    .onTapGesture {
                        vm.didSelectLocation(with: result)
                        state = .SelectedLocationState
                    }
                    Divider()
                }
            }
            
        }
        .padding(.top, 125)
        .background(Color.white)
    }
}

#Preview {
    LocationSearchView(state: .constant(.SearchLocationViewState))
}
