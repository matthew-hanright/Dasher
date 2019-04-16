import SpriteKit

class Goal: SKSpriteNode {

    func initGoal() {
        let goalImage = SKSpriteNode(imageNamed: "goal")
        addChild(goalImage)
        size = goalImage.size
        self.zPosition = 1
    }

}
