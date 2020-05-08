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

	func initTimeDots(){
		//make all dissappear
		for i in 0..<timeDots.count{
			timeDots[i].deactivate()
		}
		
		timeDots[5].activate()
	}
	
	func getMealsForWeek(){
		getMealsForDate(date: Date())
	}
	
	
	func getMealsForDate(date:Date){
		do {
			let (year, month, day, _, _, _) = try date.getAllInformations()//OK, ta pegando
			let daily = try dataHandler?.loadDailyDiary(year: year, month: month, day: day)
			
			if daily != nil {
				let quality = Rating(rawValue: Int(daily!.quality))
				print("quality=\(quality)")
			}else{
				print("nao temos refeicao registrada para data \(day)/\(month)/\(year)")
			}
			
		}
		catch {
			print("nao conseguimos pegar informacao pra essa data")
		} // If catch has returned something... That means that we don't have anything on this date.
	}
}
