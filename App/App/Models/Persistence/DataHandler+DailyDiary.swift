//
//  DataLoader+Meal.swift
//  App
//
//  Created by Vinicius Hiroshi Higa on 22/04/20.
//  Copyright © 2020 Joao Flores. All rights reserved.
//

import Foundation
import CoreData


// An extension that handles the Diary's Data (DBO)
extension DataHandler {
    
    func createDailyDiary(quality: Int, meal: Meal) throws {
        
        // Loading Core Data's User entity
        let entity = NSEntityDescription.entity(forEntityName: "DailyDiary", in: self.managedContext)
        let diary = NSManagedObject(entity: entity!, insertInto: self.managedContext)
        
        // Setting values for the new user
        let (year, month, day, _, _, _) = Date.getAllInformations(Date())()
        
        if year == nil || month == nil || day == nil {
            throw PersistenceError.invalidDate
        }
        
        // Checking for existing previous data
        do {
            let _ = try loadDailyDiary(year: year!, month: month!, day: day!)
            try self.deleteDailyDiary(year: year!, month: month!, day: day!)
        }
        catch { }
        
        diary.setValue(quality, forKey: "quality")
        diary.setValue(year!, forKey: "year")
        diary.setValue(month!, forKey: "month")
        diary.setValue(day!, forKey: "day")

        // Trying to save the new data on local storage
        do {
            try self.managedContext.save()
        }
        catch {
            throw PersistenceError.cantSave
        }
        
    }
    
    
    

    func loadDailyDiary(year: Int, month: Int, day: Int) throws -> DailyDiary {
        
        // Mounting the type of request
        let fetchRequest = NSFetchRequest<DailyDiary>(entityName: "DailyDiary")

        let yearPredicate = NSPredicate(format: "year == %@", String(year))
        let monthPredicate = NSPredicate(format: "month == %@", String(month))
        let dayPredicate = NSPredicate(format: "day == %@", String(day))
        
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [yearPredicate, monthPredicate, dayPredicate])
        
        fetchRequest.predicate = predicate
        
        // Trying to find some User
        do {
            let dailyDiary = try managedContext.fetch(fetchRequest)
            return dailyDiary[0]
        }
        catch {
            throw PersistenceError.cantLoad
        }

    }
    
    
    
    func deleteDailyDiary(year: Int, month: Int, day: Int) throws {
        
        // Mounting the type of request
        let fetchRequest = NSFetchRequest<DailyDiary>(entityName: "DailyDiary")

        let yearPredicate = NSPredicate(format: "year == %@", String(year))
        let monthPredicate = NSPredicate(format: "month == %@", String(month))
        let dayPredicate = NSPredicate(format: "day == %@", String(day))
        
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [yearPredicate, monthPredicate, dayPredicate])
        
        fetchRequest.predicate = predicate
        
        // Trying to find some User
        do {
            let dailyDiary = try self.managedContext.fetch(fetchRequest)
            
            for result in dailyDiary {
                self.managedContext.delete(result)
            }
            
        }
        catch {
            throw PersistenceError.cantLoad
        }
        
    }
    
}
