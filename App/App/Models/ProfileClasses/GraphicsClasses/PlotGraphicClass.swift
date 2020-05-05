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
    
    func plotGraphicLine(graphicVIew: UIView, numLines: Int, colorArray: [UIColor], dates: NSMutableArray, topNumber: Int, bottomNumber: Int) {
        
        var itemArray: [AnyHashable] = []
        var numbersArray = [[Int32]]()
        
        
//        aleatory data
        for _ in 0..<numLines {
            var numberArray = [Int32]()
            
            for _ in 0..<dates.count {
                let num: Int = Int.random(in: 32 ..< 90)
                let number = Int32(num)
                numberArray.append(number)
            }
            numbersArray.append(numberArray)
        }
        
        for i in 0..<numLines {
            let item = XLineChartItem(dataNumber: NSMutableArray(array: numbersArray[i]), color: colorArray[i])
            itemArray.append(item!)
        }
        
//        plot graphic
        let configuration = XNormalLineChartConfiguration()
        configuration.lineMode = XLineMode.CurveLine
        
        let lineChart = XLineChart(frame: CGRect(x: 0, y: 0, width: graphicVIew.frame.width, height: graphicVIew.frame.height), dataItemArray: NSMutableArray(array: itemArray), dataDiscribeArray: dates, topNumber: NSNumber(value: topNumber), bottomNumber: NSNumber(value: bottomNumber), graphMode: XLineGraphMode.MutiLineGraph, chartConfiguration: configuration)
        
        
        if let views = lineChart?.subviews {
            for viewScroll in views {
                if viewScroll is UIScrollView {
                    print(viewScroll)
                    
//                    let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 400, height: 200))
//                    scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
                }
            }
        }
        
        graphicVIew.addSubview(lineChart!)
    }
    
    func setLayoutLegends(views: [UIView]) {
        for view in views {
            StyleClass().cropBounds(viewlayer: view.layer, cornerRadius: Float(view.frame.width/2))
        }
    }
    
    func plotGraphicHorizontalBars (view: UIView, greenPercent: Float, yellowPercent: Float) {
        
        let greenView = UIView(frame: CGRect(x: 0, y: 0, width: Int(Float(view.frame.width) * greenPercent), height: Int(view.frame.height)))
        greenView.backgroundColor = UIColor.green
        
        let yellowView = UIView(frame: CGRect(x: Int(Float(view.frame.width) * greenPercent), y: 0, width: Int(Float(view.frame.width) * yellowPercent), height: Int(view.frame.height)))
        yellowView.backgroundColor = UIColor.yellow
        
        view.backgroundColor = UIColor.red
        view.addSubview(greenView)
        view.addSubview(yellowView)
        
        StyleClass().cropBounds(viewlayer: view.layer, cornerRadius: Float(view.frame.height/2))
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

