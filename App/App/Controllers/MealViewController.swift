//
//  MealViewController.swift
//  App
//
//  Created by Pietro Pugliesi on 07/04/20.
//  Copyright © 2020 Joao Flores. All rights reserved.
//

import UIKit

class MealViewController: UIViewController {
	@IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var thisMealRateView: RatingView!
    @IBOutlet weak var dayMealRatingView: RatingView!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    let options = ["Refeição", "Exercício", "Água"]
    
    var dataHandler: DataHandler?
    var dailyDiary: DailyDiary?
	

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
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
        dayMealRatingView.setup()
    }
    
    fileprivate func setupTableView() {
            tableView.delegate = self
            tableView.dataSource = self
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
                dayMealRatingView.selectedRating = Rating(rawValue: dayQuality)
            }
        } catch {
            print("There's still no daily data for today or something went wrong when trying to fetch.")
        }
    }
    
    @IBAction func addMealTapped(_ sender: Any) {
        guard let thisMealRate = thisMealRateView.selectedRating else {
            // TODO: feedback ao usuário ("selecione uma avaliação" ou algo do tipo)
            print("Can't save meal without rating.")
            return
        }
        do {
            let (_, _, _, hour, minute, _) = try datePicker.date.getAllInformations()
            
            saveMeal(quality: thisMealRate.rawValue, hour: hour, minute: minute)
        } catch {
            print("Couldn't get hour and minute from date picker.")
        }
        
    }
}

extension MealViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 3
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.mealCell.identifier) else {
            print("Couldn't find cell with identifier \(R.reuseIdentifier.mealCell.identifier)")
            return UITableViewCell()
        }

		cell.textLabel?.text = options[indexPath.row]

		return cell
	}
}
