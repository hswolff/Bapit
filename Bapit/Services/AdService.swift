//
//  AdService.swift
//  Bapit
//
//  Created by Harry Wolff on 1/19/15.
//  Copyright (c) 2015 com.chartbeat. All rights reserved.
//

import Foundation

class AdService: NSObject {

  class var sharedInstance: AdService {
    struct Static {
      static let instance: AdService = AdService()
    }
    return Static.instance
  }

  enum Notifications: String {
    case Toggle = "AdToggleBannerAd"
  }

  override init() {
    super.init()
  }

  class func showBannerAd() {
    NSNotificationCenter.defaultCenter().postNotificationName(AdService.Notifications.Toggle.rawValue, object: ["state": "show"])
  }

  class func hideBannerAd() {
    NSNotificationCenter.defaultCenter().postNotificationName(AdService.Notifications.Toggle.rawValue, object: ["state": "hide"])
  }
}