//
//  AddDatedMealViewController.swift
//  App
//
//  Created by Priscila Zucato on 08/05/20.
//  Copyright © 2020 Joao Flores. All rights reserved.
//

import UIKit
import os.log

class AddDatedMealViewController: UIViewController {
    @IBOutlet weak var registerMealView: RegisterMealView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var dataHandler: DataHandler?
    var receivedDate: Date? {
        didSet {
            modifiedDate = receivedDate
        }
    }
    var modifiedDate: Date?
    var receivedMeal: Meal? {
        didSet {
            modifiedMeal = receivedMeal
        }
    }
    var modifiedMeal: Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            dataHandler = try DataHandler.getShared()
        } catch {
            print("Couldn't get shared DataHandler.")
        }
        
        datePicker.date = receivedDate ?? Date()
        datePicker.setValue(UIColor.black, forKeyPath: "textColor")
        datePicker.setValue(false, forKeyPath: "highlightsToday")
        
        if let meal = receivedMeal {
            registerMealView.set(meal: meal)
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        registerMealView.setup(delegate: self)
    }
    
    @IBAction func dateChanged(_ sender: UIDatePicker) {
        modifiedDate = sender.date
    }
}

extension AddDatedMealViewController: RegisterMealViewDelegate {
    func saveMeal(quality: Int, hour: Int, minute: Int) {
        guard let date = self.modifiedDate else { return }
        do {
            let (year, month, day, _, _, _) = try date.getAllInformations()
            
            // When received meal is not nil, user is modifying a pre-existing meal. We then  delete the meal he wants to modify and create a new one.
            if let receivedMeal = receivedMeal {
                try dataHandler?.deleteMeal(meal: receivedMeal)
            }
            
            try dataHandler?.createMeal(quality: quality,
            year: year,
            month: month,
            day: day,
            hour: hour,
            minute: minute)
            
        } catch {
            os_log("Couldn't create new meal.")
        }
    }
    
    func presentAlert(_ alert: UIAlertController) {
        self.present(alert, animated: true)
    }
}
