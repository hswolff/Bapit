//
//  GameOverScene.swift
//  Bapit
//
//  Created by Harry Wolff on 8/9/14.
//  Copyright (c) 2014 com.chartbeat. All rights reserved.
//

import SpriteKit

class GameOverScene: SKScene {
  let mainMenuButtonName = "mainMenuButton"

  let score: Int

  required init(coder aDecoder: NSCoder) {
    fatalError("NSCoding not supported")
  }

  init(size: CGSize, score: Int) {
    self.score = score
    super.init(size: size)
  }

  override func didMoveToView(view: SKView) {
    self.addChild(createHeadingLabel())
    self.addChild(createScoreResultLabel())
    self.addChild(createHighScoreLabel())
    self.addChild(createMainMenuButton())
  }

  func createHeadingLabel() -> SKLabelNode {
    let label = SKLabelNode(fontNamed: "Helvetica")
    label.position = CGPointMake(frame.width / 2, CGRectGetMidY(frame) * 1.5)
    label.color = SKColor.grayColor()
    label.text = "Game Over"

    return label
  }

  func createScoreResultLabel() -> SKLabelNode {
    let label = SKLabelNode(fontNamed: "Helvetica")
    label.position = CGPointMake(frame.width / 2, CGRectGetMidY(frame))
    label.color = SKColor.grayColor()
    label.text = "Score: \(score)"

    return label
  }

  func createHighScoreLabel() -> SKLabelNode {
    let label = SKLabelNode(fontNamed: "Helvetica")
    label.position = CGPointMake(frame.width / 2, CGRectGetMidY(frame) / 2)
    label.color = SKColor.grayColor()
    label.text = "High Score: \(TapCount.highest)"

    return label
  }

  func createMainMenuButton() -> SKLabelNode {
    let label = SKLabelNode(fontNamed: "Helvetica")
    label.position = CGPointMake(frame.width / 2, CGRectGetMidY(frame) / 3)
    label.color = SKColor.grayColor()
    label.name = self.mainMenuButtonName
    label.text = "Main Menu"

    return label
  }

  override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
    let touch = touches.anyObject() as UITouch
    let location = touch.locationInNode(self)
    let node = self.nodeAtPoint(location)

    if node.name == mainMenuButtonName {
      let scene = MainMenuScene(size: frame.size)
      let transition = SKTransition.flipHorizontalWithDuration(0.50)
      view?.presentScene(scene, transition: transition)
    } else {
      let scene = GameScene(size: frame.size)
      let transition = SKTransition.revealWithDirection(.Up, duration: 0.50)
      view?.presentScene(scene, transition: transition)
    }
  }
}
