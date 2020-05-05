//
//  CycleTableViewCell.swift
//  XJYChartDemo-Swift
//
//  Created by Kelly Roach on 8/17/18.
//  Copyright © 2018 JunyiXie. All rights reserved.
//

import UIKit
import XJYChart

public class CycleTableViewCell: UIView, XCycleViewDelegate {
    
    @IBOutlet var cycleView: XCycleView!
    @IBOutlet var moneyLabel: UILabel!
    @IBOutlet var showMoneyRangeLabel: UILabel!
    private var min: CGFloat = 0.0
    private var max: CGFloat = 0.0
    private var ges1: UITapGestureRecognizer?
    private var ges2: UITapGestureRecognizer?
    private var ges3: UITapGestureRecognizer?

    override public func awakeFromNib() {
        super.awakeFromNib()
        cycleView.cycleViewDelegate = self
        // 接口
        self.min = 500
        self.max = 2000
        //
//        self.moneyLabel.text = "0元"
//        self.moneyLabel.font = UIFont.systemFont(ofSize: 20)
        // Initialization code
    }

// MARK: 回调
    public func ratioChange(_ ratio: CGFloat) {
        //传给你比例!
        self.moneyLabel.text = String(format: "%.0f元", ratio * max)
        if ratio >= 0.95 {
            self.moneyLabel.text = String(format: "%.0f元", 1 * max)
        }
    }
    
    func plotGraphicLine(graphicVIew: UIView) {
//        ratioChange(CGFloat(10))
        awakeFromNib()
//        graphicVIew.addSubview(cycleView)
    }
}
