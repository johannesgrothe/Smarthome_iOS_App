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
    
    public static func requestBridgeInfoContainers() -> NSFetchRequest<BridgeInfoContainer> {
        let request: NSFetchRequest<BridgeInfoContainer> = BridgeInfoContainer.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        return request
    }
    
    public func createBridge(viewContext: NSManagedObjectContext, name: String, ip: String, port: Int16, password: String, username: String){
        let newBridge = BridgeInfoContainer(context: viewContext)
            newBridge.name = name
            newBridge.ip = ip
            newBridge.port = port
            newBridge.password = password
            newBridge.username = username
            PersistenceController.shared.save()
    }
    
    public func deleteBridge(bridge: BridgeInfoContainer) {
        PersistenceController.shared.delete(bridge)
        PersistenceController.shared.save()
    }
}
