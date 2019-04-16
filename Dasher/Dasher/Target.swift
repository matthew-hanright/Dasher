import SpriteKit

class Target: SKSpriteNode {

    public var hasStopped = false

    func initTarget() {
        let targetImage = SKSpriteNode(imageNamed: "target")
        addChild(targetImage)
        size = targetImage.size
        self.zPosition = 1
    }

}
