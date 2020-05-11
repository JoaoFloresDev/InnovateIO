//
//  MealHistoryViewController.swift
//  App
//
//  Created by Priscila Zucato on 06/05/20.
//  Copyright © 2020 Joao Flores. All rights reserved.
//

import UIKit
import os.log

class MealHistoryViewController: UIViewController {
    @IBOutlet weak var historyTableView: UITableView!
    
    var dataHandler: DataHandler?
    var receivedDates: [Date] = [] {
        didSet {
            fetchMeals()
        }
    }
    var meals: [Date : [Meal]] = [:]
    var dateSelected: Date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()

        do {
            dataHandler = try DataHandler.getShared()
        } catch {
            os_log("Couldn't get shared DataHandler.")
        }
        
        // TODO: tirar depois
        let today = Date()
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        let beforeYesterday = Calendar.current.date(byAdding: .day, value: -2, to: today)!
        receivedDates = [beforeYesterday, yesterday, today]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchMeals()
    }
    
    func fetchMeals() {
        for date in receivedDates {
            do {
                let (year, month, day, _, _, _) = try date.getAllInformations()
                let mealsForDate = try dataHandler?.loadMeals(year: year, month: month, day: day)
                meals[date] = orderByTime(mealsForDate ?? [])
            } catch {
                os_log("Couldn't fetch meals for date.")
            }
        }
        
        historyTableView.reloadData()
    }
    
    func orderByTime(_ meals: [Meal]) -> [Meal] {
        return meals.sorted { (meal1, meal2) -> Bool in
            if meal1.hour != meal2.hour {
                return meal1.hour < meal2.hour
            } else {
                return meal1.minute < meal2.minute
            }
        }
    }
    
    func setupTableView() {
        historyTableView.register(UINib(resource: R.nib.mealHistoryTableViewCell),
                                  forCellReuseIdentifier: R.reuseIdentifier.mealHistoryTableViewCell.identifier)
        historyTableView.register(UINib(resource: R.nib.mealHistoryHeader),
                                  forHeaderFooterViewReuseIdentifier: "MealHistoryHeader")
        historyTableView.delegate = self
        historyTableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == R.segue.mealHistoryViewController.toRegisterMeal.identifier
        {
            let vc = segue.destination as? AddDatedMealViewController
            vc?.receivedDate = dateSelected
        }
    }
}

extension MealHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return receivedDates.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let date = receivedDates[section]
        let sectionMeals = meals[date]
        
        return sectionMeals?.count == 0 || sectionMeals == nil ? 1 : sectionMeals!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.mealHistoryTableViewCell.identifier) as? MealHistoryTableViewCell else {
            return UITableViewCell()
        }
        
        let date = receivedDates[indexPath.section]
        var meal: Meal?
        if meals[date]?.count ?? 0 > indexPath.row {
            meal = meals[date]?[indexPath.row]
        }
        
        cell.setup(meal: meal)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MealHistoryHeader") as? MealHistoryHeader else {
            return nil
        }
        
        let date = receivedDates[section]
        header.setup(date: date, delegate: self)
        
        return header
    }
}

extension MealHistoryViewController: MealHistoryHeaderDelegate {
    func plusButtonTapped(date: Date) {
        self.dateSelected = date
        performSegue(withIdentifier: R.segue.mealHistoryViewController.toRegisterMeal.identifier, sender: nil)
    }
}
