//
//  GameData.swift
//  Bapit
//
//  Created by Harry Wolff on 11/30/14.
//  Copyright (c) 2014 com.chartbeat. All rights reserved.
//

import Foundation

class GameData: NSObject, NSCoding {
    var misses: Int = 0
    var highScore = 0
    var hits: Int = 0 {
        didSet {
            if (self.hits > self.highScore) {
                self.highScore = self.hits

//                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
//                    self.save()
//                })
            }
        }
    }

    class var sharedInstance: GameData {
        struct Static {
            static let instance: GameData = GameData.loadSaved()
        }
        return Static.instance
    }

    required convenience init(coder decoder: NSCoder) {
        self.init()
        self.highScore = decoder.decodeIntegerForKey("highScore")
    }

    func encodeWithCoder(encoder: NSCoder) {
        encoder.encodeInteger(self.highScore, forKey: "highScore")
    }

    func save() {
        let data = NSKeyedArchiver.archivedDataWithRootObject(self)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "gameData")
    }

    func clear() {
        NSUserDefaults.standardUserDefaults().removeObjectForKey("gameData")
    }

    class func loadSaved() -> GameData {
        if let data = NSUserDefaults.standardUserDefaults().objectForKey("gameData") as? NSData {
            return NSKeyedUnarchiver.unarchiveObjectWithData(data) as! GameData
        }
        return GameData()
    }

    func reset() {
        hits = 0
        misses = 0
    }
}

