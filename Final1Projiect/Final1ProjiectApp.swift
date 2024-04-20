//
//  Final1ProjiectApp.swift
//  Final1Projiect
//
//  Created by 梁大可 on 2023/8/14.
//

import SwiftUI

@main
struct Final1ProjiectApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .defaultAppStorage(UserDefaults(suiteName: "group.LKmade.Final1Projiect")!)
        }
    }
}
