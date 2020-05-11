//
//  AddNoteViewController.swift
//  App
//
//  Created by Pietro Pugliesi on 11/05/20.
//  Copyright © 2020 Joao Flores. All rights reserved.
//

import UIKit

class AddNoteViewController: UIViewController {

	@IBOutlet var textField: UITextField!
	override func viewDidLoad() {
        super.viewDidLoad()

		textField.delegate = self
    }
	
	@IBAction func NoteDescriptionEnded(_ sender: Any) {
		
	}
	
	@IBAction func cancelTapped(_ sender: Any) {
		self.dismiss(animated: true, completion: nil)
	}
	
	@IBAction func saveTapped(_ sender: Any) {
		
		#warning("salvar nota")
		
		
		self.dismiss(animated: true, completion: nil)
	}
}

extension AddNoteViewController:UITextFieldDelegate{
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
}
