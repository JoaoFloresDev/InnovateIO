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
    
    //    MARK: - IBOutlet
    
    //  header
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var goalsLabel: UILabel!
    
    @IBOutlet weak var profileBackgroundImg: UIImageView!
    @IBOutlet weak var profileImg: UIImageView!
    
    @IBOutlet weak var currentWeightLabel: UILabel!
    @IBOutlet weak var exercicePercentLabel: UILabel!
    @IBOutlet weak var fruitsPercentLabel: UILabel!
    @IBOutlet weak var waterPercentLabel: UILabel!
    
    @IBOutlet weak var weightGraphicView: UIView!
    @IBOutlet weak var habitsGraphicView: UIView!
    
    //  graphic itens
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
    }
    
    //    MARK: - Take Profile Image Functions
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
        {
            image = img
            
        }
        else if let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            image = img
        }
        
        print(profileImg.frame.size.width/2)
        print(profileImg.frame.size.width)
        
        cropBounds(viewlayer: profileImg.layer, cornerRadius: Float(profileImg.frame.size.width/2))
        
        profileImg.image = image
        
        picker.dismiss(animated: true,completion: nil)
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
