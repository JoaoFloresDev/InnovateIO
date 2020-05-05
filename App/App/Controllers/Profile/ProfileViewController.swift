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


/// Profile screen:
/// - graphics weight and good habits
/// - abstract
/// - header with general data

class ProfileViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    //    MARK: - Variables
    var imagePicker: UIImagePickerController!
    
    var timerGoalsAnimation: Timer!
    var headerViewHeightConstraint: NSLayoutConstraint!
    var gradientView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    
    //    MARK: - IBOutlet
    
    //BackgroundImages
    @IBOutlet weak var headerBackgroundImg: UIImageView!
    
    //  header
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var profileImgView: UIView!
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var myGoalsTextView: UITextView!
    @IBOutlet weak var currentWeightLabel: UILabel!
    
    //  resume
    @IBOutlet weak var exercicePercentLabel: UILabel!
    @IBOutlet weak var fruitsPercentLabel: UILabel!
    @IBOutlet weak var waterPercentLabel: UILabel!
    
    //  graphics
    @IBOutlet weak var weightGraphicView: UIView!
    @IBOutlet weak var habitsGraphicView: UIView!
    @IBOutlet weak var resumeView: UIView!
    
    @IBOutlet weak var weightGraphicLineView: UIView!
    @IBOutlet weak var habitsGraphicLineView: UIView!
    
    @IBOutlet weak var boxWaterLegend: UIView!
    @IBOutlet weak var boxFruitsLegend: UIView!
    @IBOutlet weak var boxExerciceLegend: UIView!
    
    //    MARK: - IBAction
    @IBAction func selectImgProfile(_ sender: Any) {
        openGalery()
    }
    
    @IBAction func showGoals(_ sender: Any) {
        animateGoals()
    }
    
    //    MARK: - Life Cicle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupStyleViews()
        setupDataProfile()
        setUpdateDataProfileNotification()
        setupGraphic()
        for constraints in headerView.constraints {
            if(constraints.identifier == "headerView") {
                headerViewHeightConstraint = constraints
            }
        }
    }
    
    func setUpdateDataProfileNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateHeaderInformations), name: NSNotification.Name(rawValue: "updateDataProfile"), object: nil)
    }
    
    //    MARK: - @objc functions
    @objc func updateHeaderInformations() {
        ProfimeDataMenager().setupHeaderInformations(goalsTextView: myGoalsTextView,currentWeightLabel: currentWeightLabel)
    }
    
    //    MARK: - Graphics
    func setupGraphic() {
        let dates: NSMutableArray = ["13\n04", "13\n04", "13\n04", "13\n04", "13\n04","13\n04", "13\n04", "13\n04", "13\n04", "13\n04", "13\n04", "13\n04", "13\n04"]
        
        PlotGraphicClass().setLayoutLegends(views: [boxWaterLegend, boxFruitsLegend, boxExerciceLegend])
        PlotGraphicClass().plotGraphicLine(graphicVIew: weightGraphicLineView, numLines: 1, colorArray: [UIColor.black], dates: dates)
        
        PlotGraphicClass().plotGraphicLine(graphicVIew: habitsGraphicLineView, numLines: 3, colorArray: [UIColor.blue, UIColor.purple, UIColor.pink()], dates: dates)
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
        
        StyleClass().cropBounds(viewlayer: profileImg.layer,
                                    cornerRadius: Float(profileImg.frame.size.width/2))
        
        profileImg.image = image
        picker.dismiss(animated: true,completion: nil)
        
        print(ProfimeDataMenager().saveImage(image: image))
    }
    
    //    MARK: - Data Profile
    func setupDataProfile() {
        ProfimeDataMenager().setupNameProfile(nameUser: nameLabel)
        ProfimeDataMenager().setupImgProfile(profileImg: profileImg)
        ProfimeDataMenager().setupHeaderInformations(goalsTextView: myGoalsTextView,
                                                     currentWeightLabel: currentWeightLabel)
        
        ProfimeDataMenager().setupResumeView(exercicePercentLabel: exercicePercentLabel, fruitsPercentLabel: fruitsPercentLabel,waterPercentLabel: waterPercentLabel)
    }
    
    //    MARK: - Animations
    func animateGoals() {
        if let timer = self.timerGoalsAnimation{
            do {
                timer.invalidate()
            }
        }
        if(headerViewHeightConstraint.constant >= 151) {
            self.timerGoalsAnimation = Timer.scheduledTimer(timeInterval: 0.00005, target: self, selector: #selector(self.animateHide), userInfo: nil, repeats: true)
        } else {
            gradientView.removeFromSuperview()
            self.timerGoalsAnimation = Timer.scheduledTimer(timeInterval: 0.00005, target: self, selector: #selector(self.animateShow), userInfo: nil, repeats: true)
        }
    }
    
    @objc func animateShow () {
        let neewSize = 100 + self.myGoalsTextView.contentSize.height
        let sizeWillFill = neewSize - headerViewHeightConstraint.constant
        
        if(headerViewHeightConstraint.constant <= neewSize - 60) {
            headerViewHeightConstraint.constant = headerViewHeightConstraint.constant + 0.02
        } else if(headerViewHeightConstraint.constant < neewSize && headerViewHeightConstraint.constant < 600) {
            headerViewHeightConstraint.constant = headerViewHeightConstraint.constant + sizeWillFill/3000 + 0.0001
        }
        else {
            self.timerGoalsAnimation.invalidate()
        }
    }
    
    @objc func animateHide () {
        let sizeWillFill = headerViewHeightConstraint.constant - 150
        
        if(headerViewHeightConstraint.constant >= 210) {
            headerViewHeightConstraint.constant = headerViewHeightConstraint.constant - 0.02
        }
        else if (headerViewHeightConstraint.constant > 150){
            headerViewHeightConstraint.constant = headerViewHeightConstraint.constant - sizeWillFill/3000 - 0.001
        }
        else {
            self.timerGoalsAnimation.invalidate()
            myGoalsTextView.addSubview(gradientView)
        }
    }
    
    //    MARK: - Style
    
    func setupStyleViews() {
        StyleClass().cropBounds(viewlayer: weightGraphicView.layer, cornerRadius: 10)
        StyleClass().cropBounds(viewlayer: habitsGraphicView.layer, cornerRadius: 10)
        StyleClass().cropBounds(viewlayer: resumeView.layer, cornerRadius: 10)
        
        StyleClass().cropBounds(viewlayer: headerBackgroundImg.layer, cornerRadius: 25)
        StyleClass().cropBounds(viewlayer: profileImgView.layer, cornerRadius: Float(profileImgView.frame.width/2))
        StyleClass().applicShadow(layer: headerView.layer)
        
        
        gradientView = UIView(frame: CGRect(x: 0, y: 0, width: myGoalsTextView.frame.width, height: myGoalsTextView.frame.height))
        StyleClass().appliGradient(view: gradientView)
        myGoalsTextView.addSubview(gradientView)
    }
}
