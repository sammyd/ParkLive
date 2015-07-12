//
//  InterfaceController.swift
//  ParkLive WatchKit Extension
//
//  Created by Sam Davies on 12/07/2015.
//  Copyright © 2015 VisualPutty. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {
  
  @IBOutlet var carparkTable: WKInterfaceTable!
  
  var carparks : [CarPark]? {
    didSet {
      guard let carparks = carparks else { return }
      configureTableWithData(carparks)
    }
  }
  
  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
    
    // Configure interface objects here.
    let client = SODAClient(domain: "data.bathhacked.org", token: "d1TbPXUzf0zqTuCy6MDCTtJR6")
    let query = client.queryDataset("u3w2-9yme")
    query.orderDescending("percentage").get {
      results in
      switch(results) {
      case .Dataset(let dataset):
        let carparks = dataset.map { CarPark(dict: $0) }
                              .filter { $0 != nil }
                              .map { $0! }
        self.carparks = carparks
      case .Error(let error):
        print(error)
      }
    }
  }
  
  override func willActivate() {
    // This method is called when watch view controller is about to be visible to user
    super.willActivate()
  }
  
  override func didDeactivate() {
    // This method is called when watch view controller is no longer visible
    super.didDeactivate()
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
