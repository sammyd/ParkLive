//
//  DetailViewController.swift
//  ParkLive
//
//  Created by Sam Davies on 12/07/2015.
//  Copyright (c) 2015 VisualPutty. All rights reserved.
//

import UIKit
import ParkLiveKit
import MapKit

class DetailViewController: UIViewController {
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var percentageLabel: UILabel!
  @IBOutlet weak var percentageBackground: CircularView!
  @IBOutlet weak var totalSpacesLabel: UILabel!
  @IBOutlet weak var availableSpacesLabel: UILabel!
  @IBOutlet weak var statusLabel: UILabel!
  @IBOutlet weak var detailsLabel: UILabel!
  @IBOutlet weak var mapView: MKMapView!

  var carpark: CarPark? {
    didSet {
      // Update the view.
      self.configureView()
    }
  }
  
  func configureView() {
    // Update the user interface for the detail item.
    if let carpark = carpark {
      nameLabel?.text = carpark.name
      percentageLabel?.text = "\(carpark.percentage)%"
      percentageBackground?.backgroundColor = UIColor.plColourForPercentage(carpark.percentage)
      totalSpacesLabel?.text = "\(carpark.capacity) Total Spaces"
      availableSpacesLabel?.text = "\(carpark.capacity - carpark.occupancy) Available"
      statusLabel?.text = "\(carpark.status)"
      detailsLabel?.text = "\(carpark.description)"
      
      let zoomRegion = MKCoordinateRegionMakeWithDistance(carpark.location, 1000, 1000)
      mapView?.setRegion(zoomRegion, animated: true)
      
      let annotation = MKPointAnnotation()
      annotation.coordinate = carpark.location
      mapView?.addAnnotation(annotation)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    self.configureView()
  }
  
}

