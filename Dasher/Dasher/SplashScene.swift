import SpriteKit

class SplashScene: SKScene {

    private var spinnyNode: SKShapeNode?
    private let splashTime = 2.0
    private var startTime: NSDate?

    //Splash screne when the app is loaded
    override func didMove(to view: SKView) {

        anchorPoint = CGPoint.zero

        //Sets the start time, used for fading the splash screne at the right time
        startTime = NSDate()

        //Static background image of the fake studio logo
        let background = SKSpriteNode(imageNamed: "studioLogo.png")
        let xMid = frame.midX
        let yMid = frame.midY
        background.position = CGPoint(x: xMid, y: yMid)
        background.scale(to: CGSize(width: frame.width, height: frame.height))
        addChild(background)

        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)

        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5

            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
    }
    override func update(_ currentTime: TimeInterval) {
        //This function checks if enough time has passed since the splash loaded to move on
        let currentTime = NSDate()
        if currentTime.timeIntervalSince(startTime! as Date) >= splashTime {
            goNext(scene: MenuScene())
        }
    }

    func goNext(scene: SKScene) {
        // view is an SKView? so we have to check
        if let view = self.view {
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            // Adjust the size of the scene to match the view
            let width = view.bounds.width
            let height = view.bounds.height
            scene.size = CGSize(width: width, height: height)
            let reveal = SKTransition.crossFade(withDuration: 1)
            view.presentScene(scene, transition: reveal)
            view.ignoresSiblingOrder = true
        }
    }

}
