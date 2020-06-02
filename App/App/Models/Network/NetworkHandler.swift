//
//  NetworkHandler.swift
//  App
//
//  Created by Vinicius Hiroshi Higa on 02/06/20.
//  Copyright © 2020 Joao Flores. All rights reserved.
//

import Foundation
import CoreData
import CloudKit

class NetworkHandler {
    
    // Singleton related
    private static var shared: NetworkHandler?
    
    // Default properties related to the DAO (DataLoader)
    private(set) var container: NSPersistentCloudKitContainer
    
    
    /// Initializes the Singleton with the "ScratchPad" (Managed Object Context) for loading and saving data in the iOS  internal Database.
    /// - Throws: An error that says the App wasn't fully initilized yet for managing data
    private init() throws {

        self.container = NSPersistentCloudKitContainer(name: "Innovate")
        
        // get the store description
        guard let description = container.persistentStoreDescriptions.first else {
            fatalError("Could not retrieve a persistent store description.")
        }

        // initialize the CloudKit schema
        let id = "iCloud.Innovate"
        let options = NSPersistentCloudKitContainerOptions(containerIdentifier: id)
        description.cloudKitContainerOptions = options
        
    }
    
    
    
    /// Gets the shared instance of DataLoader.
    /// - Throws: An error that says the App wasn't fully initialized yet for managing data
    /// - Returns: A shared instance / singleton of DataLoader for managing data
    static func getShared() throws -> NetworkHandler {
        
        if (NetworkHandler.shared == nil) {
            do {
                NetworkHandler.shared = try NetworkHandler()
            }
            catch let error as NetworkError {
                throw error
            }
        }
        
        return NetworkHandler.shared!
    }
}
