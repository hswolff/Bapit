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
  var hits: Int {
    didSet {
      if (self.hits > TapCount.highest) {
        TapCount.highest = self.hits
      }
    }
  }

  var misses: Int

  // Allow for easy debugging with description
  var description: String {
    return "Hits: \(self.hits) \nMisses: \(self.misses)"
  }

  static var highest = 0
}

class GameScene: SKScene {
  // MARK: -
  // MARK: Properties

  var score: TapCount {
    didSet {
      scoreLabel.text = "Score: \(self.score.hits)"
      highScoreLabel.text = "High Score: \(TapCount.highest)"
    }
  }

  let tapToStartLabel = SKLabelNode(fontNamed: "Helvetica")
  let ball: BallNode
  let scoreLabel: SKLabelNode = SKLabelNode()
  let highScoreLabel: SKLabelNode = SKLabelNode()
  let bottomBorder: SKNode = SKNode()

  var started: Bool = false {
    didSet {
      tapToStartLabel.removeFromParent()
    }
  }

  // MARK: -
  // MARK: Init

  required init(coder: NSCoder) {
    fatalError("NSCoding not supported")
  }

  override init(size: CGSize) {
    self.score = TapCount(hits: 0, misses: 0)

    self.ball = BallNode(mode: .Game)

    super.init(size: size)
  }

  override func didMoveToView(view: SKView) {
    self.backgroundColor = SKColor.grayColor()

    self.physicsWorld.gravity = CGVectorMake(0.0, -9.8);
    self.physicsWorld.contactDelegate = self
    // Set speed initially to 0 so that we have a 'resting' state before
    // the user engages with the game
    self.physicsWorld.speed = 0

    self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)

    self.addChild(createTapToStartLabel())
    self.addChild(createBottomBorder())
    self.addChild(createScoreLabel())
    self.addChild(createHighScoreLabel())
    self.addChild(ball.centerInFrame(frame))
  }

  // MARK: -
  // MARK: Elements

  func createTapToStartLabel() -> SKLabelNode {
    tapToStartLabel.color = SKColor.grayColor()
    tapToStartLabel.text = "Tap to start"
    tapToStartLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) + 100);

    return tapToStartLabel
  }

  func createBottomBorder() -> SKNode {
    let physicsBody = SKPhysicsBody(edgeLoopFromRect: CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 1))
    physicsBody.dynamic = false
    physicsBody.categoryBitMask = ColliderType.BottomBorder.rawValue

    bottomBorder.physicsBody = physicsBody

    return bottomBorder
  }

  func createScoreLabel() -> SKLabelNode {
    // Create score label
    scoreLabel.fontName = "Helvetica"
    scoreLabel.fontSize = 22

    // Bottom Left
    scoreLabel.position = CGPointMake(CGRectGetMidX(frame)/3, frame.height - 64);

    return scoreLabel
  }

  func createHighScoreLabel() -> SKLabelNode {
    // Create score label
    highScoreLabel.fontName = "Helvetica"
    highScoreLabel.fontSize = 22

    // Bottom Left
    highScoreLabel.position = CGPointMake(CGRectGetMidX(frame)/2, frame.height - 32);

    return highScoreLabel
  }

  // MARK: -
  // MARK: Interaction

  override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
    var hit = false

    if (!started) {
      started = true
      self.physicsWorld.speed = 1.25
    }
        
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
        ball.physicsBody?.velocity = CGVectorMake(-point.x * 10, 500)

        hit = true
      }
    }

    if (hit) {
      score.hits++
    } else {
      score.misses++
    }

  }

  override func update(currentTime: CFTimeInterval) {
    /* Called before each frame is rendered */
  }
}

// MARK: -
// MARK: Collisions (Game Over Present)
extension GameScene: SKPhysicsContactDelegate {
  func didBeginContact(contact: SKPhysicsContact!) {

    if (contact.bodyA.categoryBitMask == ColliderType.BottomBorder.rawValue &&
        contact.bodyB.categoryBitMask == ColliderType.Ball.rawValue) {

      let gameOverScene = GameOverScene(size: frame.size, score: score.hits)
      let transition = SKTransition.pushWithDirection(.Down, duration: 0.5)
      view?.presentScene(gameOverScene, transition: transition)
    }
  }
}
