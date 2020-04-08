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
extension DataLoader {
    
    
    /// Creates a new User entity and saves into the local storage.
    /// - Parameters:
    ///   - name: Name of the User
    ///   - meta: Meta to be achieved
    /// - Throws: An error that says that wasn't possible to write into the local storage
    func createUser(name: String, meta: String) throws {
        
        // Loading Core Data's User entity
        let user = User(context: self.managedContext)
        //let entity = NSEntityDescription.entity(forEntityName: "User", in: self.managedContext)
        //let user = NSManagedObject(entity: entity!, insertInto: self.managedContext)
        
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
    
    
    
    func loadUser() throws {
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        
        do {
            let user = try managedContext.fetch(fetchRequest)
            
            print(user)
            
        }
        catch let error as NSError {
            throw error
        }
        
    }
    
}
