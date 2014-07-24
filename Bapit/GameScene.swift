//
//  GameScene.swift
//  Bapit
//
//  Created by Harry Wolff on 7/16/14.
//  Copyright (c) 2014 harrywolff.com. All rights reserved.
//

import SpriteKit

let ballRadius: CGFloat = 75

class GameScene: SKScene {
  let ball: SKShapeNode = SKShapeNode(circleOfRadius: ballRadius)

  override func didMoveToView(view: SKView) {
    self.backgroundColor = SKColor.grayColor()
    self.physicsWorld.gravity = CGVectorMake(0.0, -9.8);
    self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)

    ball.fillColor = SKColor.blackColor()
    ball.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
    ball.physicsBody = SKPhysicsBody(circleOfRadius: ballRadius)
    ball.physicsBody.allowsRotation = false
    self.addChild(ball)
  }
    
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
        ball.physicsBody.applyImpulse(CGVectorMake(-point.x, 500), atPoint: point)
      }


    }
  }
   
  override func update(currentTime: CFTimeInterval) {
    /* Called before each frame is rendered */
  }
}
