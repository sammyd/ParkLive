//
//  CarParkRow.swift
//  ParkLive
//
//  Created by Sam Davies on 12/07/2015.
//  Copyright © 2015 VisualPutty. All rights reserved.
//

import WatchKit
import ParkLiveKit

class CarParkRow: NSObject {
  
  @IBOutlet var spacesLabel: WKInterfaceLabel!
  @IBOutlet var nameLabel: WKInterfaceLabel!
  @IBOutlet var spaceGroup: WKInterfaceGroup!
  
  var carpark: CarPark? = nil {
    didSet {
      if let carpark = carpark {
        spacesLabel.setText("\(carpark.capacity - carpark.occupancy)")
        nameLabel.setText(carpark.name)
        let color: UIColor
        switch carpark.percentage {
        case 0...50:
          color = UIColor.plGreen
        case 51...75:
          color = UIColor.plYellow
        case 76...95:
          color = UIColor.plRed
        default:
          color = UIColor.blackColor()
        }
        spaceGroup.setBackgroundColor(color)
      }
    }
  }
}
