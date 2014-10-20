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
    physicsBody.categoryBitMask = ColliderType.Ball.toRaw()
    physicsBody.contactTestBitMask = ColliderType.BottomBorder.toRaw()
    self.physicsBody = physicsBody
  }

  func configureGameMode() {
    if let physics = physicsBody {
      physics.allowsRotation = false
      physics.restitution = 0.5
    }
  }

  func configureDemoMode() {
    if let physics = physicsBody {
      physics.allowsRotation = true
      physics.mass = 0.0
      physics.friction = 0.0
      physics.restitution = 1.0
      physics.angularDamping = 0.0
      physics.linearDamping = 0.0
      physics.velocity = CGVectorMake(250, 250)
    }
  }

  func centerInFrame(frame: CGRect) -> BallNode {
    position = CGPoint(x:CGRectGetMidX(frame), y:CGRectGetMidY(frame));
    return self
  }
}
