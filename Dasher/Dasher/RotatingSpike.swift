import SpriteKit

class RotatingSpike: Spike {

    private let rotateSpeed = CGFloat(.pi/40.0)

    override func initSpike() {
        let spikeImage = SKSpriteNode(imageNamed: "longBranch")
        addChild(spikeImage)
        size = spikeImage.size
    }

    override func update() {
        zRotation += rotateSpeed
    }

}
