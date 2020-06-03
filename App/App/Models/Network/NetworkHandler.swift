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
    
    

    private init() throws {

        self.container = NSPersistentCloudKitContainer(name: "Innovate")
        
        // Getting the store description
        guard let description = container.persistentStoreDescriptions.first else {
            throw NetworkError.invalidContainer
        }

        // Initializing the CloudKit schema
        let id = "iCloud.Innovate"
        let options = NSPersistentCloudKitContainerOptions(containerIdentifier: id)
        description.cloudKitContainerOptions = options
        
        
        #if DEBUG
            //let record = self.container.record(for: "DailyDiary")
        

        CKContainer.default().accountStatus { status, error in
            if let error = error {
                // some error occurred (probably a failed connection, try again)
                print("erro no cloud kit")
            } else {
                switch status {
                case .available:
                // the user is logged in
                    print("aqui")
                    break
                case .noAccount:
                // the user is NOT logged in
                    print("sem conta")
                    break
                case .couldNotDetermine:
                    print("impossivel determinar")
                // for some reason, the status could not be determined (try again)
                    break
                case .restricted:
                    print("conta protegida por controle parental")
                    // iCloud settings are restricted by parental controls or a configuration profile
                    break
                }
            }
        }
        
        #endif
        
    }
    
    
    
    /// Gets the shared instance of Network Handler.
    /// - Throws: An error that says the App wasn't fully initialized yet for managing data
    /// - Returns: A shared instance / singleton of Network Handler for managing iCloud's data
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
