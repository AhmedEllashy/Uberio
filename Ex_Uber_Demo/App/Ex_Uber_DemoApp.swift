//
//  Ex_Uber_DemoApp.swift
//  Ex_Uber_Demo
//
//  Created by Ahmad Ellashy on 23/09/2024.
//

import SwiftUI

@main
struct Ex_Uber_DemoApp: App {
    @StateObject var locationSearchViewModel = LocationSearchViewModel()
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(locationSearchViewModel)
        }
    }
}
