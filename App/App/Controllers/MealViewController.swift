//
//  MealViewController.swift
//  App
//
//  Created by Pietro Pugliesi on 07/04/20.
//  Copyright © 2020 Joao Flores. All rights reserved.
//

import UIKit

class MealViewController: UIViewController {
	@IBOutlet var tableView: UITableView!
	let options = ["Refeição", "Exercício", "Água"]
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.delegate = self
		tableView.dataSource = self
	}
}
extension MealViewController:UITableViewDataSource, UITableViewDelegate{
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 3
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "mealCell")!
		
		cell.textLabel?.text = options[indexPath.row]
		
		return cell
	}
}
