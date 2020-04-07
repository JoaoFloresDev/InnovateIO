//
//  EditDataViewController.swift
//  App
//
//  Created by Joao Flores on 07/04/20.
//  Copyright © 2020 Joao Flores. All rights reserved.
//

import UIKit

class EditDataViewController: ViewController {
    
    //    MARK: - IBOutlets
    
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var PlainingTextView: UITextView!
    
    //    MARK: - IBAction
    
    @IBAction func closeViewController(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
        //    MARK: - Life Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
