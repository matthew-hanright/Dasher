import SpriteKit

class Spike: SKSpriteNode {

    func initSpike() {
        let spikeImage = SKSpriteNode(imageNamed: "branch")
        addChild(spikeImage)
        size = spikeImage.size
    }

    func update() {

    }

}
