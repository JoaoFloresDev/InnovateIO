//
//  PerformanceChartCollectionViewCell.swift
//  App
//
//  Created by Pietro Pugliesi on 07/05/20.
//  Copyright © 2020 Joao Flores. All rights reserved.
//

import UIKit

class PerformanceChartCollectionViewCell: UICollectionViewCell {

	@IBOutlet var timeDots: [RoundedView]!
	private var dataHandler: DataHandler?

	func makeBlankTimeDots(){
		//make all dissappear
		for i in 0..<timeDots.count{
			timeDots[i].deactivate()
		}
	}
	
	func configureDotsForDay(day:Int, mealTime:[Int], quality:[Int]){
		makeBlankTimeDots()
		
		for i in 0..<quality.count{
			var color:UIColor?
			switch i {
				case -1:
					color = UIColor.init(named: "rateRedColor")!
				case 0:
					color = UIColor.init(named: "rateYellowColor")!
				case 1:
 					color = UIColor.init(named: "rateGreenColor")!
				default:
					break
			}
			let hour = mealTime[i]
			timeDots[hour].backgroundColor = color
			timeDots[hour].activate()
		}
		setNeedsLayout()
	}
}
