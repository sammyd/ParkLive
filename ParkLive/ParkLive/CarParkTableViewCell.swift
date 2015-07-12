//
//  CarParkTableViewCell.swift
//  ParkLive
//
//  Created by Sam Davies on 12/07/2015.
//  Copyright (c) 2015 VisualPutty. All rights reserved.
//

import UIKit
import ParkLiveKit

class CarParkTableViewCell: UITableViewCell {

  @IBOutlet weak var freeSpaceLabel: UILabel!
  @IBOutlet weak var freeSpaceBackground: CircularView!
  @IBOutlet weak var carParkNameLabel: UILabel!
  
  
  var carpark : CarPark? {
    didSet {
      if let carpark = carpark {
        updateCellWithCarPark(carpark)
      }
    }
  }
  
  private func updateCellWithCarPark(carpark: CarPark) {
    freeSpaceLabel.text = "\(carpark.capacity - carpark.occupancy)"
    freeSpaceBackground.backgroundColor = UIColor.plColourForPercentage(carpark.percentage)
    carParkNameLabel.text = carpark.name
  }
}
