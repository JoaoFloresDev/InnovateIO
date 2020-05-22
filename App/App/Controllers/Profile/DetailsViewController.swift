//
//  DetailsViewController.swift
//  App
//
//  Created by Joao Flores on 21/05/20.
//  Copyright © 2020 Joao Flores. All rights reserved.
//

import UIKit
import os.log

class DetailsViewController: UIViewController, UITableViewDelegate,  UITableViewDataSource {
    
//    MARK: - IBOutlet
    @IBOutlet weak var detailsTableview: UITableView!
    
    @IBOutlet weak var detaisNavigation: UINavigationItem!
    
    //    MARK: - IBOutlet
    @IBAction func showEdit(_ sender: Any) {
    }
    
    @IBAction func closeView(_ sender: Any) {
    }
    
//    MARK: - Variables
    var titleDetails = "Details"
    
//    MARK: - LifeCicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        detaisNavigation.title = titleDetails
        
        setupGraphic()
    }
    
    func setupGraphic() {
        
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
            
            // Starting to populate and draw the charts...
            var numbersArray = [[Int32]]()
            
            // Populating with the weights marked on this current week
            numbersArray = try plotter.loadWeights()
            
            print("--------loadWeights------")
            print(numbersArray[0])
            print(dates)
            
            var datesArray = [Any]()
            for x in 0...(dates.count - 1) {
                let aString = dates[x]
                let newString = (aString as AnyObject).replacingOccurrences(of: "\n", with: "/")
                datesArray.append(newString)
            }
            print(datesArray)
            print(datesArray[0])
            print("------------------------")
        }
        catch {
            os_log("[ERROR] Couldn't communicate with the operating system's internal calendar/time system or memory is too low!")
        }
    }
    
    //    MARK: - TableView
    func setupTableView() {
        detailsTableview.delegate = self
        detailsTableview.dataSource = self
        detailsTableview.register(ThirtyDayCell.self, forCellReuseIdentifier: "cellId")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView (_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = detailsTableview.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! ThirtyDayCell
        
        cell.backgroundColor = UIColor(named: "BackgrondColor")
        return cell
    }
}

class ThirtyDayCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    func setupView() {
        addSubview(cellView)
        cellView.addSubview(weightLabel)
        cellView.addSubview(dateLabel)
        self.selectionStyle = .none
        
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        weightLabel.heightAnchor.constraint(equalToConstant: 200).isActive = true
        weightLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        weightLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        weightLabel.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 20).isActive = true
        
        dateLabel.heightAnchor.constraint(equalToConstant: 200).isActive = true
        dateLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        dateLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        dateLabel.rightAnchor.constraint(equalTo: cellView.rightAnchor, constant: 100).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "CellColor")
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let weightLabel: UILabel = {
        let label = UILabel()
        label.text = "Day 1"
        label.textColor = UIColor(named: "PrimaryTextColor")
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "DD/MM/AA"
        label.textColor = UIColor(named: "SecundaryTextColor")
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}
