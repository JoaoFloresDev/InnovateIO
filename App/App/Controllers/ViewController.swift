//
//  ViewController.swift
//  App
//
//  Created by Joao Flores on 02/04/20.
//  Copyright © 2020 Joao Flores. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // TEST: This is a test implementation for the Core Data
        // TODO: Please remove it after merging on the master branch
        
//        do {
//            let dao = try DataLoader.getShared()
//            try dao.createUser(name: "Tony Stark", meta: "Defeat Thanos!")
//        }
//        catch {
//            print(error)
//        }
        
        
        do {
            let dao = try DataLoader.getShared()
            try dao.loadUser()
        }
        catch {
            print(error)
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }


}

