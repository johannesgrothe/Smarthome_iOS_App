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
    
    @State private var show_add_bridge_view: Bool = false
    
    private let bridge_manager: BridgeManager = .shared
    
    @FetchRequest(fetchRequest: BridgeManager.requestBridgeInfoContainers())
    var bridge_credentials: FetchedResults<BridgeInfoContainer>
    
    var body: some View {

        List{
            ForEach(bridge_credentials) { bridge_data in
                NavigationLink(destination: ConnectionEnabledView(bridge_data: bridge_data)) {
                    VStack(alignment: .leading){
                        Text(bridge_data.name!)
                            .font(Font.headline.weight(.bold))
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
    
    private func deleteBridge(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                let bridge = bridge_credentials[index]
                bridge_manager.deleteBridge(bridge: bridge)
            }
        }
    }
}
