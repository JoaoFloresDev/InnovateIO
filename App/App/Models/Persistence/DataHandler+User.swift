//
//  DataLoader + User.swift
//  App
//
//  Created by Vinicius Hiroshi Higa on 07/04/20.
//  Copyright © 2020 Joao Flores. All rights reserved.
//

import Foundation
import CoreData


// An extension that handles the User's Data (DBO)
extension DataHandler {
    
    
    
    /// Creates a new User entity and saves into the local storage.
    /// - Parameters:
    ///   - name: Name of the User
    ///   - meta: Meta to be achieved
    /// - Throws: An error that says that isn't possible to write into the local storage
    func createUser(name: String, meta: String) throws {
        
        // Loading Core Data's User entity
        let entity = NSEntityDescription.entity(forEntityName: "User", in: self.managedContext)
        let user = NSManagedObject(entity: entity!, insertInto: self.managedContext)
        
        // Setting values for the new user
        user.setValue(name, forKey: "name")
        user.setValue(meta, forKey: "meta")

        // Trying to save the new data on local storage
        do {
            try self.managedContext.save()
        }
        catch let error as NSError {
            throw error
        }
        
    }
    
    
    
    /// Loads an existing Users entity from the local storage.
    /// - Throws: An error that says isn't possible to load the user
    /// - Returns: An object of the User
    func loadUser() throws -> User {
        
        // Mounting the type of request
        let fetchRequest = NSFetchRequest<User>(entityName: "User")

        // Trying to find some User
        do {
            let users = try managedContext.fetch(fetchRequest)
            return users[0]
        }
        catch let error as NSError {
            throw error
        }

    }
    
}
