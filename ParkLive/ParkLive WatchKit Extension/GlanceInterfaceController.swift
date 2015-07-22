//
//  GlanceInterfaceController.swift
//  ParkLive
//
//  Created by Sam Davies on 14/07/2015.
//  Copyright (c) 2015 VisualPutty. All rights reserved.
//

import WatchKit
import Foundation
import ParkLiveKit


class GlanceInterfaceController: WKInterfaceController {

  @IBOutlet weak var nameLabel: WKInterfaceLabel!
  @IBOutlet weak var primaryPCLabel: WKInterfaceLabel!
  @IBOutlet weak var smallPCLabel1: WKInterfaceLabel!
  @IBOutlet weak var smallPCLabel2: WKInterfaceLabel!
  @IBOutlet weak var smallPCLabel3: WKInterfaceLabel!
  @IBOutlet weak var primaryPCBackground: WKInterfaceGroup!
  @IBOutlet weak var smallPCBackground1: WKInterfaceGroup!
  @IBOutlet weak var smallPCBackground2: WKInterfaceGroup!
  @IBOutlet weak var smallPCBackground3: WKInterfaceGroup!
  @IBOutlet weak var detailsLabel: WKInterfaceLabel!
  
  private var primaryCarPark : CarPark? {
    didSet {
      if let primaryCarPark = primaryCarPark {
        applyPrimaryCarPark(primaryCarPark)
      }
    }
  }
  
  private var supplementaryCarParks : [CarPark] = [CarPark]() {
    didSet {
      applySupplementaryCarParks(supplementaryCarParks)
    }
  }
  
  private var lastUpdated : NSDate?
  
  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
    
    // Configure interface objects here.
    updateData()
  }

  override func willActivate() {
    // This method is called when watch view controller is about to be visible to user
    super.willActivate()
    if let lastUpdated = lastUpdated where NSDate().timeIntervalSinceDate(lastUpdated) > 60 {
      updateData()
    }
  }
  
  override func didDeactivate() {
    // This method is called when watch view controller is no longer visible
    super.didDeactivate()
  }
  
  func updateData() {
    getCarParkData {
      data in
      switch data {
      case .Error(let error):
        println("Error: \(error.localizedDescription)")
      case .Result(let carparks):
        self.lastUpdated = NSDate()
        self.processNewCarParkData(carparks)
      }
    }
  }
  
  private func processNewCarParkData(carparks: [CarPark]) {
    // Load the settings
    if let settings = NSUserDefaults(suiteName: "group.visualputty.ParkLive"),
      let favouriteCarPark = settings.stringForKey("favourite_carpark")
      where settings.boolForKey("display_favourite") {
        // Does the favourite car park actually exist?
        let favCP = carparks.filter { $0.name == favouriteCarPark }
        if favCP.count == 1 {
          primaryCarPark = favCP.first
          supplementaryCarParks = Array(carparks.filter { $0.name != favouriteCarPark }[0...2])
          return
        }
    }

    primaryCarPark = carparks.first
    if carparks.count >= 4 {
      supplementaryCarParks = Array(carparks[1...3])
    }
  }
  
  private func applyPrimaryCarPark(carpark: CarPark) {
    nameLabel.setText(carpark.name)
    primaryPCLabel.setText("\(carpark.percentage)%")
    if carpark.percentage > 0 {
      primaryPCBackground.setBackgroundImageNamed("largering_")
      primaryPCBackground.startAnimatingWithImagesInRange(NSMakeRange(0,carpark.percentage),
        duration: 1, repeatCount: 1)
    } else {
      primaryPCBackground.setBackgroundImageNamed("largering_0")
    }
    let freeSpaces = carpark.capacity - carpark.occupancy
    detailsLabel.setText("\(freeSpaces) / \(carpark.capacity) free")
  }
  
  private func applySupplementaryCarParks(carparks: [CarPark]) {
    // Early exit if not enough car parks
    if carparks.count != 3 { return }
    
    // Deal with background colours
    for (carpark, background) in zip(carparks, [smallPCBackground1, smallPCBackground2, smallPCBackground3]) {
      background.setBackgroundColor(UIColor.plColourForPercentage(carpark.percentage))
    }
    
    // And now the percentage labels
    for (carpark, label) in zip(carparks, [smallPCLabel1, smallPCLabel2, smallPCLabel3]) {
      label.setText("\(carpark.percentage)%")
    }
  }
  
}
