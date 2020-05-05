//
//  CalendarViewController.swift
//  App
//
//  Created by Vinicius Hiroshi Higa on 27/04/20.
//  Copyright © 2020 Joao Flores. All rights reserved.
//

import UIKit
import JTAppleCalendar
import os.log

class CalendarViewController: UIViewController {
    
    // Attributes related to the interface builder
    @IBOutlet weak var calendarView: JTACMonthView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // Attributes related to the calendar itself
    var formatter = DateFormatter()
    private var dataHandler: DataHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Configuring the calendar view settings
        self.calendarView.calendarDelegate = self
        self.calendarView.calendarDataSource = self
        
        self.calendarView.scrollDirection = .horizontal
        self.calendarView.scrollingMode = .stopAtEachCalendarFrame
        self.calendarView.showsHorizontalScrollIndicator = false
        
        self.calendarView.scrollToDate(Date())
        
        
        // Configuring the collection view for showing the charts
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        
        // Setting up the Data Handler (Core Data interface)
        do {
            self.dataHandler = try DataHandler.getShared()
        }
        catch { }
        
        self.calendarView.reloadData()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        // If the tab bar selected item has changed into this View Controller...
        // We reload the calendar!
        self.calendarView.reloadData()
    }

    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        self.calendarView.reloadData()
    }
    
}

extension CalendarViewController: JTACMonthViewDataSource {
    
    
    /// Sets the length / amount of months for the calendar view.
    /// - Parameter calendar: The calendar view.
    /// - Returns: Returns the amount of months that can be seen.
    func configureCalendar(_ calendar: JTACMonthView) -> ConfigurationParameters {  
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        let startDate = formatter.date(from: "2018 01 01")!
        let endDate = Date()
        return ConfigurationParameters(startDate: startDate, endDate: endDate)
    }

    
}

extension CalendarViewController: JTACMonthViewDelegate {
    
    
    /// Sets the initial state for the days in the calendar and colorize the cells.
    /// - Parameters:
    ///   - calendar: The calendar view.
    ///   - date: The date related to the current day cell.
    ///   - cellState: The state of the cell (e.g. sets the number of the day in the cell)
    ///   - indexPath: The index of the
    /// - Returns: The index path from day perspective
    func calendar(_ calendar: JTACMonthView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTACDayCell {
        
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "dateCell", for: indexPath) as! DateCell
        
        if cellState.dateBelongsTo == .thisMonth {
            if self.traitCollection.userInterfaceStyle == .dark {
                cell.dateLabel.textColor = .white
            } else {
                cell.dateLabel.textColor = .black
            }
        }
        else {
            cell.dateLabel.textColor = .gray
        }
        
        cell.dateLabel.text = cellState.text
        cell.dateLabel.backgroundColor = .none
        
        // Colorizing the cells
        if cellState.dateBelongsTo == .thisMonth {
            
            do {
                
                let (year, month, day, _, _, _) = try date.getAllInformations()
                let daily = try dataHandler?.loadDailyDiary(year: year, month: month, day: day)
                
                if daily != nil {
                    let quality = Rating(rawValue: Int(daily!.quality))
                    cell.dateLabel.backgroundColor = quality?.color
                }
                
            }
            catch {
                os_log("[APP] No entry was found!")
            } // If catch has returned something... That means that we don't have anything on this date.

        }
        
        return cell
    }

    
    /// Sets the current day in number for a cell's label.
    /// - Parameters:
    ///   - calendar: The calendar view.
    ///   - cell: The current cell to be updated.
    ///   - date: The date related to the current day cell.
    ///   - cellState: The state of the cell (e.g. sets the number of the day in the cell)
    ///   - indexPath: The index path from day perspective
    func calendar(_ calendar: JTACMonthView, willDisplay cell: JTACDayCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        
        let cell = cell as! DateCell
        cell.dateLabel.text = cellState.text
        
    }
    
    
    /// Configures the header section from the calendar.
    /// - Parameters:
    ///   - calendar: The calendar view
    ///   - range: Desired range from dates
    ///   - indexPath: The index path from month perspective
    /// - Returns: A reusable view for the header or in another words the configured view for the header
    func calendar(_ calendar: JTACMonthView, headerViewForDateRange range: (start: Date, end: Date), at indexPath: IndexPath) -> JTACMonthReusableView {
        
        self.formatter.dateFormat = "MMM YYYY"
        
        let header = calendar.dequeueReusableJTAppleSupplementaryView(withReuseIdentifier: "DateHeader", for: indexPath) as! DateHeader
        header.monthTitle.text = formatter.string(from: range.start)
        return header
    }
    

    func calendarSizeForMonths(_ calendar: JTACMonthView?) -> MonthSize? {
        return MonthSize(defaultSize: 80)
    }

    
    func calendar(_ calendar: JTACMonthView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        
        for (_, indexPath) in visibleDates.monthDates {
            
            let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "dateCell", for: indexPath) as! DateCell
            
            cell.backgroundColor = .none
            
            
        }
        
    }
    

    
}
