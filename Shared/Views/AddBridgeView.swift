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
    @State private var address: String = ""
    @State private var username: String = ""
    @State private var password: String = ""
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var viewContext
    
    private let bridge_manager: BridgeManager = .shared
    
    var body: some View {

        HStack {
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("abbort")
            })
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
                
                bridge_manager.createBridge(viewContext: self.viewContext, address: self.address, password: self.password, username: self.username)
            }, label: {
                Text("save")
            })
            Spacer()
        }
        VStack {
            TextField(
                "Bridge Address/Ip",
                text: $address
            )
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .border(Color(UIColor.separator))
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
        Spacer()
    }
}
