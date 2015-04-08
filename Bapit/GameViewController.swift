//
//  GameViewController.swift
//  Bapit
//
//  Created by Harry Wolff on 7/16/14.
//  Copyright (c) 2014 harrywolff.com. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
  let adBannerView: GADBannerView = GADBannerView(adSize: kGADAdSizeBanner, origin: CGPointMake(0, 0))

  override func viewDidLoad() {
    super.viewDidLoad()

    setupBannerAd()

    let skView = self.view as! SKView

//    skView.showsFPS = true
//    skView.showsNodeCount = true

    // Sprite Kit applies additional optimizations to improve rendering performance
    skView.ignoresSiblingOrder = true

    let scene = MainMenuScene(size: self.view.frame.size)
    // Set the scale mode to scale to fit the window
    scene.scaleMode = .AspectFill

    skView.presentScene(scene)
  }

  private func setupBannerAd() {
    // Replace this ad unit ID with your own ad unit ID.
    adBannerView.adUnitID = Config.sharedInstance.topBannerAdId
    adBannerView.rootViewController = self;
    adBannerView.hidden = true
    adBannerView.delegate = self

    view.addSubview(adBannerView)

    let adRequest = GADRequest()

    // Requests test ads on devices you specify. Your test device ID is printed to the console when
    // an ad request is made.
    adRequest.testDevices = [GAD_SIMULATOR_ID]

    // Setup notifications for showing/hiding the banner ad
    NSNotificationCenter.defaultCenter().addObserverForName(AdService.Notifications.Toggle.rawValue, object: nil, queue: nil) { note in
      if let object = note.object as? [String: String] {
        if object["state"] == "hide" {
          self.hideBanner()
        } else if object["state"] == "show" {
          self.adBannerView.loadRequest(adRequest)
        }
      }
    }
  }

  override func prefersStatusBarHidden() -> Bool {
    return true
  }
}

extension GameViewController: GADBannerViewDelegate {

  func showBanner() {
    adBannerView.hidden = false

    adBannerView.frame.origin = CGPointMake(0, -adBannerView.frame.size.height)
    UIView.animateWithDuration(0.25, animations: {
      self.adBannerView.frame.origin = CGPointMake(0, 0)
    })
  }

  func hideBanner() {
    UIView.animateWithDuration(0.25, delay: 0.25, options: .CurveEaseInOut, animations: { () in
      self.adBannerView.frame.origin = CGPointMake(0, -self.adBannerView.frame.size.height)
    }, completion: { completed in
        self.adBannerView.hidden = true
    })
  }

  func adViewDidReceiveAd(adBannerView: GADBannerView!) {
    showBanner()
  }

  func adView(adBannerView: GADBannerView!, didFailToReceiveAdWithError error: GADRequestError!) {
    hideBanner()
  }
}