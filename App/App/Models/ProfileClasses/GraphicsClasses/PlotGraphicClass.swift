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
    
    var scrollView: UIScrollView!
    var timerGoalsAnimation: Timer!
    
    func plotGraphicLine(graphicVIew: UIView, colorLinesArray: [UIColor], datesX: NSMutableArray, numbersArray: [[Int32]], topNumber: Int, bottomNumber: Int) {
        
        var itemArray: [AnyHashable] = []
        
//      Create lines lines
        for i in 0..<numbersArray.count {
            let item = XLineChartItem(dataNumber: NSMutableArray(array: numbersArray[i]), color: colorLinesArray[i])
            itemArray.append(item!)
        }
        
//      Plot graphic
        let configuration = XNormalLineChartConfiguration()
        configuration.lineMode = XLineMode.CurveLine
        
        let widthGraphic = graphicVIew.frame.width
        let heightGraphic = graphicVIew.frame.height
        let topNumberGraphic = NSNumber(value: topNumber)
        let bottomNumberGraphic = NSNumber(value: bottomNumber)
        
        let lineChart = XLineChart(frame: CGRect(x: 0, y: 0, width: widthGraphic, height: heightGraphic), dataItemArray: NSMutableArray(array: itemArray), dataDiscribeArray: datesX, topNumber: topNumberGraphic, bottomNumber: bottomNumberGraphic, graphMode: XLineGraphMode.MutiLineGraph, chartConfiguration: configuration)
        
        
        if let views = lineChart?.subviews {
            for viewScroll in views {
                if viewScroll is UIScrollView {
                    if let scroll = viewScroll as? UIScrollView {
                        print(scroll)
                        scrollView = scroll
                        let newOffset = CGPoint(x: scrollView.contentSize.width - graphicVIew.frame.width + 40, y: 0)
                        scrollView.setContentOffset(newOffset, animated: true)
                    }
                }
            }
        }
        
        graphicVIew.addSubview(lineChart!)
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
    
    func setLayoutLegends(views: [UIView]) {
        for view in views {
            StyleClass().cropBounds(viewlayer: view.layer, cornerRadius: Float(view.frame.width/2))
        }
    }
    
    func generateValues(numLines: Int, datesCount: Int) -> [[Int32]] {
        
        var numbersArray = [[Int32]]()
        
        for _ in 0..<numLines {
            var numberArray = [Int32]()
            
            for _ in 0..<datesCount {
                let num: Int = Int.random(in: 32 ..< 90)
                let number = Int32(num)
                numberArray.append(number)
            }
            numbersArray.append(numberArray)
        }
        
        return numbersArray
    }
}

