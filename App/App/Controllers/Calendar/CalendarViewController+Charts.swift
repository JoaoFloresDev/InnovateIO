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
		
		cell.configureTimeDots()
        
        return cell
        
    }
    
    
    
    
}
