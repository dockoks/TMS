//
//  ResumerApp.swift
//  Resumer
//
//  Created by Danila Kokin on 11/27/24.
//

import SwiftUI

@main
struct ResumerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                RootView()
            }
        }
    }
}
