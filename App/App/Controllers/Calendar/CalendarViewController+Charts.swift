//
//  CalendarViewController+Charts.swift
//  App
//
//  Created by Vinicius Hiroshi Higa on 28/04/20.
//  Copyright © 2020 Joao Flores. All rights reserved.
//

import UIKit

extension CalendarViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PerformanceChart", for: indexPath) as! PerformanceChartCollectionViewCell
		
		if indexPath.row == 7{
			cell.separatorLineView.isHidden=true
		}
		
		cell.makeBlankTimeDots()
        return cell
    }
	
	func updateChart(day:Int, hours:[Int], qualities:[Int]){
		let cell = chartCollectionView.cellForItem(at: IndexPath(item: day, section: 0)) as! PerformanceChartCollectionViewCell
		
		#warning("voltar isso aqui depois")
		cell.configureDotsForDay(mealTime: hours, quality: qualities)
	}
	
	func emptyGraphLine(day:Int){
		let cell = chartCollectionView.cellForItem(at: IndexPath(item: day, section: 0)) as! PerformanceChartCollectionViewCell
		cell.makeBlankTimeDots()
	}
}
