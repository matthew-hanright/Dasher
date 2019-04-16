//Theme song - A Ship Came into the harbor by Scanglobe on freesound.org
import SpriteKit
import GameplayKit
import AVFoundation

//This is the main menu
class MenuScene: SKScene {

    private var label: SKLabelNode?
    private var spinnyNode: SKShapeNode?
    private var startButton: UIButton?
    private var levelsButton: UIButton?
    private var storyButton: UIButton?
    private var clouds: [SKSpriteNode]?
    var themeSound: AVAudioPlayer?

    override func didMove(to view: SKView) {

        anchorPoint = CGPoint.zero

        //Load and save theme song
        let path = Bundle.main.path(forResource: "theme", ofType: "mp3")!
        let url = URL(fileURLWithPath: path)
        do {
            themeSound = try AVAudioPlayer(contentsOf: url)
        } catch { print("Error loading progress sound") }
        themeSound?.numberOfLoops = -1 //Make sure it loops forever
        themeSound?.volume = 0.04 //Volume is buggy, seems to increase each time the app is loaded so its set low
        themeSound?.play()

        //The background is not an object because it is a custom
        //version with a scrolling background inbetween two others
        //True background of the mountains (unmoving)
        let background = SKSpriteNode(imageNamed: "menuMountains")
        background.scale(to: CGSize(width: frame.width, height: frame.height))
        let xMid = frame.midX
        let yMid = frame.midY
        background.position = CGPoint(x: xMid, y: yMid)
        background.zPosition = -100
        addChild(background)

        //Fore background of the tree (unmoving)
        let tree = SKSpriteNode(imageNamed: "menuTree")
        tree.scale(to: CGSize(width: frame.width, height: frame.height))
        tree.position = CGPoint(x: xMid, y: yMid)
        tree.zPosition = -90
        addChild(tree)

        //Middle background of the clouds (scrolling)
        let cloud = SKSpriteNode(imageNamed: "menuClouds")
        cloud.position = CGPoint(x: 0.0, y: frame.maxY - 150)
        cloud.zPosition = -99
        addChild(cloud)
        clouds = [cloud]

        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }

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

        //This is the title text
        let titleImage = SKSpriteNode(imageNamed: "title")
        titleImage.position = CGPoint(x: view.center.x, y: view.center.y)
        titleImage.zPosition = 10
        addChild(titleImage)

        //Credits at the bottom
        let nameImage = SKSpriteNode(imageNamed: "name")
        nameImage.position = CGPoint(x: view.center.x, y: view.center.y)
        nameImage.zPosition = 11
        addChild(nameImage)

        //Start button
        let button = UIButton(frame: CGRect(x: (self.view?.center.x)! - 50, y: 300, width: 100, height: 50))
        let buttonImage = UIImage(named: "start")
        button.setImage(buttonImage, for: [])
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)

        self.view?.addSubview(button)
        startButton = button

        //Button for level select
        let button2 = UIButton(frame: CGRect(x: (self.view?.center.x)! - 50, y: 400, width: 100, height: 50))
        let button2Image = UIImage(named: "levels")
        button2.setImage(button2Image, for: [])
        button2.addTarget(self, action: #selector(button2Action), for: .touchUpInside)

        self.view?.addSubview(button2)
        levelsButton = button2

        //Button for story screne
        let button3 = UIButton(frame: CGRect(x: (self.view?.center.x)! - 50, y: 500, width: 100, height: 50))
        let button3Image = UIImage(named: "story")
        button3.setImage(button3Image, for: [])
        button3.addTarget(self, action: #selector(button3Action), for: .touchUpInside)

        self.view?.addSubview(button3)
        storyButton = button3

    }

    override func update(_ currentTime: TimeInterval) {
        //This update function just scrolls the clouds (see Background.swift for details)
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

    //Each of these action functions clears the screen, stops the music, and moves to a new scene
    func buttonAction(sender: UIButton!) {
        themeSound?.stop()
        startButton?.removeFromSuperview()
        levelsButton?.removeFromSuperview()
        storyButton?.removeFromSuperview()
        goNext(scene: GameScene())
    }

    func button2Action(sender: UIButton!) {
        themeSound?.stop()
        startButton?.removeFromSuperview()
        levelsButton?.removeFromSuperview()
        storyButton?.removeFromSuperview()
        goNext(scene: LevelsScene())
    }

    func button3Action(sender: UIButton!) {
        themeSound?.stop()
        startButton?.removeFromSuperview()
        levelsButton?.removeFromSuperview()
        storyButton?.removeFromSuperview()
        goNext(scene: StoryScene())
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
        }
    }

}
