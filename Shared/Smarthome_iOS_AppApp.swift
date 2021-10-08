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
    
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .onChange(of: scenePhase) { (newScenePhase) in
            switch newScenePhase {
            case .background:
                print("App is running in Background save() called")
                persistenceController.save()
            case .inactive:
                print("App is inactive")
            case .active:
                print("App is active")
            @unknown default:
                print("I dont know, ask the Wizard")
            }
        }
    }
}
