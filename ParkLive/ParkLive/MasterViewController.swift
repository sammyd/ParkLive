//
//  MasterViewController.swift
//  ParkLive
//
//  Created by Sam Davies on 12/07/2015.
//  Copyright (c) 2015 VisualPutty. All rights reserved.
//

import UIKit
import ParkLiveKit

class MasterViewController: UITableViewController {
  
  private var carparks : [CarPark]? {
    didSet {
      if carparks != nil {
        tableView.reloadData()
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 70
    
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
  
  
  // MARK: - Segues
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "showDetail" {
      if let indexPath = self.tableView.indexPathForSelectedRow(),
        let destVC = segue.destinationViewController as? DetailViewController {
          let carpark = carparks![indexPath.row]
          destVC.carpark = carpark
      }
    }
  }
  
  // MARK: - Table View
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return carparks?.count ?? 0
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as? CarParkTableViewCell,
      let carpark = carparks?[indexPath.row] {
        cell.carpark = carpark
        return cell
    } else {
      return UITableViewCell()
    }
  }
  
}

