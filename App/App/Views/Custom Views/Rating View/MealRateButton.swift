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

    var rating: Rating = Rating.good
    var isTheSelectedButton: Bool = false {
        didSet {
            border()
        }
    }
    
    func setupButton() {
        setColor()
        self.setTitle(rating.title, for: .normal)
    }
    
    private func setColor() {
        let topColor = self.backgroundColor ?? .white
        let downColor = rating.color
        
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [topColor, downColor]
        gradient.locations = [0.0, 0.75]
        layer.insertSublayer(gradient, at: 0)
    }
    
    private func border() {
        self.layer.borderWidth = isTheSelectedButton ? 2 : 0
        self.layer.borderColor = UIColor.black.cgColor
    }
}
