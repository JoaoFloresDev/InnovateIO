//
//  CalendarGraphCollectionViewCell.swift
//  App
//
//  Created by Pietro Pugliesi on 30/04/20.
//  Copyright © 2020 Joao Flores. All rights reserved.
//

import UIKit

class CalendarGraphCollectionViewCell: UICollectionViewCell {
    
	@IBOutlet var timeDots: [RoundedView]!
	
	func configureTimeDots() {
		for i in 0..<timeDots.count{
			timeDots[i].alpha = 0
		}
	}
}
