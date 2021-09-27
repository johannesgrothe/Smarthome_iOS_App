//
//  Smarthome_iOS_AppApp.swift
//  Shared
//
//  Created by Emircan Duman on 27.09.21.
//

import SwiftUI

@main
struct Smarthome_iOS_AppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
