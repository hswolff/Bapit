//
//  GameScene.swift
//  Bapit
//
//  Created by Harry Wolff on 7/16/14.
//  Copyright (c) 2014 harrywolff.com. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
  let ballRadius: CGFloat
  let ball: SKShapeNode

  init(coder aDecoder: NSCoder!)  {
    self.ballRadius = 75
    self.ball = SKShapeNode(circleOfRadius: self.ballRadius)
    super.init(coder: aDecoder)
  }

  override func didMoveToView(view: SKView) {
    self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)

    ball.fillColor = UIColor.blackColor()
    ball.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
    ball.physicsBody = SKPhysicsBody(circleOfRadius: ballRadius)
    ball.physicsBody.allowsRotation = false
    self.addChild(ball)
  }
    
  override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
    /* Called when a touch begins */
        
    for touch: AnyObject in touches {
      ball.physicsBody.applyImpulse(CGVectorMake(0, 500))
    }
  }
   
  override func update(currentTime: CFTimeInterval) {
    /* Called before each frame is rendered */
  }
}
