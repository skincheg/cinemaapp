//
//  CinemaAppApp.swift
//  Shared
//
//  Created by bnkwsr1 on 15.01.2021.
//

import SwiftUI

@main
struct CinemaAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
