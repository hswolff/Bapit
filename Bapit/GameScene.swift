//
//  GameScene.swift
//  Bapit
//
//  Created by Harry Wolff on 7/16/14.
//  Copyright (c) 2014 harrywolff.com. All rights reserved.
//

import SpriteKit

// source: http://stackoverflow.com/questions/24069703/
enum ColliderType: UInt32 {
  case Ball = 1
  case BottomBorder = 2
}

struct TapCount: Printable {
  var hits: Int
  var misses: Int

  // Allow for easy debugging with description
  var description: String {
    return "Hits: \(self.hits) \nMisses: \(self.misses)"
  }
}

class GameScene: SKScene {
  // MARK: -
  // MARK: Properties
  let ballRadius: CGFloat = 50

  var score: TapCount {
    didSet {
      scoreLabel.text = "Score: \(self.score.hits)"
    }
  }

  let ball: SKShapeNode
  let scoreLabel: SKLabelNode
  let bottomBorder: SKNode

  // MARK: -
  // MARK: Init

  required init(coder: NSCoder) {
    fatalError("NSCoding not supported")
  }

  override init(size: CGSize) {
    self.score = TapCount(hits: 0, misses: 0)

    self.ball = SKShapeNode(circleOfRadius: ballRadius)
    self.bottomBorder = SKNode()
    self.scoreLabel = SKLabelNode()

    super.init(size: size)
  }

  override func didMoveToView(view: SKView) {
    self.backgroundColor = SKColor.grayColor()

    self.physicsWorld.gravity = CGVectorMake(0.0, -9.8);
    self.physicsWorld.speed = 1.25
    self.physicsWorld.contactDelegate = self

    self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)

    self.addChild(createBall())
    self.addChild(createBottomBorder())
    self.addChild(createScoreLabel())
  }

  // MARK: -
  // MARK: Elements

  func createBall() -> SKShapeNode {
    ball.fillColor = SKColor.blackColor()
    ball.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));

    ball.physicsBody = SKPhysicsBody(circleOfRadius: ballRadius)
    ball.physicsBody.allowsRotation = false
    ball.physicsBody.restitution = 0.5
    ball.physicsBody.categoryBitMask = ColliderType.Ball.toRaw()
    ball.physicsBody.contactTestBitMask = ColliderType.BottomBorder.toRaw()

    return ball;
  }

  func createBottomBorder() -> SKNode {
    bottomBorder.physicsBody = SKPhysicsBody(edgeLoopFromRect: CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 1))
    bottomBorder.physicsBody.dynamic = false
    bottomBorder.physicsBody.categoryBitMask = ColliderType.BottomBorder.toRaw()

    return bottomBorder
  }

  func createScoreLabel() -> SKLabelNode {
    // Create score label
    scoreLabel.fontName = "Helvetica"
    scoreLabel.fontSize = 22

    // Bottom Left
    scoreLabel.position = CGPointMake(CGRectGetMidX(frame)/3, 20);

    return scoreLabel
  }

  // MARK: -
  // MARK: Interaction

  override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
    /* Called when a touch begins */
        
    for touch: AnyObject in touches {
      let location = touch.locationInNode(self)

      // Only apply an impulse if the touch occured inside the ball
      if ball.containsPoint(location) {
        let point = touch.locationInNode(ball)

        // point.x is where inside the ball the touch occured.
        // We're inverting the value so that a touch on the left causes the ball
        // to move to the right, and vice versa.

        // Directly assign the ball velocity so that its current velocity
        // doesn't negate the added impulse
        ball.physicsBody.velocity = CGVectorMake(-point.x * 10, 500)

        score.hits++
      } else {
        score.misses++
      }

    }

  }

  override func update(currentTime: CFTimeInterval) {
    /* Called before each frame is rendered */
  }
}


extension GameScene: SKPhysicsContactDelegate {
  func didBeginContact(contact: SKPhysicsContact!) {

    if (contact.bodyA.categoryBitMask == ColliderType.BottomBorder.toRaw() &&
        contact.bodyB.categoryBitMask == ColliderType.Ball.toRaw()) {

      // Reset count when you hit the bottom
      score = TapCount(hits: 0, misses: 0)
    }
  }
}