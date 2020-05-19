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
	@IBOutlet weak var chartCollectionView: UICollectionView!
	@IBOutlet weak var seeHistoryButton: UIButton!
	
	// Attributes related to the calendar itself
	var formatter = DateFormatter()
	var selectedWeek: [Date] = [] {
		didSet {
			seeHistoryButton.isHidden = selectedWeek.count == 0
		}
	}
	private var dataHandler: DataHandler?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupCalendarView()
		
		
		setupChartCollectionView()
		
		
		// Setting up the Data Handler (Core Data interface)
		do {
			self.dataHandler = try DataHandler.getShared()
		}
		catch { }
		
		self.calendarView.reloadData()
	}
	
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		// If the tab bar selected item has changed into this View Controller...
		// We reload the calendar!
		self.calendarView.reloadData()
	}
	
	fileprivate func setupCalendarView() {
		// Configuring the calendar view settings
		self.calendarView.calendarDelegate = self
		self.calendarView.calendarDataSource = self
		
		self.calendarView.scrollDirection = .horizontal
		self.calendarView.scrollingMode = .stopAtEachCalendarFrame
		self.calendarView.showsHorizontalScrollIndicator = false
		
		self.calendarView.scrollToDate(Date())
	}
	
	fileprivate func setupChartCollectionView() {
		// Configuring the collection view for showing the charts
		self.chartCollectionView.delegate = self
		self.chartCollectionView.dataSource = self
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?)
	{
		if segue.identifier == R.segue.calendarViewController.toMealHistory.identifier
		{
			let vc = segue.destination as? MealHistoryViewController
			vc?.receivedDates = selectedWeek
		}
	}
	
	@IBAction func tappedSeeHistoryButton(_ sender: Any) {
		performSegue(withIdentifier: R.segue.calendarViewController.toMealHistory.identifier, sender: nil)
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
		
		// Painting the text
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
				
				// Getting the current date...
				let (year, month, day, _, _, _) = try date.getAllInformations()
				let daily = try dataHandler?.loadDailyDiary(year: year, month: month, day: day)
				
				if daily != nil {
					let quality = Rating(rawValue: Int(daily!.quality))
					cell.circle.backgroundColor = quality?.color
				}
				
			}
			catch {
				os_log("[APP] No entry was found!")
			} // If catch has returned something... That means that we don't have anything on this date.
			
		}
		else {
			cell.circle.backgroundColor = .none
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
	
	
	/// A handler for checking if the calendar was scrolled. In that case we change the background color for each cell.
	/// - Parameters:
	///   - calendar: The calendar view
	///   - visibleDates: The visible dates in this segment (month)
	func calendar(_ calendar: JTACMonthView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
		
		// Clearing the circle color on days related to the selected month
		for (_, indexPath) in visibleDates.monthDates {
			
			let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "dateCell", for: indexPath) as! DateCell
			
			cell.circle.backgroundColor = .none
			
		}
		
		// Clearing the circle color on indates (previous days) related before to the selected month
		for (_, indexPath) in visibleDates.indates {
			
			let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "dateCell", for: indexPath) as! DateCell
			
			cell.circle.backgroundColor = .none
			
		}
		
		// Clearing the circle color on outdates (posteriori days) related after to the selected month
		for (_, indexPath) in visibleDates.outdates {
			
			let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "dateCell", for: indexPath) as! DateCell
			
			cell.circle.backgroundColor = .none
		}
	}
	
	func calendar(_ calendar: JTACMonthView, didSelectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
		
		var graphData = [(Int, [Int])]()//(day, [mealHour]) Tuple
		
		selectedWeek = date.getAllDaysForWeek()
		
		for i in 0..<selectedWeek.count{
			do {
				
				// Getting the current date...
				let (year, month, day, _, _, _) = try selectedWeek[i].getAllInformations()
				
				//possible info on database
				let daily = try dataHandler?.loadDailyDiary(year: year, month: month, day: day)
				
				if daily != nil {//info for day exists
					
					//load meal information
					let meals = try! dataHandler?.loadMeals(year: year, month: month, day: day)
					updateChart(day: i, hours: (meals?.map({ (meal) -> Int in
						Int(meal.hour)
					}))!)
				}else{//day=nil
					
				}
				
			}catch {
				os_log("[APP] No entry was found!")
			}
		}//for i in selected week
	}
	
	func calendarSizeForMonths(_ calendar: JTACMonthView?) -> MonthSize? {
		return MonthSize(defaultSize: 80)
	}
}
