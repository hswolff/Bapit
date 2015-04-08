//
//  ConfigData.swift
//  Bapit
//
//  Created by Harry Wolff on 1/19/15.
//  Copyright (c) 2015 com.chartbeat. All rights reserved.
//

import Foundation

class Config: NSObject {
  let topBannerAdId: String

  class var sharedInstance: Config {
    struct Static {
      static let instance: Config = Config()
    }
    return Static.instance
  }

  override init() {
    // Load Config.plist
    if let path = NSBundle.mainBundle().pathForResource("Config", ofType: "plist"),
       let configDict = NSDictionary(contentsOfFile: path) as? [String: String] {
      topBannerAdId = configDict["topBannerAdId"]!
    } else {
      topBannerAdId = ""
    }

    super.init()
  }
}