//
//  ContentView.swift
//  Shared
//
//  Created by Emircan Duman on 27.09.21.
//

import SwiftUI
import CoreData

struct ContentView: View {

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink("Bridges", destination: BridgeOverviewView())
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
