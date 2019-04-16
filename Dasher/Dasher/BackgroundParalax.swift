import SpriteKit

class BackgroundParalax: SKSpriteNode {
    var foregrounds1: [SKSpriteNode]?
    var foregrounds2: [SKSpriteNode]?
    var foregrounds3: [SKSpriteNode]?
    var gameScene: GameScene?
    let scrollSpeed = 2
    let scrollSpeed2 = 3
    let scrollSpeed3 = 1

    //This is a modified version of the background objects for multiple scrolling foregrounds
    //It acts the same as the regular background objects, but three times over
    func initBackground() {
        let bg = SKSpriteNode(imageNamed: "blueSky")
        bg.position = CGPoint(x: (gameScene?.frame.midX)!, y: (gameScene?.frame.midY)!)
        bg.zPosition = -100
        addChild(bg)
        let fg = SKSpriteNode(imageNamed: "clouds")
        fg.position = CGPoint(x: (gameScene?.frame.midX)!, y: (gameScene?.frame.midY)!)
        fg.zPosition = -99
        addChild(fg)
        foregrounds1 = [fg]
        let fg2 = SKSpriteNode(imageNamed: "clouds2")
        fg2.position = CGPoint(x: (gameScene?.frame.midX)!, y: (gameScene?.frame.midY)!)
        fg2.zPosition = -98
        addChild(fg2)
        foregrounds2 = [fg2]
        let fg3 = SKSpriteNode(imageNamed: "clouds3")
        fg3.position = CGPoint(x: (gameScene?.frame.midX)!, y: (gameScene?.frame.midY)!)
        fg3.zPosition = -97
        addChild(fg3)
        foregrounds3 = [fg3]
    }

    func update() {
        for fg in foregrounds1! {
            fg.position.x -= CGFloat(scrollSpeed)
            if fg.frame.maxX < 0 {
                fg.removeFromParent()
                foregrounds1?.removeFirst()
            }
        }
        let fg = (foregrounds1?.last)!
        if fg.frame.maxX < (gameScene?.view?.frame.maxX)! + 20 {
            let newGround = SKSpriteNode(imageNamed: "clouds")
            newGround.zPosition = -99
            addChild(newGround)
            foregrounds1?.append(newGround)
            newGround.position = CGPoint(x: (gameScene?.frame.maxX)! * 1.5, y: fg.position.y)
        }
        for fg in foregrounds2! {
            fg.position.x -= CGFloat(scrollSpeed2)
            if fg.frame.maxX < 0 {
                fg.removeFromParent()
                foregrounds2?.removeFirst()
            }
        }
        let fg2 = (foregrounds2?.last)!
        if fg2.frame.maxX < (gameScene?.view?.frame.maxX)! + 20 {
            let newGround = SKSpriteNode(imageNamed: "clouds2")
            newGround.zPosition = -98
            addChild(newGround)
            foregrounds2?.append(newGround)
            newGround.position = CGPoint(x: (gameScene?.frame.maxX)! * 1.5, y: fg2.position.y)
        }
        for fg in foregrounds3! {
            fg.position.x -= CGFloat(scrollSpeed3)
            if fg.frame.maxX < 0 {
                fg.removeFromParent()
                foregrounds3?.removeFirst()
            }
        }
        let fg3 = (foregrounds3?.last)!
        if fg3.frame.maxX < (gameScene?.view?.frame.maxX)! + 20 {
            let newGround = SKSpriteNode(imageNamed: "clouds3")
            newGround.zPosition = -97
            addChild(newGround)
            foregrounds3?.append(newGround)
            newGround.position = CGPoint(x: (gameScene?.frame.maxX)! * 1.5, y: fg3.position.y)
        }
    }
}
