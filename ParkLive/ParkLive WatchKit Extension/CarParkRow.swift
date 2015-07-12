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
        spaceGroup.setBackgroundColor(UIColor.plColourForPercentage(carpark.percentage))
      }
    }
  }
}
