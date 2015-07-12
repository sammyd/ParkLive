//
//  ParkLiveData.swift
//  ParkLive
//
//  Created by Sam Davies on 12/07/2015.
//  Copyright (c) 2015 VisualPutty. All rights reserved.
//

import SODAKit

public enum ParkLiveData {
  case Result([CarPark])
  case Error(NSError)
}

public func getCarParkData(callback: (ParkLiveData) -> ()) {
  let client = SODAClient(domain: "data.bathhacked.org", token: "d1TbPXUzf0zqTuCy6MDCTtJR6")
  let query = client.queryDataset("u3w2-9yme")
  query.orderDescending("percentage").get {
    results in
    switch(results) {
    case .Dataset(let dataset):
      let carparks = dataset.map { CarPark(dict: $0) }
        .filter { $0 != nil }
        .map { $0! }
      callback(.Result(carparks))
    case .Error(let error):
      callback(.Error(error))
    }
  }
}
