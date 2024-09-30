//
//  TwoPointsShapeView.swift
//  Ex_Uber_Demo
//
//  Created by Ahmad Ellashy on 23/09/2024.
//

import SwiftUI

struct TwoPointsShapeView: View {
    var body: some View {
        VStack{
            Circle()
                .fill()
                .frame(width:5,height: 5)
                .foregroundStyle(.gray)
            Rectangle()
                .fill()
                .frame(width: 3,height: 40)
            Circle()
                .fill()
                .frame(width:8,height: 8)
                .foregroundStyle(.black)
        }
    }
}

#Preview {
    TwoPointsShapeView()
}
