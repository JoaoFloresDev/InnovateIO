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
    //private(set) var container: NSPersistentCloudKitContainer
    private(set) var container: CKContainer
    
    

    private init() throws {

//        self.container = NSPersistentCloudKitContainer(name: "Innovate")
//
//        // Getting the store description
//        guard let description = container.persistentStoreDescriptions.first else {
//            throw NetworkError.invalidContainer
//        }
//
//        // Initializing the CloudKit schema
//        let id = "iCloud.Innovate"
//        let options = NSPersistentCloudKitContainerOptions(containerIdentifier: id)
//        description.cloudKitContainerOptions = options
//
        
        //let record = self.container.record(for: "DailyDiary")
        

        self.container = CKContainer(identifier: "iCloud.Innovate")
        
        self.container.accountStatus { status, error in
            if let _ = error {
                // some error occurred (probably a failed connection, try again)
                print("[DEBUG] erro no cloud kit")
            } else {
                switch status {
                case .available:
                // the user is logged in
                    print("[DEBUG] conta logada no iCloud")
                    break
                case .noAccount:
                // the user is NOT logged in
                    print("[DEBUG] sem conta")
                    break
                case .couldNotDetermine:
                    print("[DEBUG] impossivel determinar")
                // for some reason, the status could not be determined (try again)
                    break
                case .restricted:
                    print("[DEBUG] conta protegida por controle parental")
                    // iCloud settings are restricted by parental controls or a configuration profile
                    break
                }
            }
        }
        
        // Pegando o ID do usuário no BD
        self.container.fetchUserRecordID { recordID, error in
            guard let recordID = recordID, error == nil else {
                // error handling magic
                print("[DEBUG] \(error.debugDescription)")
                return
            }
            
            print("[DEBUG] Got user record ID \(recordID.recordName).")
        }
        
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
