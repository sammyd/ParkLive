//
//  ParkLiveColours.swift
//  ParkLive
//
//  Created by Sam Davies on 12/07/2015.
//  Copyright (c) 2015 VisualPutty. All rights reserved.
//

import UIKit

extension UIColor {
  public static var plGreen : UIColor {
    return UIColor(red: 54/255.0, green: 115/255.0, blue: 38/255.0, alpha: 1.0)
  }
  
  public static var plYellow : UIColor {
    return UIColor(red: 141/255.0, green: 135/255.0, blue: 47/255.0, alpha: 1.0)
  }
  
  public static var plRed : UIColor {
    return UIColor(red: 143/255.0, green: 48/255.0, blue: 56/255.0, alpha: 1.0)
  }
  
  public static var plDarkPurple : UIColor {
    return UIColor(red: 79/255.0, green: 34/255.0, blue: 102/255.0, alpha: 1.0)
  }
  
  public static var plLightPurple : UIColor {
    return UIColor(red: 109/255.0, green: 49/255.0, blue: 107/255.0, alpha: 1.0)
  }
  
  public static var plPink : UIColor {
    return UIColor(red: 186/255.0, green: 68/255.0, blue: 193/255.0, alpha: 1.0)
  }
}


extension UIColor {
  public static func plColourForPercentage(percentage: Int) -> UIColor {
    let color : UIColor
    switch percentage {
    case 0...50:
      color = UIColor.plGreen
    case 51...75:
      color = UIColor.plYellow
    case 76...95:
      color = UIColor.plRed
    default:
      color = UIColor.blackColor()
    }
    return color
  }
}
