//
//  MainMenuScene.swift
//  Bapit
//
//  Created by Harry Wolff on 8/24/14.
//  Copyright (c) 2014 com.chartbeat. All rights reserved.
//

import SpriteKit

enum ButtonNames: String {
  case Play = "playButton"
  case Settings = "settingsButton"
}

class MainMenuScene: SKScene {

  required init(coder aDecoder: NSCoder) {
    fatalError("NSCoding not supported")
  }

  override init(size: CGSize) {
    super.init(size: size)
  }

  override func didMoveToView(view: SKView) {
    self.addChild(createHeadingLabel())
    self.addChild(createPlayButton())
    self.addChild(createSettingsButton())
  }

  func createHeadingLabel() -> SKLabelNode {
    let label = SKLabelNode(fontNamed: "Helvetica")
    label.position = CGPointMake(frame.width / 2, CGRectGetMidY(frame) * 1.5)
    label.color = SKColor.grayColor()
    label.fontSize = 40
    label.text = "Bapit"

    return label
  }

  func createPlayButton() -> SKLabelNode {
    let label = SKLabelNode(fontNamed: "Helvetica")
    label.position = CGPointMake(frame.width / 2, CGRectGetMidY(frame))
    label.color = SKColor.grayColor()
    label.fontSize = 28
    label.name = ButtonNames.Play.toRaw()
    label.text = "Play"

    return label
  }

  func createSettingsButton() -> SKLabelNode {
    let label = SKLabelNode(fontNamed: "Helvetica")
    label.position = CGPointMake(frame.width / 2, CGRectGetMidY(frame) / 2)
    label.color = SKColor.grayColor()
    label.name = ButtonNames.Settings.toRaw()
    label.fontSize = 28
    label.text = "Settings"

    return label
  }

  override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
    let touch = touches.anyObject() as UITouch
    let location = touch.locationInNode(self)
    let node = self.nodeAtPoint(location)

    if node.name == ButtonNames.Play.toRaw() {
      let scene = GameScene(size: frame.size)
      let transition = SKTransition.revealWithDirection(.Up, duration: 0.50)
      self.view?.presentScene(scene, transition: transition)
    } else if node.name == ButtonNames.Settings.toRaw() {
      println("Implement settings")
    }

  }

}
