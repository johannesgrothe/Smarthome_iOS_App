//
//  BridgeManager.swift
//  Smarthome_iOS_App (iOS)
//
//  Created by Emircan Duman on 07.10.21.
//

import Foundation
import CoreData

struct BridgeManager {
    static let shared = BridgeManager()
    
    public static func requestBridgeCredentials() -> NSFetchRequest<BridgeCredentials> {
        let request: NSFetchRequest<BridgeCredentials> = BridgeCredentials.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "address", ascending: true)]
        return request
    }
    
    public func createBridge(viewContext: NSManagedObjectContext, address: String, password: String, username: String){
        let newBridge = BridgeCredentials(context: viewContext)
            newBridge.address = address
            newBridge.password = password
            newBridge.username = username
            PersistenceController.shared.save()
    }
    
    public func deleteBridge(bridge: BridgeCredentials) {
        PersistenceController.shared.delete(bridge)
        PersistenceController.shared.save()
    }
}
