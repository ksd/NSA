//
//  NSAApp.swift
//  NSA
//
//  Created by ksd on 30/03/2022.
//

import SwiftUI
import Firebase

@main
struct NSAApp: App {
    @StateObject private var myStateController = StateController()
    
    init() {
        FirebaseApp.configure()
      }

    var body: some Scene {
        WindowGroup {
            ListUsers().environmentObject(myStateController)
        }
    }
}
