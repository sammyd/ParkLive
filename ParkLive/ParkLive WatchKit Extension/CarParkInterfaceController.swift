//
//  CarParkInterfaceController.swift
//  ParkLive
//
//  Created by Sam Davies on 12/07/2015.
//  Copyright © 2015 VisualPutty. All rights reserved.
//

import WatchKit
import Foundation
import ParkLiveKit


class CarParkInterfaceController: WKInterfaceController {
  
  @IBOutlet var nameLabel: WKInterfaceLabel!
  @IBOutlet var statusLabel: WKInterfaceLabel!
  @IBOutlet var percentageLabel: WKInterfaceLabel!
  @IBOutlet var percentageRingGroup: WKInterfaceGroup!
  @IBOutlet var totalSpacesLabel: WKInterfaceLabel!
  @IBOutlet var freeSpacesLabel: WKInterfaceLabel!
  @IBOutlet var map: WKInterfaceMap!
  
  var carpark : CarPark? {
    didSet {
      if let carpark = carpark {
        updateUIForCarpark(carpark)
      }
    }
  }
  
  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
    
    // Configure interface objects here.
    if let context = context as? CarParkControllerContext {
      carpark = context.carpark
    }
  }
  
  override func willActivate() {
    // This method is called when watch view controller is about to be visible to user
    super.willActivate()
    if let carpark = carpark {
      percentageRingGroup.startAnimatingWithImagesInRange(NSMakeRange(0,carpark.percentage),
        duration: 1, repeatCount: 1)
    }
  }
  
  override func didDeactivate() {
    // This method is called when watch view controller is no longer visible
    super.didDeactivate()
  }
  
  
  private func updateUIForCarpark(cp: CarPark) {
    nameLabel.setText(cp.name)
    statusLabel.setText("\(cp.status)")
    percentageLabel.setText("\(cp.percentage)%")
    percentageRingGroup.setBackgroundImageNamed("parkring")
    // Will animate this in willActivate()
    
    totalSpacesLabel.setText("\(cp.capacity)")
    freeSpacesLabel.setText("\(cp.capacity - cp.occupancy) Free")
    
    // Update map
    map.addAnnotation(cp.location, withPinColor: .Purple)
    let zoomRegion = MKCoordinateRegionMakeWithDistance(cp.location, 1000, 1000)
    map.setRegion(zoomRegion)
  }
}
