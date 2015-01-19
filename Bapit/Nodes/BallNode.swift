//
//  BallNode.swift
//  Bapit
//
//  Created by Harry Wolff on 10/19/14.
//  Copyright (c) 2014 com.chartbeat. All rights reserved.
//

import SpriteKit

enum BallMode: Int {
  case Game = 1
  case Demo = 2
}

class BallNode: SKShapeNode {
  let ballRadius: CGFloat = 50

  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  init(mode: BallMode) {
    super.init()

    configure()

    switch mode {
    case .Game:
      configureGameMode()
    case .Demo:
      configureDemoMode()
    }
  }

  func configure() {
    var circle = CGRectMake(-ballRadius, -ballRadius, ballRadius*2, ballRadius*2);
    path = UIBezierPath(ovalInRect: circle).CGPath
    fillColor = SKColor.blackColor()

    let physicsBody = SKPhysicsBody(polygonFromPath: path)
    physicsBody.categoryBitMask = ColliderType.Ball.rawValue
    physicsBody.contactTestBitMask = ColliderType.BottomBorder.rawValue
    
    self.physicsBody = physicsBody
  }

  func configureGameMode() {
    if let physicsBody = physicsBody {
      physicsBody.allowsRotation = false
      physicsBody.restitution = 0.5
    }
  }

  func configureDemoMode() {
    if let physicsBody = physicsBody {
      physicsBody.allowsRotation = true
      physicsBody.mass = 0.0
      physicsBody.friction = 0.0
      physicsBody.restitution = 1.0
      physicsBody.angularDamping = 0.0
      physicsBody.linearDamping = 0.0
      physicsBody.velocity = CGVectorMake(250, 250)
    }
  }

  func centerInFrame(frame: CGRect) -> BallNode {
    position = CGPoint(x:CGRectGetMidX(frame), y:CGRectGetMidY(frame));
    return self
  }
}
