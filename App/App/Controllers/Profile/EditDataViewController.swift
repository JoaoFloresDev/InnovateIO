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
    @IBOutlet weak var plainingTextView: UITextView!
    
    //    MARK: - IBAction
    
    @IBAction func closeViewController(_ sender: Any) {
        closeView()
    }
    
    //    MARK: - Life Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        plainingTextView.layer.cornerRadius = 10
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        closeView()

        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    //    MARK: - UIAlerts
    func closeView() {
        
        let refreshAlert = UIAlertController(title: "Deseja salvar alterações?", message: nil, preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Cancelar", style: .destructive, handler: { (action: UIAlertAction!) in
            self.dismiss(animated: true, completion: nil)
        }))
        refreshAlert.addAction(UIAlertAction(title: "Salvar", style: .default, handler: { (action: UIAlertAction!) in
            //            self.atualizeNames()
            self.dismiss(animated: true, completion: nil)
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
}
