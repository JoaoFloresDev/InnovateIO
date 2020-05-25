//
//  DetailsViewController.swift
//  App
//
//  Created by Joao Flores on 21/05/20.
//  Copyright © 2020 Joao Flores. All rights reserved.
//

import UIKit
import os.log

class DetailsWeightViewController: UIViewController, UITableViewDelegate,  UITableViewDataSource {
    var weightDates = [String]()
    var weightValues = [Int32]()

//    MARK: - IBOutlet
    @IBOutlet weak var detailsTableview: UITableView!
    @IBOutlet weak var detaisNavigation: UINavigationItem!
    
    //    MARK: - IBOutlet
    @IBAction func closeView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
//    MARK: - Variables
    var titleDetails = "Detalhes"
    
//    MARK: - LifeCicle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setupTableView()
        detaisNavigation.title = titleDetails
    }
    
    //    MARK: - TableView
    func setupTableView() {
        detailsTableview.delegate = self
        detailsTableview.dataSource = self
        detaisNavigation.leftBarButtonItem = editButtonItem
        detaisNavigation.leftBarButtonItem?.title = "Editar"
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        if(editing) {
            detaisNavigation.leftBarButtonItem?.title = "Concluir"
        }
        else {
            detaisNavigation.leftBarButtonItem?.title = "Editar"
        }
        
        detailsTableview.setEditing(editing, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           print("Deleted")
            weightDates.remove(at: indexPath.row)
            weightValues.remove(at: indexPath.row)
           detailsTableview.beginUpdates()
           detailsTableview.deleteRows(at: [indexPath], with: .automatic)
           detailsTableview.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weightValues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = detailsTableview.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        let valueLabel = cell.viewWithTag(1000) as! UILabel
        valueLabel.text = String(weightValues[weightValues.count - 1 - indexPath[1]]) + " Kg"
        
        let dateLabel = cell.viewWithTag(1001) as! UILabel
        dateLabel.text = weightDates[weightDates.count - 1  - indexPath[1]]
        
        let cellViewWithe = cell.viewWithTag(100)!
        cellViewWithe.layer.cornerRadius = 10
        
        return cell
    }
    
    func loadData() {
        do {
            let plotter = try PlotGraphicClass()
            
            // Getting the current days of week
            let dates: NSMutableArray = []
            let daysOfWeek = Date().getAllDaysForWeek()
            
            for day in daysOfWeek {
                // Getting the current day of the week
                let (_, _, day, _, _, _) = try day.getAllInformations()
                
                // Converting month number into text
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: "pt_BR")
                dateFormatter.setLocalizedDateFormatFromTemplate("MMM")
                let monthString = dateFormatter.string(from: Date())
                
                dates.add("\(day)\n\(monthString)")
            }
            
            var numbersArray = [[Int32]]()
            
            numbersArray = try plotter.loadWeights()
            
            var datesArray = [String]()
            for x in 0...(dates.count - 1) {
                let aString = dates[x]
                let newString = (aString as AnyObject).replacingOccurrences(of: "\n", with: "/")
                datesArray.append(newString)
            }
            
            weightDates = datesArray
            weightValues = numbersArray[0]
        }
        catch {
            os_log("[ERROR] Couldn't communicate with the operating system's internal calendar/time system or memory is too low!")
        }
    }
}
