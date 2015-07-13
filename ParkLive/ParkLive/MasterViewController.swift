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
      if let carparks = carparks {
        if let oldValue = oldValue where oldValue.count == carparks.count {
          tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Fade)
        } else {
          tableView.reloadData()
        }
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 86
    
    // Prepare the refresh control
    refreshControl = UIRefreshControl()
    refreshControl?.addTarget(self, action: "refreshTableData", forControlEvents: .ValueChanged)
    
    // Load the table data
    automaticRefreshTableData()
    
    // Add a listener to refresh the data when the app hits the foreground
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "automaticRefreshTableData",
      name: UIApplicationDidBecomeActiveNotification, object: nil)
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    addCellDeselectionAnimation()
  }
  
  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self)
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
  
  // MARK: - Utils
  func automaticRefreshTableData() {
    refreshControl?.beginRefreshing()
    refreshTableData()
  }
  
  func refreshTableData() {
    loadTableData() {
      self.refreshControl?.endRefreshing()
    }
  }
  
  private func loadTableData(completionHandler: (() -> ())) {
    getCarParkData {
      carparkData in
      switch carparkData {
      case .Result(let carparks):
        self.carparks = carparks
      case .Error(let error):
        println(error)
      }
      completionHandler()
    }
  }
  
  private func addCellDeselectionAnimation() {
    let indexPath = tableView.indexPathForSelectedRow()
    
    if let indexPath = indexPath,
      let cell = tableView.cellForRowAtIndexPath(indexPath) {
        // In this case, I am appearing, but am already in a parent view controller
        if let transitionCoordinator = transitionCoordinator()
          where transitionCoordinator.initiallyInteractive()
            && !isBeingPresented()
            && !isMovingToParentViewController() {
              transitionCoordinator.animateAlongsideTransition({ _ in
                cell.setSelected(false, animated: true)
                }, completion: { context in
                  if context.isCancelled() {
                    // Reverse the cell selection process
                    cell.setSelected(true, animated: false)
                  } else {
                    // Tell the table about the selection
                    self.tableView.deselectRowAtIndexPath(indexPath, animated: false)
                  }
              })
        } else {
          self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
  }
}

