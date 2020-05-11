//
//  MealHistoryTableViewCell.swift
//  App
//
//  Created by Priscila Zucato on 05/05/20.
//  Copyright © 2020 Joao Flores. All rights reserved.
//

import UIKit

class MealHistoryTableViewCell: UITableViewCell {
    @IBOutlet weak var mealRoundedView: RoundedView!
    @IBOutlet weak var mealImage: UIImageView!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var noMealView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        mealRoundedView.isHidden = false
        noMealView.isHidden = true
    }
    
    func setup(meal: Meal?) {
        if let meal = meal {
            guard let rating = Rating(rawValue: Int(meal.quality)) else {
                        print("Error when mapping quality of fetched meal to Rating instance.")
                        return
                    }
                    
                    colorView.backgroundColor = rating.color
                    
                    noteLabel.text = meal.note == nil ? rating.defaultNoteForMeal : meal.note
                    
                    // TODO: uncomment when meal image is implemented in Core Data.
            //        mealImage.isHidden = image == nil
            //        mealImage.image = image
                    
                    timeLabel.text = String(format: "%02d", meal.hour) + "h" + String(format: "%02d", meal.minute
                    )
        } else {
            mealRoundedView.isHidden = true
            noMealView.isHidden = false
        }
    }
}
