//
//  DailyHabitsTableViewCell.swift
//  App
//
//  Created by Priscila Zucato on 28/04/20.
//  Copyright © 2020 Joao Flores. All rights reserved.
//

import UIKit

class DailyHabitsTableViewCell: UITableViewCell {
    @IBOutlet weak var checkButton: RoundedButton!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        checkButton.setImage(selected ? UIImage(systemName: "checkmark") : nil, for: .normal)
    }
    
    func setup(title: String, icon: UIImage?) {
        titleLabel.text = title
        iconView.image = icon
        selectionStyle = .none
    }
    
}
