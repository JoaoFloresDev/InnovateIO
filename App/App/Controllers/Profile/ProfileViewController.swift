//
//  ProfileViewController.swift
//  App
//
//  Created by Joao Flores on 07/04/20.
//  Copyright © 2020 Joao Flores. All rights reserved.
//

import UIKit
import QuartzCore
import Photos

class ProfileViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    //    MARK: - Variables
    var imagePicker: UIImagePickerController!
    var defaults = UserDefaults.standard
    
    //    MARK: - IBOutlet
    //  header
    @IBOutlet weak var profileImg: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var plainsLabel: UILabel!
    @IBOutlet weak var currentWeightLabel: UILabel!
    @IBOutlet weak var exercicePercentLabel: UILabel!
    @IBOutlet weak var fruitsPercentLabel: UILabel!
    @IBOutlet weak var waterPercentLabel: UILabel!
    
    //  graphics
    @IBOutlet weak var weightGraphicView: UIView!
    @IBOutlet weak var habitsGraphicView: UIView!
    
    @IBOutlet weak var colorExerciceGraphicsImage: UIImageView!
    @IBOutlet weak var colorFruitsGraphicsImage: UIImageView!
    @IBOutlet weak var colorWaterGraphicsLabel: UIImageView!
    
    
    //    MARK: - IBAction
    @IBAction func selectImgProfile(_ sender: Any) {
        
        openGalery()
    }
    
    //    MARK: - Life Cicle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupStyleViews()
        setupDataProfile()
        setupTexts()
        
        // TEST: This is a test implementation for the Core Data
        // TODO: Please remove it after merging on the master branch
        
        do {
            let dao = try DataLoader.getShared()
            try dao.createUser(name: "Tony Stark", meta: "Defeat Thanos!")
        }
        catch {
            print(error)
        }
        
        
//        do {
//            let dao = try DataLoader.getShared()
//            try dao.loadUser()
//        }
//        catch {
//            print(error)
//        }
    }
    
    //    MARK: - User Defauls
    func setupTexts() {
        
        plainsLabel.text = defaults.string(forKey: "Plain") ?? "Insira seu plano aqui"
        currentWeightLabel.text = defaults.string(forKey: "Weight") ?? "00 Kg"
        exercicePercentLabel.text = defaults.string(forKey: "exercicePercent") ?? "00 %"
        fruitsPercentLabel.text = defaults.string(forKey: "fruitsPercent") ?? "00 %"
        waterPercentLabel.text = defaults.string(forKey: "waterPercent") ?? "00 %"
    }
    
    //    MARK: - Take Profile Image
    func openGalery() {
        
        imagePicker =  UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var image : UIImage!
        
        if let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        {   image = img    }
        else if let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {   image = img    }
        
        cropBounds(viewlayer: profileImg.layer,
                   cornerRadius: Float(profileImg.frame.size.width/2))
        
        profileImg.image = image
        picker.dismiss(animated: true,completion: nil)
        
        print(saveImage(image: image))
    }
    
    func saveImage(image: UIImage) -> Bool {
        guard let data = image.jpegData(compressionQuality: 1) ?? image.pngData() else {
            return false
        }
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
            return false
        }
        do {
            try data.write(to: directory.appendingPathComponent("fileName.png")!)
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    func getSavedImage(named: String) -> UIImage? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path)
        }
        return nil
    }
    
    //    MARK: - Data Profile
    func setupDataProfile() {
        
        setupNameProfile()
        setupDataProfileNotification()
        if let image = getSavedImage(named: "fileName") {
            cropBounds(viewlayer: profileImg.layer,
                       cornerRadius: Float(profileImg.frame.size.width/2))
            
            profileImg.image = image
        }
    }
    
    func setupDataProfileNotification() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateLabel), name: NSNotification.Name(rawValue: "updateDataProfile"), object: nil)
    }
    
    func setupNameProfile() {
        
        var vet = UIDevice.current.name.split(separator: " ")
        for _ in 0...1 {
            vet.remove(at: 0)
        }
        nameLabel.text = vet.joined(separator: " ").capitalized
    }
    
    @objc func updateLabel() {
        
        setupTexts()
    }
    
    //    MARK: - Style
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
    }
    
    func setupStyleViews() {
        
        cropBounds(viewlayer: weightGraphicView.layer, cornerRadius: 10)
        cropBounds(viewlayer: habitsGraphicView.layer, cornerRadius: 10)
        cropBounds(viewlayer: colorExerciceGraphicsImage.layer, cornerRadius: 5)
        cropBounds(viewlayer: colorFruitsGraphicsImage.layer, cornerRadius: 5)
        cropBounds(viewlayer: colorWaterGraphicsLabel.layer, cornerRadius: 5)
    }
    
    func cropBounds(viewlayer: CALayer, cornerRadius: Float) {
        
        let imageLayer = viewlayer
        imageLayer.cornerRadius = CGFloat(cornerRadius)
        imageLayer.masksToBounds = true
    }
}
