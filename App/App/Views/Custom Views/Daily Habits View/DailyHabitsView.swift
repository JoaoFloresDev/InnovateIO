//
//  DailyHabitsView.swift
//  App
//
//  Created by Priscila Zucato on 28/04/20.
//  Copyright © 2020 Joao Flores. All rights reserved.
//

import UIKit

protocol DailyHabitsViewDelegate {
    func dailyDiaryDidUpdate(_ diary: DailyDiary)
}

class DailyHabitsView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var dailyHabitsTableView: UITableView!
    @IBOutlet weak var todayRatingView: RatingView!
    
    private var delegate: DailyHabitsViewDelegate?
    private var dailyHabits : [DailyHabits : Bool] = [.exercise : false, .fruit : false, .drinkWater : false]
    private var dailyDiary: DailyDiary?
    
    private var selectedRating: Rating? {
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
    
    func setup(delegate: DailyHabitsViewDelegate) {
        self.delegate = delegate
        todayRatingView.setup()
    }
    
    func setInitialDailyDiary(_ diary: DailyDiary?) {
        self.dailyDiary = diary
        updateViewToDiary()
    }
    
    private func updateViewToDiary() {
        guard let dailyDiary = self.dailyDiary else { return }
        
        dailyHabits[.drinkWater] = dailyDiary.didDrinkWater
        dailyHabits[.exercise] = dailyDiary.didPracticeExercise
        dailyHabits[.fruit] = dailyDiary.didEatFruit
        todayRatingView.selectedRating = Rating(rawValue: Int(dailyDiary.quality))
        
        dailyHabitsTableView.reloadData()
    }
    
    private func updatedDailyDiary() {
        if let diary = self.dailyDiary {
            delegate?.dailyDiaryDidUpdate(diary)
        }
    }
    
    private func updatedHabit(_ habit: DailyHabits) {
        let change = dailyHabits[habit] ?? false
        switch habit {
        case .drinkWater:
            dailyDiary?.didDrinkWater = change
        case .exercise:
            dailyDiary?.didPracticeExercise = change
        case .fruit:
            dailyDiary?.didEatFruit = change
        }
        
        updatedDailyDiary()
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
        
        cell.setup(title: habit.title, icon: habit.icon)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        let habitKeys: [DailyHabits] = Array(dailyHabits.keys)
        let habit = habitKeys[indexPath.row]
        let isSelected = dailyHabits[habit]
        if isSelected ?? false {
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        } else {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectHabit(true, indexPath)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        didSelectHabit(false, indexPath)
    }
    
    fileprivate func didSelectHabit(_ selected: Bool, _ indexPath: IndexPath) {
        let habitKeys: [DailyHabits] = Array(dailyHabits.keys)
        let habit = habitKeys[indexPath.row]
        dailyHabits[habit] = selected
        updatedHabit(habit)
    }
}
