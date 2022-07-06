//
//  EmptyView.swift
//  Smarthome_iOS_App
//
//  Created by Emircan Duman on 27.09.21.
//

import Foundation
import SwiftUI

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var bridge_name: String
    var git_version: Optional<String>
    var pipenv_version: Optional<String>
    var platformio_version: Optional<String>
    var python_version: Optional<String>
    var running_since: String //Date
    var software_branch: Optional<String>
    var software_commit: Optional<String>
    
//    "bridge_name": "<string>",
//    "git_version": "Optional<string>",
//    "pipenv_version": "Optional<string>",
//    "platformio_version": "Optional<string>",
//    "python_version": "Optional<string>",
//    "running_since": "<string>",
//    "software_branch": "Optional<string>",
//    "software_commit": "Optional<string>"
    
}

@available(iOS 15.0, *)
struct ConnectionEnabledView: View {
    let bridge_data: BridgeInfoContainer
    @State private var results = [Result]()
    
    var body: some View {
        let bridge_adress: String = "IP: \(bridge_data.ip):\(bridge_data.port)"
        
        Text("Connected to")
        Text(bridge_data.name!)
        Text("(" + bridge_adress + ")")

        List(results, id: \.bridge_name) { key in
            VStack(alignment: .leading) {
                Text(key.bridge_name)
                    .font(.headline)
                Text("item.running_since")
            }
        }
        .task {
            await loadBridgeInfoData()
        }
    }
    
    func loadBridgeInfoData() async {
        guard let url = URL(string: "http://\(bridge_data.ip!):\(bridge_data.port)/info/bridge") else {
            print("Invalid URL")
            print("http://\(bridge_data.ip):\(bridge_data.port)/info/bridge")
            return
        }
        
        do {
            let username: String = bridge_data.username ?? ""
            let password: String = bridge_data.password ?? ""
            let authData = (username + ":" + password).data(using: .utf8)!.base64EncodedString()
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("Basic \(authData)", forHTTPHeaderField: "Authorization")
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                DispatchQueue.main.async {
                    if error != nil || (response as! HTTPURLResponse).statusCode != 200 {
                        print("[ERROR Statuscode]: @",(response as! HTTPURLResponse).statusCode)
                        if error != nil {
                            print(error)
                        } else {
                            print("no error msg")
                        }
                    } else if let data = data {
                        do {
                            let bridgeInfoResponse = try JSONDecoder().decode(Result.self, from: data)

                            print(bridgeInfoResponse.bridge_name)
                            print(bridgeInfoResponse.running_since)

                        } catch {
                            print("Unable to Decode Response \(error)")
                        }
                    }
                }
            }.resume()
        } catch {
            print("Invalid data")
            print(url)
        }
    }
}
