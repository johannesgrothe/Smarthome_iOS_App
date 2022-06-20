//
//  EmptyView.swift
//  Smarthome_iOS_App
//
//  Created by Emircan Duman on 27.09.21.
//

import Foundation
import SwiftUI

struct ConnectionEnabledView: View {
    let bridge_data: BridgeCredentials
    var body: some View {
        let bridge_adress: String = bridge_data.ip! + ":" + bridge_data.port!
        
        Text("Connected to")
        Text(bridge_data.name!)
        Text("(" + bridge_adress + ")")
    }
}
