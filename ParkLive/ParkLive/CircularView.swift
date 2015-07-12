//
//  CircularView.swift
//  ParkLive
//
//  Created by Sam Davies on 12/07/2015.
//  Copyright (c) 2015 VisualPutty. All rights reserved.
//

import UIKit

@IBDesignable
class CircularView: UIView {

  @IBInspectable
  var radius : CGFloat = 0.0 {
    didSet {
      layer.cornerRadius = radius
    }
  }

}
