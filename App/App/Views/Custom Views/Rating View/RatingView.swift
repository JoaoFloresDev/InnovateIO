//
//  RatingView.swift
//  App
//
//  Created by Priscila Zucato on 28/04/20.
//  Copyright © 2020 Joao Flores. All rights reserved.
//

import UIKit

class RatingView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var goodRateButton: MealRateButton!
    @IBOutlet weak var averageRateButton: MealRateButton!
    @IBOutlet weak var badRateButton: MealRateButton!
    
    var buttons: [MealRateButton] = []
    var selectedRating: Rating?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed(R.nib.ratingView.name, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        buttonSetup()
    }
    
    private func buttonSetup() {
        goodRateButton.rating = .good
        averageRateButton.rating = .average
        badRateButton.rating = .bad
        
        buttons = [goodRateButton, averageRateButton, badRateButton]
        for button in buttons {
            button.addTarget(self, action: #selector(didTapRateButton), for: .touchUpInside)
            button.isTheSelectedButton = false
        }
    }
    
    func setup() {
        for button in buttons {
            button.setupButton()
        }
    }
    
    @objc func didTapRateButton(sender: MealRateButton) {
        switch selectedRating {
        case sender.rating:
            selectedRating = nil
            for button in buttons {
                button.isTheSelectedButton = false
            }
        default:
            selectedRating = sender.rating
            for button in buttons {
                if button == sender {
                    button.isTheSelectedButton = true
                } else {
                    button.isTheSelectedButton = false
                }
            }
        }
    }
}
