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
        request.sortDescriptors = [NSSortDescriptor(key: "ip", ascending: true)]
        return request
    }
    
    public func createBridge(viewContext: NSManagedObjectContext, name: String, ip: String, port: String, password: String, username: String){
        let newBridge = BridgeCredentials(context: viewContext)
            newBridge.name = name
            newBridge.ip = ip
            newBridge.port = port
            newBridge.password = password
            newBridge.username = username
            PersistenceController.shared.save()
    }
    
    public func deleteBridge(bridge: BridgeCredentials) {
        PersistenceController.shared.delete(bridge)
        PersistenceController.shared.save()
    }
}
