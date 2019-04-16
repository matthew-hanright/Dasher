//Theme song - A Ship Came into the harbor by Scanglobe on freesound.org
//"meadowSound" - Meadow Ambience by eric5335 on freesound.org
//"windSound" - Wind in tree white birch 01 by Klankbeeld on freesound.org
//"Swoosh sounds" - Swosh by man on freesound.org
import SpriteKit
import GameplayKit
import AVFoundation

//This is the main scene, where most of the computing is done
class GameScene: SKScene {

    private var label: SKLabelNode?
    private var spinnyNode: SKShapeNode?
    public var player: Player?
    public var currentLevel: Level?
    public var levelNumber = 0
    public var levels: [Level]?
    private var skView: SKView?
    public var gameOverLayer: GameOverLayer?
    public var progressLayer: ProgressLayer?
    private var scrollingBackground: BackgroundParalax?
    let file = "level.txt"
    public var themeSound: AVAudioPlayer?
    var meadowSound: AVAudioPlayer?
    var windSound: AVAudioPlayer?
    var swish1Sound: AVAudioPlayer?
    var swish2Sound: AVAudioPlayer?
    var swish3Sound: AVAudioPlayer?

    override func didMove(to view: SKView) {

        anchorPoint = CGPoint.zero
        skView = view

        //Try to load the file that saves the level
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(file)
            do {
                levelNumber = (try Int(String(contentsOf: fileURL, encoding: .utf8)))!
            } catch {
                print("Error loading save data")
            }
        }

        //Initialize the levels and add them to an array so they can be used
        let levelD = LevelDev()
        levels = [levelD]
        let levelOne = LevelOne()
        levels?.append(levelOne)
        let levelTwo = LevelTwo()
        levels?.append(levelTwo)
        let levelThree = LevelThree()
        levels?.append(levelThree)
        currentLevel = levels?[levelNumber]
        initLevel()

        initSounds()

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

        let tapMethod = #selector(GameScene.handleTap(tapGesture:))
        let tapGesture = UITapGestureRecognizer(target: self, action: tapMethod)
        view.addGestureRecognizer(tapGesture)

    }

    func handleTap(tapGesture: UITapGestureRecognizer) {
        //Gets the location of the tap
        let tapLocation = tapGesture.location(in: self.view)
        if !(player?.isMoving)! { //If the player isn't moving, the tap makes it move
            //Get a random number 0-2 to choose which swish sound is played
            let randNum = arc4random_uniform(3)
            if randNum == 0 {
                //Ensure no wish sound is currently playing, then play the right one
                swish1Sound?.stop()
                swish2Sound?.stop()
                swish3Sound?.stop()
                swish1Sound?.play()
            } else if randNum == 1 {
                swish1Sound?.stop()
                swish2Sound?.stop()
                swish3Sound?.stop()
                swish2Sound?.play()
            } else {
                swish1Sound?.stop()
                swish2Sound?.stop()
                swish3Sound?.stop()
                swish3Sound?.play()
            }
            //Sets the goalPoint to the tap location, in the correct form
            player?.goalPoint = CGPoint(x: tapLocation.x, y: self.frame.maxY - tapLocation.y)
            //The player is now moving
            player?.isMoving = true
            //Sets the player's variables so that it will drift in the correct direction when it stops
            if Float((player?.position.x)!) > Float((player?.goalPoint?.x)!) {
                player?.xDrift = 1.0
                player?.xDir = 1
            } else {
                player?.xDrift = -1.0
                player?.xDir = -1
            }
            if Float((player?.position.y)!) > Float((player?.goalPoint?.y)!) {
                player?.yDrift = 1.0
                player?.yDir = 1
            } else {
                player?.yDrift = -1.0
                player?.yDir = -1
            }
        }
    }

    override func update(_ currentTime: TimeInterval) {
        //Update the player, level, and background
        updatePlayer()
        currentLevel?.update()
        scrollingBackground?.update()
        //Pick a random number 1-201 for a random, small chance of the meadow or wind sounds playing
        let randNum = arc4random_uniform(200) + 1
        if randNum == 1 {
            windSound?.stop()
            meadowSound?.stop()
            meadowSound?.play()
        } else if randNum == 2 {
            windSound?.stop()
            meadowSound?.stop()
            windSound?.play()
        }
    }

    func initLevel() {
        //This initializes the level by first clearing everything, the making the background and loading the level
        currentLevel?.removeAllChildren()
        gameOverLayer?.removeAllChildren()
        gameOverLayer?.removeFromParent()
        player?.removeFromParent()
        self.removeAllChildren()
        let background = BackgroundParalax()
        background.gameScene = self
        background.initBackground()
        scrollingBackground = background
        addChild(background)
        addChild(currentLevel!)
        gameOverLayer = nil
        player = nil
        player = Player()
        player?.viewWidth = frame.width
        player?.viewHeight = frame.height
        player?.initPlayer()
        self.addChild(player!)
        currentLevel?.clear()
        currentLevel?.player = player!
        currentLevel?.gameScene = self
        currentLevel?.initLevel()
    }

    func updatePlayer() {
        player?.update()
    }

    func initSounds() {
        //Load all the various sounds
        //Theme song
        var path = Bundle.main.path(forResource: "theme", ofType: "mp3")!
        var url = URL(fileURLWithPath: path)
        do {
            themeSound = try AVAudioPlayer(contentsOf: url)
        } catch { print("Error loading progress sound") }
        themeSound?.numberOfLoops = -1
        themeSound?.volume = 0.04
        themeSound?.play()
        //Meadow sound
        path = Bundle.main.path(forResource: "meadow", ofType: "wav")!
        url = URL(fileURLWithPath: path)
        do {
            meadowSound = try AVAudioPlayer(contentsOf: url)
        } catch { print("Error loading meadow sound") }
        meadowSound?.volume = 0.4
        //Wind sound
        path = Bundle.main.path(forResource: "wind", ofType: "wav")!
        url = URL(fileURLWithPath: path)
        do {
            windSound = try AVAudioPlayer(contentsOf: url)
        } catch { print("Error loading wind sound") }
        windSound?.volume = 0.4
        //Swish 1
        path = Bundle.main.path(forResource: "swoosh1", ofType: "wav")!
        url = URL(fileURLWithPath: path)
        do {
            swish1Sound = try AVAudioPlayer(contentsOf: url)
        } catch { print("Error loading swish1 sound") }
        swish1Sound?.volume = 0.5
        //Swish 2
        path = Bundle.main.path(forResource: "swoosh2", ofType: "wav")!
        url = URL(fileURLWithPath: path)
        do {
            swish2Sound = try AVAudioPlayer(contentsOf: url)
        } catch { print("Error loading swish2 sound") }
        swish2Sound?.volume = 0.5
        //Swish 3
        path = Bundle.main.path(forResource: "swoosh3", ofType: "wav")!
        url = URL(fileURLWithPath: path)
        do {
            swish3Sound = try AVAudioPlayer(contentsOf: url)
        } catch { print("Error loading swoosh3 sound") }
        swish3Sound?.volume = 0.5
    }

}
