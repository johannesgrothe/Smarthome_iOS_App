//
//  BridgeOverviewView.swift
//  Smarthome_iOS_App
//
//  Created by Emircan Duman on 27.09.21.
//

import Foundation
import SwiftUI
import CoreData

struct BridgeOverviewView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \BridgeCredentials.address, ascending: true)],
        animation: .default)
    
    private var bridge_credentials: FetchedResults<BridgeCredentials>
    
    @State private var show_add_bridge_view = false
    
    var body: some View {
        List{
            ForEach(bridge_credentials) { bridge_data in
                NavigationLink(destination: EmptyView()) {
                    VStack{
                        Text(bridge_data.address!)
                        HStack {
                            Text(bridge_data.username!)
                            Text(bridge_data.password!)
                        }
                    }
                }
            }
            .onDelete(perform: deleteBridge)
        }
        .toolbar {
#if os(iOS)
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
#endif
            ToolbarItem {
                Button(action: {self.show_add_bridge_view.toggle()}) {
                    Label("Add Bridge", systemImage: "plus")
                }
            }
        }
        .sheet(isPresented:self.$show_add_bridge_view) {
            AddBridgeView()
        }
    }
    
    private func addBridge() {
        withAnimation {
            let newBridge = BridgeCredentials(context: viewContext)
            newBridge.address = "0.0.0.0"
            newBridge.password = "password"
            newBridge.username = "Spongo"
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func deleteBridge(offsets: IndexSet) {
        withAnimation {
            offsets.map { bridge_credentials[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
