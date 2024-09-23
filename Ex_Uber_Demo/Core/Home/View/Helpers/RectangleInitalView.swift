//
//  RectangleInitalView.swift
//  Ex_Uber_Demo
//
//  Created by Ahmad Ellashy on 23/09/2024.
//

import SwiftUI

struct RectangleInitalView: View {
    var body: some View {
        Rectangle()
            .fill()
            .foregroundStyle(.white)
            .frame(height:50)
            .shadow(radius: 10)
            .padding(.horizontal,20)
            .overlay {
                HStack{
                    RoundedRectangle(cornerRadius: 10.0)
                        .fill()
                        .frame(width: 6,height: 6)
                    Text("Where to?")
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                        .foregroundStyle(.gray)
                    Spacer()
                }
                .padding(40)
            }
            
        
    }
}

#Preview {
    RectangleInitalView()
}
