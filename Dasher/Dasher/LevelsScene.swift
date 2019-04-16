import SpriteKit
import GameplayKit

class LevelsScene: SKScene {

    private var storyLabel: SKLabelNode?
    private var spinnyNode: SKShapeNode?
    private var backButton: UIButton?
    private var clouds: [SKSpriteNode]?
    private var levelButtons: [UIButton]?
    let file = "level.txt"

    //This is the level select screen, it is based off the main menu screen
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

        let lev1Button = UIButton(frame: CGRect(x: 50, y: 50, width: 45, height: 50))
        lev1Button.setImage(UIImage(named: "lev1"), for: [])
        lev1Button.addTarget(self, action: #selector(level1), for: .touchUpInside)
        view.addSubview(lev1Button)
        levelButtons = [lev1Button]

        let lev2Button = UIButton(frame: CGRect(x: 125, y: 50, width: 45, height: 50))
        lev2Button.setImage(UIImage(named: "lev2"), for: [])
        lev2Button.addTarget(self, action: #selector(level2), for: .touchUpInside)
        view.addSubview(lev2Button)
        levelButtons?.append(lev2Button)

        let lev3Button = UIButton(frame: CGRect(x: 200, y: 50, width: 45, height: 50))
        lev3Button.setImage(UIImage(named: "lev3"), for: [])
        lev3Button.addTarget(self, action: #selector(level3), for: .touchUpInside)
        view.addSubview(lev3Button)
        levelButtons?.append(lev3Button)

        let lev4Button = UIButton(frame: CGRect(x: 275, y: 50, width: 45, height: 50))
        lev4Button.setImage(UIImage(named: "lev4"), for: [])
        lev4Button.addTarget(self, action: #selector(level4), for: .touchUpInside)
        view.addSubview(lev4Button)
        levelButtons?.append(lev4Button)

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

        let button = UIButton(frame: CGRect(x: (self.view?.center.x)! - 50, y: 300, width: 100, height: 50))
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

    func level1(sender: UIButton!) {
        let scene = GameScene()
        scene.levelNumber = 0
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(file)
            do {
                let text = String(scene.levelNumber)
                try text.write(to: fileURL, atomically: false, encoding: .utf8)
            } catch {
                print("Error: Couldn't save level")
            }
        }
        goNext(scene: scene)
    }

    func level2(sender: UIButton!) {
        let scene = GameScene()
        scene.levelNumber = 1
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(file)
            do {
                let text = String(scene.levelNumber)
                try text.write(to: fileURL, atomically: false, encoding: .utf8)
            } catch {
                print("Error: Couldn't save level")
            }
        }
        goNext(scene: scene)
    }

    func level3(sender: UIButton!) {
        let scene = GameScene()
        scene.levelNumber = 2
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(file)
            do {
                let text = String(scene.levelNumber)
                try text.write(to: fileURL, atomically: false, encoding: .utf8)
            } catch {
                print("Error: Couldn't save level")
            }
        }
        goNext(scene: scene)
    }

    func level4(sender: UIButton!) {
        let scene = GameScene()
        scene.levelNumber = 3
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(file)
            do {
                let text = String(scene.levelNumber)
                try text.write(to: fileURL, atomically: false, encoding: .utf8)
            } catch {
                print("Error: Couldn't save level")
            }
        }
        goNext(scene: scene)
    }

    func goNext(scene: SKScene) {
        for button in levelButtons! {
            button.removeFromSuperview()
        }
        backButton?.removeFromSuperview()
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
