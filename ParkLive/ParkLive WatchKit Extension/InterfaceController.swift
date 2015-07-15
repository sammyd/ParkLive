//
//  InterfaceController.swift
//  ParkLive WatchKit Extension
//
//  Created by Sam Davies on 12/07/2015.
//  Copyright © 2015 VisualPutty. All rights reserved.
//

import WatchKit
import Foundation
import ParkLiveKit

class CarParkControllerContext {
  let carpark : CarPark
  
  init(carpark: CarPark) {
    self.carpark = carpark
  }
}

class InterfaceController: WKInterfaceController {
  
  @IBOutlet var carparkTable: WKInterfaceTable!
  var refreshTimer: NSTimer?
  
  var carparks : [CarPark]? {
    didSet {
      if let carparks = carparks {
        configureTableWithData(carparks)
      }
    }
  }
  
  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
    
    // Configure interface objects here.
    loadTableData()
    refreshTimer = NSTimer.scheduledTimerWithTimeInterval(60, target: self,
      selector: "handleRefresh", userInfo: nil, repeats: true)
  }
  
  override func willActivate() {
    // This method is called when watch view controller is about to be visible to user
    super.willActivate()
  }
  
  override func didDeactivate() {
    // This method is called when watch view controller is no longer visible
    super.didDeactivate()
  }
  
  deinit {
    refreshTimer?.invalidate()
    refreshTimer = nil
  }
  
  override func contextForSegueWithIdentifier(segueIdentifier: String, inTable table: WKInterfaceTable, rowIndex: Int) -> AnyObject? {
    if let carparks = carparks {
    
    let carpark = carparks[rowIndex]
    return CarParkControllerContext(carpark: carpark)
    } else {
      return nil
    }
  }
  
  @IBAction func handleRefresh() {
    loadTableData()
  }
  
  private func loadTableData() {
    getCarParkData {
      carparkData in
      switch carparkData {
      case .Result(let carparks):
        self.carparks = carparks
      case .Error(let error):
        println(error)
      }
    }
  }
  
  private func configureTableWithData(data: [CarPark]) {
    carparkTable.setNumberOfRows(data.count, withRowType: "CarParkRow")
    for i in 0..<data.count {
      if let row = carparkTable.rowControllerAtIndex(i) as? CarParkRow {
        let carpark = data[i]
        row.carpark = carpark
      }
    }
  }
  
}
