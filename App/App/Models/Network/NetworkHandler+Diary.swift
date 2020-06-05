//
//  NetworkHandler+Diary.swift
//  App
//
//  Created by Vinicius Hiroshi Higa on 04/06/20.
//  Copyright © 2020 Joao Flores. All rights reserved.
//

import Foundation
import CoreData
import CloudKit
import os.log

extension NetworkHandler {
    
    func createDiary(diary: DailyDiary) {
        
        // Converting all values into Int with length of 64 bits
        let day: Int64 = Int64(diary.day)
        let month: Int64 = Int64(diary.month)
        let year: Int64 = Int64(diary.year)
        let quality: Int64 = Int64(diary.quality)
        
        var didDrinkWater: Int64 = 0
        var didEatFruit: Int64 = 0
        var didPracticeExercise: Int64 = 0
        
        if diary.didDrinkWater {
            didDrinkWater = 1
        }
        
        if diary.didEatFruit {
            didEatFruit = 1
        }
        
        if diary.didPracticeExercise {
            didPracticeExercise = 1
        }
        
        
        
        // Setting the values for the record
        let record = CKRecord(recordType: "DailyDiary")
        
        record.setValue(day, forKey: "day")
        record.setValue(month, forKey: "month")
        record.setValue(year, forKey: "year")
        record.setValue(quality, forKey: "quality")
        record.setValue(didDrinkWater, forKey: "didDrinkWater")
        record.setValue(didEatFruit, forKey: "didEatFruit")
        record.setValue(didPracticeExercise, forKey: "didPracticeExercise")
        
        
        
        // Trying to save finally the data into the cloud...
        self.container.privateCloudDatabase.save(record) { (savedRecord, error) in
            
            if error == nil {
                
                print("[DEBUG] Record Saved")
                
            } else {
                
                print("[DEBUG] Record Not Saved")
                
            }
            
        }
        
    }
    
}
