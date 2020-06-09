//
//  MockService.swift
//  App
//
//  Created by Priscila Zucato on 08/06/20.
//  Copyright © 2020 Joao Flores. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class MockService {
    func deleteAllData() {
        deleteAllData(entity: "DailyDiary")
        deleteAllData(entity: "Meal")
        deleteAllData(entity: "Weight")
    }
    
    private func deleteAllData(entity: String)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false

        do
        {
            let results = try managedContext.fetch(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }
        } catch let error as NSError {
            print("Detele all data in \(entity) error : \(error) \(error.userInfo)")
        }
    }
    
    func mockAllData() {
        mockMeals()
        mockDailyDiary()
        mockWeights()
    }
    
    private func mockMeals() {
        do {
            let dataHandler = try DataHandler.getShared()
            
            try dataHandler.createMeal(quality: Rating.good.rawValue, year: 2020, month: 6, day: 1, hour: 7, minute: 30, note: "Ate bananas and yogurt")
            try dataHandler.createMeal(quality: Rating.average.rawValue, year: 2020, month: 6, day: 1, hour: 12, minute: 30, note: "Ate sausages")
            try dataHandler.createMeal(quality: Rating.bad.rawValue, year: 2020, month: 6, day: 1, hour: 22, minute: 0, note: "Too tired to cook, ate an hamburguer")
            
            try dataHandler.createMeal(quality: Rating.good.rawValue, year: 2020, month: 6, day: 2, hour: 8, minute: 0, note: "Ate an apple and a banana")
            try dataHandler.createMeal(quality: Rating.average.rawValue, year: 2020, month: 6, day: 2, hour: 12, minute: 0, note: "Ate sausages")
            try dataHandler.createMeal(quality: Rating.bad.rawValue, year: 2020, month: 6, day: 2, hour: 21, minute: 0, note: "Tired again, ate pasta")
            
            try dataHandler.createMeal(quality: Rating.good.rawValue, year: 2020, month: 6, day: 3, hour: 8, minute: 30, note: "Ate fruits with honey")
            try dataHandler.createMeal(quality: Rating.good.rawValue, year: 2020, month: 6, day: 3, hour: 11, minute: 30, note: "Ate rice, beans, lettuce")
            try dataHandler.createMeal(quality: Rating.good.rawValue, year: 2020, month: 6, day: 3, hour: 20, minute: 30, note: "Ate a salad")
            
            try dataHandler.createMeal(quality: Rating.good.rawValue, year: 2020, month: 6, day: 4, hour: 7, minute: 0, note: "Ate oranges")
            try dataHandler.createMeal(quality: Rating.average.rawValue, year: 2020, month: 6, day: 4, hour: 12, minute: 0, note: "Ate too much rice")
            try dataHandler.createMeal(quality: Rating.bad.rawValue, year: 2020, month: 6, day: 4, hour: 21, minute: 30, note: "Not in the mood to cook, ate an hamburguer")
            
            try dataHandler.createMeal(quality: Rating.good.rawValue, year: 2020, month: 6, day: 5, hour: 8, minute: 30, note: "Ate oranges and an apple")
            try dataHandler.createMeal(quality: Rating.average.rawValue, year: 2020, month: 6, day: 5, hour: 12, minute: 30, note: "Didn't eat salad")
            try dataHandler.createMeal(quality: Rating.bad.rawValue, year: 2020, month: 6, day: 5, hour: 19, minute: 30, note: "Ate two hot dogs")
            
            try dataHandler.createMeal(quality: Rating.average.rawValue, year: 2020, month: 6, day: 6, hour: 9, minute: 0, note: "Ate too much bread.")
            try dataHandler.createMeal(quality: Rating.average.rawValue, year: 2020, month: 6, day: 6, hour: 12, minute: 0, note: "Ate too much rice.")
            try dataHandler.createMeal(quality: Rating.bad.rawValue, year: 2020, month: 6, day: 6, hour: 20, minute: 0, note: "Ate an hamburguer.")
            
            try dataHandler.createMeal(quality: Rating.good.rawValue, year: 2020, month: 6, day: 7, hour: 7, minute: 30, note: "Ate bananas and yogurt.")
            try dataHandler.createMeal(quality: Rating.good.rawValue, year: 2020, month: 6, day: 7, hour: 12, minute: 30, note: "Ate rice, beans, broccolli, chicken breast.")
            try dataHandler.createMeal(quality: Rating.average.rawValue, year: 2020, month: 6, day: 7, hour: 21, minute: 0, note: "Tired. Ate pasta.")
            
            try dataHandler.createMeal(quality: Rating.good.rawValue, year: 2020, month: 6, day: 8, hour: 8, minute: 0, note: "Ate apples and bananas.")
            try dataHandler.createMeal(quality: Rating.average.rawValue, year: 2020, month: 6, day: 8, hour: 12, minute: 0, note: "Didn't eat any salad.")
            try dataHandler.createMeal(quality: Rating.bad.rawValue, year: 2020, month: 6, day: 8, hour: 20, minute: 30, note: "Ate instant noodles.")
        } catch {
            print("Error mocking meals")
        }
    }
    
    private func mockDailyDiary() {
        do {
            let dataHandler = try DataHandler.getShared()

            try dataHandler.createDailyDiary(year: 2020, month: 6, day: 1, quality: 0, didDrinkWater: true, didPracticeExercise: false, didEatFruit: true)
            try dataHandler.createDailyDiary(year: 2020, month: 6, day: 2, quality: 0, didDrinkWater: true, didPracticeExercise: true, didEatFruit: false)
            try dataHandler.createDailyDiary(year: 2020, month: 6, day: 3, quality: 1, didDrinkWater: true, didPracticeExercise: true, didEatFruit: true)
            try dataHandler.createDailyDiary(year: 2020, month: 6, day: 4, quality: 0, didDrinkWater: true, didPracticeExercise: false, didEatFruit: false)
            try dataHandler.createDailyDiary(year: 2020, month: 6, day: 5, quality: -1, didDrinkWater: false, didPracticeExercise: false, didEatFruit: false)
            try dataHandler.createDailyDiary(year: 2020, month: 6, day: 6, quality: 0, didDrinkWater: true, didPracticeExercise: true, didEatFruit: false)
            try dataHandler.createDailyDiary(year: 2020, month: 6, day: 7, quality: 1, didDrinkWater: true, didPracticeExercise: true, didEatFruit: true)
            try dataHandler.createDailyDiary(year: 2020, month: 6, day: 8, quality: 0, didDrinkWater: true, didPracticeExercise: false, didEatFruit: true)
        } catch {
            print("Error mocking diaries")
        }
    }
    
    private func mockWeights() {
        do {
            let dataHandler = try DataHandler.getShared()
            
            var dateComponents = DateComponents()
            dateComponents.year = 2020
            dateComponents.month = 6
            dateComponents.day = 1
            let userCalendar = Calendar.current
            var date = userCalendar.date(from: dateComponents)

            try dataHandler.createWeight(value: 50, date: date)
            
            dateComponents.day = 2
            date = userCalendar.date(from: dateComponents)
            try dataHandler.createWeight(value: 50.2, date: date)
            
            dateComponents.day = 3
            date = userCalendar.date(from: dateComponents)
            try dataHandler.createWeight(value: 50.4, date: date)
            
            dateComponents.day = 4
            date = userCalendar.date(from: dateComponents)
            try dataHandler.createWeight(value: 50.5, date: date)
            
            dateComponents.day = 5
            date = userCalendar.date(from: dateComponents)
            try dataHandler.createWeight(value: 50.6, date: date)
            
            dateComponents.day = 6
            date = userCalendar.date(from: dateComponents)
            try dataHandler.createWeight(value: 50.6, date: date)
            
            dateComponents.day = 7
            date = userCalendar.date(from: dateComponents)
            try dataHandler.createWeight(value: 50.6, date: date)
            
            dateComponents.day = 8
            date = userCalendar.date(from: dateComponents)
            try dataHandler.createWeight(value: 50.2, date: date)
        } catch {
            print("Error mocking weights")
        }
    }
}
