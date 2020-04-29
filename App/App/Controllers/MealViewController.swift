//
//  MealViewController.swift
//  App
//
//  Created by Pietro Pugliesi on 07/04/20.
//  Copyright © 2020 Joao Flores. All rights reserved.
//

import UIKit

class MealViewController: UIViewController {
    @IBOutlet weak var thisMealRateView: RatingView!
    @IBOutlet weak var dailyHabitsView: DailyHabitsView!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    let options = ["Refeição", "Exercício", "Água"]
    var selectedDate: Date = Date()
    
    var dataHandler: DataHandler?
    var dailyDiary: DailyDiary?
	

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDatePicker()
        
        do {
            dataHandler = try DataHandler.getShared()
        } catch {
            print("Couldn't get shared DataHandler.")
        }
        
        fetchDailyData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        thisMealRateView.setup()
        dailyHabitsView.setup()
    }
    
    fileprivate func setupDatePicker() {
        datePicker.datePickerMode = .time
        datePicker.minuteInterval = 10
    }
    
    func saveMeal(quality: Int, hour: Int, minute: Int) {
        do {
            try dataHandler?.createMeal(quality: quality, hour: hour, minute: minute)
        } catch {
            print("Couldn't create new meal.")
        }
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
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        selectedDate = sender.date
    }
    
    @IBAction func addMealTapped(_ sender: Any) {
        guard let thisMealRate = thisMealRateView.selectedRating else {
            // TODO: feedback ao usuário ("selecione uma avaliação" ou algo do tipo)
            print("Can't save meal without rating.")
            return
        }
        do {
            print(selectedDate)
            let (_, _, _, hour, minute, _) = try selectedDate.getAllInformations()
            
            saveMeal(quality: thisMealRate.rawValue, hour: hour, minute: minute)
        } catch {
            print("Couldn't get hour and minute from date picker.")
        }
        
    }
}
