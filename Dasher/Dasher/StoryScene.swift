import SpriteKit
import GameplayKit

class StoryScene: SKScene {

    private var spinnyNode: SKShapeNode?
    private var backButton: UIButton?
    private var clouds: [SKSpriteNode]?

    //This scene is basically the same as the main menu, but with the story text and only one button
    override func didMove(to view: SKView) {

        anchorPoint = CGPoint.zero

        let background = SKSpriteNode(imageNamed: "menuMountains")
        background.scale(to: CGSize(width: frame.width, height: frame.height))
        let xMid = frame.midX
        let yMid = frame.midY
        background.position = CGPoint(x: xMid, y: yMid)
        background.zPosition = -100
        addChild(background)

        let tree = SKSpriteNode(imageNamed: "menuTree")
        tree.scale(to: CGSize(width: frame.width, height: frame.height))
        tree.position = CGPoint(x: xMid, y: yMid)
        tree.zPosition = -90
        addChild(tree)

        let cloud = SKSpriteNode(imageNamed: "menuClouds")
        cloud.position = CGPoint(x: 0.0, y: frame.maxY - 150)
        cloud.zPosition = -99
        addChild(cloud)
        clouds = [cloud]

        let storyParagraphImage = SKSpriteNode(imageNamed: "storyParagraph")
        storyParagraphImage.position = CGPoint(x: view.center.x, y: view.center.y)
        addChild(storyParagraphImage)

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

        let button = UIButton(frame: CGRect(x: (self.view?.center.x)! - 50, y: 500, width: 100, height: 50))
        let buttonImage = UIImage(named: "back")
        button.setImage(buttonImage, for: [])
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)

        self.view?.addSubview(button)
        backButton = button
    }

    override func update(_ currentTime: TimeInterval) {
        for cloud in clouds! {
            cloud.position.x -= CGFloat(2)
            if cloud.frame.maxX < 0 {
                cloud.removeFromParent()
                clouds?.removeFirst()
            }
        }
        let cloud = (clouds?.last)!
        if cloud.frame.maxX < frame.width * 2 {
            let newCloud = SKSpriteNode(imageNamed: "menuClouds")
            newCloud.zPosition = -99
            addChild(newCloud)
            clouds?.append(newCloud)
            newCloud.position = CGPoint(x: cloud.frame.maxX, y: cloud.position.y)
        }
    }

    func buttonAction(sender: UIButton!) {
        backButton?.removeFromSuperview()
        goNext(scene: MenuScene())
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
            let reveal = SKTransition.crossFade(withDuration: 2)
            view.presentScene(scene, transition: reveal)
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

}
