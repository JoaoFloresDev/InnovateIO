//
//  MealRateButtonView.swift
//  App
//
//  Created by Pietro Pugliesi on 23/04/20.
//  Copyright © 2020 Joao Flores. All rights reserved.
//

import Foundation
import UIKit

class MealRateButton: UIButton{
	var cornerRadius:CGFloat = 0{
		didSet{
			layer.cornerRadius = cornerRadius
		}
	}

	var color:UIColor = UIColor.yellow{
		didSet{
			setupButton(color:color)
		}
	}
	
	func setupButton(color:UIColor){
		let topColor = self.backgroundColor
		let downColor = color
		
		let gradient = CAGradientLayer()
		gradient.frame = self.bounds
		gradient.colors = [topColor, downColor]
		layer.insertSublayer(gradient, at: 0)
	}
}
