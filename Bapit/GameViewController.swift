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

  override func viewDidLoad() {
    super.viewDidLoad()
    self.loadFromClass()
  }

  override func prefersStatusBarHidden() -> Bool {
    return true
  }

  func loadFromClass() {
    let scene = GameScene(size: self.view.frame.size)
    // Configure the view.
    let skView = self.view as SKView

    setupViewAndPresentScene(skView, scene)
  }

  func setupViewAndPresentScene(skView: SKView, _ scene: SKScene) {
//    skView.showsFPS = true
//    skView.showsNodeCount = true

    /* Sprite Kit applies additional optimizations to improve rendering performance */
    skView.ignoresSiblingOrder = true

    /* Set the scale mode to scale to fit the window */
    scene.scaleMode = .AspectFill

    skView.presentScene(scene)
  }
}
