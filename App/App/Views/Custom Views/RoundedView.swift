//
//  RoundedView.swift
//  App
//
//  Created by Pietro Pugliesi on 23/04/20.
//  Copyright © 2020 Joao Flores. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class RoundedView:UIView{
	@IBInspectable var cornerRadius:CGFloat = 0{
		didSet{
			layer.cornerRadius = cornerRadius
		}
	}
}
