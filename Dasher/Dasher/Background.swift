import SpriteKit

class Background: SKSpriteNode {
    var foregrounds: [SKSpriteNode]?
    var gameScene: GameScene?
    let scrollSpeed = 2

    //The background object loads two images, and makes the nearer one scroll
    func initBackground() {
        let bg = SKSpriteNode(imageNamed: "blueSky")
        bg.position = CGPoint(x: (gameScene?.frame.midX)!, y: (gameScene?.frame.midY)!)
        bg.zPosition = -100
        addChild(bg)
        let fg = SKSpriteNode(imageNamed: "clouds")
        fg.position = CGPoint(x: (gameScene?.frame.midX)!, y: (gameScene?.frame.midY)!)
        fg.zPosition = -99
        addChild(fg)
        foregrounds = [fg]
    }

    func update() {
        //If the foreground has gone off screen, delete it
        for fg in foregrounds! {
            fg.position.x -= CGFloat(scrollSpeed)
            if fg.frame.maxX < 0 {
                fg.removeFromParent()
                foregrounds?.removeFirst()
            }
        }
        //If the last foreground is fully on the screen, make another to the right of it
        let fg = (foregrounds?.last)!
        if fg.frame.maxX < (gameScene?.view?.frame.maxX)! + 20 {
            let newGround = SKSpriteNode(imageNamed: "clouds")
            newGround.zPosition = -99
            addChild(newGround)
            foregrounds?.append(newGround)
            newGround.position = CGPoint(x: (gameScene?.frame.maxX)! * 1.5, y: fg.position.y)
        }
    }
}
