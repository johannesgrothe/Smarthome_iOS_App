//
//  AddBridgeView.swift
//  Smarthome_iOS_App
//
//  Created by Emircan Duman on 27.09.21.
//

import Foundation
import SwiftUI
import CoreData

class NumFieldString: ObservableObject {
    @Published var value = "" {
        didSet {
            let filtered = value.filter { $0.isNumber }
                        
            if value != filtered {
                value = filtered
            }
        }
    }
    
    func getAsNum() -> Int16 {
        return Int16(value) ?? 0
    }
}

struct AddBridgeView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var viewContext
    
    private let bridge_manager: BridgeManager = .shared
    @State private var name: String = ""
    @State private var ip: String = ""
    @State private var port: NumFieldString = NumFieldString()
    @State private var username: String = ""
    @State private var password: String = ""
    
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
                        text: $port.value
                    )
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .keyboardType(.decimalPad)
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
                        let port: Int16 = port.getAsNum()
                        
                        self.presentationMode.wrappedValue.dismiss()

                        bridge_manager.createBridge(viewContext: self.viewContext, name: self.name, ip: self.ip, port: port, password: self.password, username: self.username)
                    }
                }
            }
        }
    }
}
