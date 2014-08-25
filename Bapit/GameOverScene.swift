//
//  GameOverScene.swift
//  Bapit
//
//  Created by Harry Wolff on 8/9/14.
//  Copyright (c) 2014 com.chartbeat. All rights reserved.
//

import SpriteKit

class GameOverScene: SKScene {
  let score: Int

  required init(coder aDecoder: NSCoder) {
    fatalError("NSCoding not supported")
  }

  init(size: CGSize, score: Int) {
    self.score = score
    super.init(size: size)
  }

  override func didMoveToView(view: SKView!) {
    self.addChild(createHeadingLabel())
    self.addChild(createScoreResultLabel())
    self.addChild(createHighScoreLabel())
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

  override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
    let scene = GameScene(size: frame.size)
    //      let transition = SKTransition.revealWithDirection(.Left, duration: 0.75)
    let transition = SKTransition.doorwayWithDuration(0.5)
    view.presentScene(scene)
  }
}
