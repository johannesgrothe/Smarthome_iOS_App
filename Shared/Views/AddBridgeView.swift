//
//  AddBridgeView.swift
//  Smarthome_iOS_App
//
//  Created by Emircan Duman on 27.09.21.
//

import Foundation
import SwiftUI
import CoreData

struct AddBridgeView: View {
    @State private var name: String = ""
    @State private var ip: String = ""
    @State private var port: String = ""
    @State private var username: String = ""
    @State private var password: String = ""
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var viewContext
    
    private let bridge_manager: BridgeManager = .shared
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Bridge Connection Details")) {
                    
                    TextField(
                        "Name",
                        text: $name
                    )
                    TextField(
                        "Bridge IP",
                        text: $ip
                    )
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    TextField(
                        "Bridge Port",
                        text: $port
                    )
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                
                Section(header: Text("Authentication Details")) {
                    TextField(
                        "Username",
                        text: $username
                    )
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    SecureField(
                        "Password",
                        text: $password
                    )
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Dismiss") {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        self.presentationMode.wrappedValue.dismiss()

                        bridge_manager.createBridge(viewContext: self.viewContext, name: self.name, ip: self.ip, port: self.port, password: self.password, username: self.username)
                    }
                }
            }
        }
    }
}
