//
//  CalendarViewController.swift
//  App
//
//  Created by Vinicius Hiroshi Higa on 27/04/20.
//  Copyright © 2020 Joao Flores. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CalendarViewController: UIViewController {
    
    @IBOutlet weak var calendarView: JTACMonthView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var formatter = DateFormatter()
    
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
        
    }
    
}

extension CalendarViewController: JTACMonthViewDataSource {
    
    func configureCalendar(_ calendar: JTACMonthView) -> ConfigurationParameters {  
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        let startDate = formatter.date(from: "2018 01 01")!
        let endDate = Date()
        return ConfigurationParameters(startDate: startDate, endDate: endDate)
    }
    
}

extension CalendarViewController: JTACMonthViewDelegate {
    
    func calendar(_ calendar: JTACMonthView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTACDayCell {
        
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "dateCell", for: indexPath) as! DateCell
        cell.dateLabel.text = cellState.text
        
        return cell
    }
    
    
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
        return MonthSize(defaultSize: 50)
    }
    

    

    
}
