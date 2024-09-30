//
//  DynamicMainButton.swift
//  Ex_Uber_Demo
//
//  Created by Ahmad Ellashy on 23/09/2024.
//

import SwiftUI

struct DynamicMainButton: View {
    @Binding var state: AppStates
    var body: some View {
        Button {
            if state == .SelectedLocationState || state == .SearchLocationViewState{
                withAnimation {
                    state = .initState
                }
            }
        } label: {
            Image(
                systemName: state == .initState ? "line.3.horizontal" : "arrow.left"
            )
                .font(.title2)
                .foregroundStyle(.black)
                .background(
                    Circle()
                        .fill()
                        .shadow(radius: 10)
                        .frame(width: 50,height: 50)
                )
                .foregroundStyle(.white)

        }

    }
}

#Preview {
    DynamicMainButton(state: .constant(.initState))
}
