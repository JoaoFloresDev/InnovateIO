//
//  MealViewController.swift
//  App
//
//  Created by Pietro Pugliesi on 07/04/20.
//  Copyright © 2020 Joao Flores. All rights reserved.
//

import UIKit

class MealViewController: UIViewController {
    @IBOutlet weak var registerMealView: RegisterMealView!
    @IBOutlet weak var dailyHabitsView: DailyHabitsView!
    
    var dataHandler: DataHandler?
    var dailyDiary: DailyDiary?
	

    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            dataHandler = try DataHandler.getShared()
        } catch {
            print("Couldn't get shared DataHandler.")
        }
        
        fetchDailyData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        dailyHabitsView.setup()
        registerMealView.setup(delegate: self)
    }
    
    func updateDailyData() {
        guard let dailyDiary = self.dailyDiary else { return }
        do {
            try dataHandler?.createDailyDiary(quality: Int(dailyDiary.quality),
                                              didDrinkWater: dailyDiary.didDrinkWater,
                                              didPracticeExercise: dailyDiary.didPracticeExercise,
                                              didEatFruit: dailyDiary.didEatFruit)
        } catch {
            print("Couldn't update daily diary.")
        }
    }
    
    func fetchDailyData() {
        do {
            let date = Date()
            let (year, month, day, _, _, _) = try date.getAllInformations()
            dailyDiary = try dataHandler?.loadDailyDiary(year: year, month: month, day: day)
            if let dayQuality32 = dailyDiary?.quality {
                let dayQuality = Int(dayQuality32)
                dailyHabitsView.selectedRating = Rating(rawValue: dayQuality)
            }
        } catch {
            print("There's still no daily data for today or something went wrong when trying to fetch.")
        }
    }
}

extension MealViewController: RegisterMealViewDelegate {
    func saveMeal(quality: Int, hour: Int, minute: Int) {
        do {
            try dataHandler?.createMeal(quality: quality, hour: hour, minute: minute)
        } catch {
            print("Couldn't create new meal.")
        }
    }
    
    func presentAlert(_ alert: UIAlertController) {
        self.present(alert, animated: true)
    }
}
