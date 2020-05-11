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
        setTitle()
        setShadow()
    }
    
    private func setTitle() {
        self.setTitle(rating.title, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
    }
    
    private func setColor() {
        self.backgroundColor = rating.color
    }
    
    private func setShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.5
    }
    
    private func border() {
        self.layer.borderWidth = isTheSelectedButton ? 2 : 0.1
        self.layer.borderColor = isTheSelectedButton ? UIColor.black.cgColor : UIColor.gray.cgColor
    }
}
