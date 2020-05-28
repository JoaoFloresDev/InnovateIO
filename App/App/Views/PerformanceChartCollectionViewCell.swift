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
		
		for i in quality{
			switch i {
				case -1:
					timeDots[i].backgroundColor = UIColor.init(named: "rateRedColor")!
				case 0:
					timeDots[i].backgroundColor = UIColor.init(named: "rateYellowColor")!
				case 1:
 					timeDots[i].backgroundColor = UIColor.init(named: "rateGreenColor")!
				default:
					break
			}
		}
		for i in mealTime{
			timeDots[i].activate()
		}
	}
}
