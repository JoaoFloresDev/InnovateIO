//
//  MealRateButtonView.swift
//  App
//
//  Created by Pietro Pugliesi on 23/04/20.
//  Copyright © 2020 Joao Flores. All rights reserved.
//

import Foundation
import UIKit

class MealRateButton: UIButton {
	@IBInspectable var cornerRadius: CGFloat = 0 {
		didSet{
			layer.cornerRadius = cornerRadius
		}
	}

	@IBInspectable var color: UIColor = UIColor.yellow {
		didSet{
			setupButton()
		}
	}
	
	func setupButton() {
        let topColor = self.backgroundColor ?? .white
		let downColor = color
		
		let gradient = CAGradientLayer()
		gradient.frame = self.bounds
		gradient.colors = [topColor, downColor]
        gradient.locations = [0.0, 0.75]
		layer.insertSublayer(gradient, at: 0)
	}
}
