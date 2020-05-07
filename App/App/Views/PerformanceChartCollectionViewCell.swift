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
	
	func configureTimeDots(){
		//make all dissappear
		for i in 0..<timeDots.count{
			timeDots[i].deactivate()
		}
		
		timeDots[5].activate()
	}
}
