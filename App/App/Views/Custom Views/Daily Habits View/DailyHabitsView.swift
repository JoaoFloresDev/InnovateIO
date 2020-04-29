//
//  DailyHabitsView.swift
//  App
//
//  Created by Priscila Zucato on 28/04/20.
//  Copyright © 2020 Joao Flores. All rights reserved.
//

import UIKit

class DailyHabitsView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var dailyHabitsTableView: UITableView!
    @IBOutlet weak var todayRatingView: RatingView!
    
    var dailyHabits : [DailyHabits : Bool] = [.exercise : false, .fruit : false, .drinkWater : false]
    
    var selectedRating: Rating? {
        set {
            todayRatingView.selectedRating = newValue
        }
        get {
            return todayRatingView.selectedRating
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed(R.nib.dailyHabitsView.name, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        setupTableView()
    }
    
    private func setupTableView() {
        dailyHabitsTableView.delegate = self
        dailyHabitsTableView.dataSource = self
        dailyHabitsTableView.register(UINib(resource: R.nib.dailyHabitsTableViewCell), forCellReuseIdentifier: R.reuseIdentifier.dailyHabitsTableViewCell.identifier)
    }
    
    func setup() {
        todayRatingView.setup()
    }
}

extension DailyHabitsView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyHabits.keys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.dailyHabitsTableViewCell.identifier) as? DailyHabitsTableViewCell else { return UITableViewCell() }
        
        let habitKeys: [DailyHabits] = Array(dailyHabits.keys)
        let habit = habitKeys[indexPath.row]
        let isSelected = dailyHabits[habit]
        
        cell.setup(title: habit.title, icon: habit.icon)
        cell.isSelected = isSelected ?? false
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let habitKeys: [DailyHabits] = Array(dailyHabits.keys)
        let habit = habitKeys[indexPath.row]
        dailyHabits[habit] = true
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let habitKeys: [DailyHabits] = Array(dailyHabits.keys)
        let habit = habitKeys[indexPath.row]
        dailyHabits[habit] = false
    }
}
