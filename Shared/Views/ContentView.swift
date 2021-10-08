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
