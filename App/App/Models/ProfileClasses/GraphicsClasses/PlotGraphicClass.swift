//
//  PlotGraphicClass.swift
//  App
//
//  Created by Joao Flores on 30/04/20.
//  Copyright © 2020 Joao Flores. All rights reserved.
//

import UIKit
import XJYChart

class PlotGraphicClass {
    
    func plotGraphicLine(graphicVIew: UIView, numLines: Int) {
        let dates: NSMutableArray = ["13\n04", "13\n04", "13\n04", "13\n04", "13\n04","13\n04", "13\n04", "13\n04", "13\n04", "13\n04", "13\n04", "13\n04", "13\n04"]
        
        var itemArray: [AnyHashable] = []
        var numbersArray = [[Int32]]()
        
        for _ in 0..<numLines {
            var numberArray = [Int32]()
            
            for _ in 0..<dates.count {
                let num: Int = Int.random(in: 32 ..< 120)
                let number = Int32(num)
                numberArray.append(number)
            }
            numbersArray.append(numberArray)
        }
        
        let colorArray = [UIColor.teal(), UIColor.brickRed(), UIColor.banana(), UIColor.babyBlue(), UIColor.orchid()]
        
        for i in 0..<numLines {
            let item = XLineChartItem(dataNumber: NSMutableArray(array: numbersArray[i]), color: colorArray[i])
            itemArray.append(item!)
        }
        
        let configuration = XNormalLineChartConfiguration()
        configuration.lineMode = XLineMode.CurveLine
        
        let lineChart = XLineChart(frame: CGRect(x: 0, y: 0, width: 400, height: 250), dataItemArray: NSMutableArray(array: itemArray), dataDiscribeArray: dates, topNumber: 120, bottomNumber: 30, graphMode: XLineGraphMode.MutiLineGraph, chartConfiguration: configuration)
        
        
        if let views = lineChart?.subviews {
            for view123 in views {
                if view123 is UIScrollView {
                    
                    print(view123)
                    
                    let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 400, height: 200))
                    scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
                }
            }
        }
        
        graphicVIew.addSubview(lineChart!)
    }
}

extension UIScrollViewDelegate {
    
    func setContentOffset(_ contentOffset: CGPoint, animated: Bool) {
        print("alooo")
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        print("222")
    }
}

extension UIScrollView {
    
    func setContentOffset(_ contentOffset: CGPoint, animated: Bool) {
        print("alooo")
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        print("222")
    }
}

