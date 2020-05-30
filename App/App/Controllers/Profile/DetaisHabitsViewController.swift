//
//  DetaisHabitsViewController.swift
//  App
//
//  Created by Joao Flores on 24/05/20.
//  Copyright © 2020 Joao Flores. All rights reserved.
//

import UIKit
import os.log

class DetaisHabitsViewController: UIViewController, UITableViewDelegate,  UITableViewDataSource {
    var weightDates = [String]()
    var weightValues = [Int32]()

//    MARK: - IBOutlet
    @IBOutlet weak var detailsTableView: UITableView!
    
    @IBOutlet weak var detailsNavigation: UINavigationItem!
    
    //    MARK: - IBOutlet
    @IBAction func closeView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
//    MARK: - Variables
    
//    MARK: - LifeCicle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setupTableView()
    }
    
    //    MARK: - TableView
    func setupTableView() {
        detailsTableView.delegate = self
        detailsTableView.dataSource = self
        detailsNavigation.leftBarButtonItem = editButtonItem
        detailsNavigation.leftBarButtonItem?.title = "Editar"
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        if(editing) {
            detailsNavigation.leftBarButtonItem?.title = "Concluir"
        }
        else {
            detailsNavigation.leftBarButtonItem?.title = "Editar"
        }
        
        detailsTableView.setEditing(editing, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           print("Deleted")
            weightDates.remove(at: indexPath.row)
            weightValues.remove(at: indexPath.row)
           detailsTableView.beginUpdates()
           detailsTableView.deleteRows(at: [indexPath], with: .automatic)
           detailsTableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weightValues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = detailsTableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        var valueLabel = cell.viewWithTag(1000) as! UILabel
        valueLabel.text = String(weightValues[weightValues.count - 1 - indexPath[1]])

        valueLabel = cell.viewWithTag(1001) as! UILabel
        valueLabel.text = String(weightValues[weightValues.count - 1 - indexPath[1]])
        
        valueLabel = cell.viewWithTag(1002) as! UILabel
        valueLabel.text = String(weightValues[weightValues.count - 1 - indexPath[1]])

        let dateLabel = cell.viewWithTag(1003) as! UILabel
        dateLabel.text = weightDates[weightDates.count - 1  - indexPath[1]]
        

        let cellViewWithe = cell.viewWithTag(100)!
        cellViewWithe.layer.cornerRadius = 10
        
        return cell
    }
    
    func loadData() {
        do {
            let plotter = try PlotGraphicClass()
            
            let months = plotter.getMonths()
            
            // Getting the current days last two months
            let dates: NSMutableArray = plotter.getDates(months)
            
            // Starting to populate and draw the charts...
            let numbersArray: [[Int32]] = plotter.getHabitsValues(months)
            
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
