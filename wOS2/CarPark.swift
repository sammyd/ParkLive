//
//  CarPark.swift
//  ParkLive
//
//  Created by Sam Davies on 12/07/2015.
//  Copyright © 2015 VisualPutty. All rights reserved.
//

import Foundation
import CoreLocation

enum CarParkStatus {
  case Filling
  case Emptying
  case Unknown
}

extension CarParkStatus {
  init(string: String) {
    switch string {
    case "Emptying":
      self = .Emptying
    case "Filling":
      self = .Filling
    default:
      self = .Unknown
    }
  }
}

extension CarParkStatus : CustomStringConvertible {
  var description : String {
    switch self {
    case .Emptying:
      return "Emptying"
    case .Filling:
      return "Filling"
    case .Unknown:
      return "Unknown"
    }
  }
}

struct CarPark {
  let status: CarParkStatus
  let percentage: Int
  let description: String
  let name: String
  let capacity: Int
  let occupancy: Int
  let location: CLLocationCoordinate2D
}

extension CarPark {
  init?(dict: [String : AnyObject]) {
    guard let statusStr = dict["status"] as? String,
      let percentageStr = dict["percentage"] as? String,
      let percentage = Int(percentageStr),
      let description = dict["description"] as? String,
      let name = dict["name"] as? String,
      let capacityStr = dict["capacity"] as? String,
      let capacity = Int(capacityStr),
      let occupancyStr = dict["occupancy"] as? String,
      let occupancy = Int(occupancyStr),
      let locationDict = dict["location"] as? [String : AnyObject],
      let latitudeStr = locationDict["latitude"] as? String,
      let latitude = Double(latitudeStr),
      let longitudeStr = locationDict["longitude"] as? String,
      let longitude = Double(longitudeStr) else {
        return nil
    }
    self.status = CarParkStatus(string: statusStr)
    self.percentage = percentage
    self.description = description
    self.name = name
    self.capacity = capacity
    self.occupancy = occupancy
    self.location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
  }
}
