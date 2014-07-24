//
//  GameViewController.swift
//  Bapit
//
//  Created by Harry Wolff on 7/16/14.
//  Copyright (c) 2014 harrywolff.com. All rights reserved.
//

import UIKit
import SpriteKit

extension SKNode {
  class func unarchiveFromFile(file : NSString) -> SKNode? {

    let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks")

    var sceneData = NSData.dataWithContentsOfFile(path, options: .DataReadingMappedIfSafe, error: nil)
    var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)

    archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
    let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as GameScene
    archiver.finishDecoding()
    return scene
  }
}

class GameViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    self.loadFromClass()
//    self.loadFromFile()
  }

  override func prefersStatusBarHidden() -> Bool {
    return true
  }

  func loadFromClass() {
    let scene = GameScene(size: self.view.frame.size)
    // Configure the view.
    let skView = self.view as SKView
    skView.showsFPS = true
    skView.showsNodeCount = true

    /* Sprite Kit applies additional optimizations to improve rendering performance */
    skView.ignoresSiblingOrder = true

    /* Set the scale mode to scale to fit the window */
    scene.scaleMode = .AspectFill

    skView.presentScene(scene)
  }

  func loadFromFile() {
    if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene {
      // Configure the view.
      let skView = self.view as SKView
      skView.showsFPS = true
      skView.showsNodeCount = true

      /* Sprite Kit applies additional optimizations to improve rendering performance */
      skView.ignoresSiblingOrder = true

      /* Set the scale mode to scale to fit the window */
      scene.scaleMode = .AspectFill

      skView.presentScene(scene)
    }
  }
}
