//
//  LocationSearchItemView.swift
//  Ex_Uber_Demo
//
//  Created by Ahmad Ellashy on 23/09/2024.
//

import SwiftUI
import MapKit

struct LocationSearchItemView: View {
    var location: MKLocalSearchCompletion?

    var body: some View {
        HStack(spacing:20){
            Image(systemName: "mappin.circle.fill")
                .font(.title)
                .foregroundStyle(.white)
                .background(
                    Circle()
                        .frame(width: 40,height: 40)
                )
                
            VStack(alignment:.leading){
                Text(location?.title ?? "")
                    .font(.body)
                    .fontWeight(.semibold)
                Text(location?.subtitle ?? "")
                    .font(.footnote)
                    .fontWeight(.semibold)
            }
            Spacer()
        }
        .padding(.leading,20)
    }
}

#Preview {
    LocationSearchItemView()
}
