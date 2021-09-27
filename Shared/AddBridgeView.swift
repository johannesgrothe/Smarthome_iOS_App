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
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        HStack {
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("abbort")
            })
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
                let newBridge = BridgeCredentials(context: viewContext)
                newBridge.address = address
                newBridge.password = password
                newBridge.username = username
                do {
                    try viewContext.save()
                } catch {
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
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
//                .autocapitalization(.none)
                .disableAutocorrection(true)
            //            .border(Color(UIColor.separator))
            TextField(
                "Username",
                text: $username
            )
//                .autocapitalization(.none)
                .disableAutocorrection(true)
            SecureField(
                "Password",
                text: $password
            )
//                .autocapitalization(.none)
                .disableAutocorrection(true)
        }
        Spacer()
    }
}
