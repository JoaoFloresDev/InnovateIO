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
	
	func configureDotsForDay(mealTime:[Int], quality:[Int]){
		makeBlankTimeDots()
		
		for i in 0..<quality.count{
			var color = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
			switch quality[i] {
				case -1:
					color = R.color.badColor()!
				break
				case 0:
					color = R.color.mediumColor()!
				break
				case 1:
 					color = R.color.goodColor()!
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
