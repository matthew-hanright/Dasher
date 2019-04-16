//"progressSound" - level-up-01 by shinephoenixstormcrow on freesound.org
//"gameOversound" - Game die by josepharaoh99 on freesound.org
import SpriteKit
import AVFoundation

class Level: SKNode {
    var spikes: [Spike]?
    var targets: [Target]?
    var player: Player?
    var levelGoal: Goal?
    var canWin = true
    var canLose = true
    public var gameScene: GameScene?
    public var progressSound: AVAudioPlayer?
    public var gameOverSound: AVAudioPlayer?

    //A basic level init places the various spikes, targets, goals, and moves the player to the starting point
    func initLevel() {

        initSounds()

        let spike = Spike()
        spike.position = CGPoint(x: 50.0, y: 5.0)
        spike.initSpike()
        addChild(spike)
        spikes = [spike]
        let spike2 = Spike()
        spike2.position = CGPoint(x: 150.0, y: 5.0)
        spike2.initSpike()
        addChild(spike2)
        spikes?.append(spike2)
        let spike3 = Spike()
        spike3.position = CGPoint(x: 250.0, y: 5.0)
        spike3.initSpike()
        addChild(spike3)
        spikes?.append(spike3)

        initLeft()

        for i in 0...3 {
            let newSpike = Spike()
            newSpike.position = CGPoint(x: 54 + (100 * i), y: 731)
            newSpike.initSpike()
            //newSpike.zRotation = CGFloat(.pi/2.0)
            newSpike.yScale = -1
            addChild(newSpike)
            spikes?.append(newSpike)
        }

        initRight()

        let goal = Goal()
        goal.position = CGPoint(x: 350.0, y: 5.0)
        goal.initGoal()
        addChild(goal)
        levelGoal = goal

        player?.position = CGPoint(x: 100, y: 100)
    }

    //This function is for resetting the level
    func clear() {
        spikes = nil
        targets = nil
        player = nil
        levelGoal = nil
        gameScene = nil
    }

    func update() {
        if canWin {
            updateGoal()
        }
        if canLose {
            updateSpikes()
        }
        updateTargets()
    }

    func initSounds() {
        var path = Bundle.main.path(forResource: "progress", ofType: "mp3")!
        var url = URL(fileURLWithPath: path)
        do {
            progressSound = try AVAudioPlayer(contentsOf: url)
        } catch { print("Error loading progress sound") }
        progressSound?.volume = 0.4
        path = Bundle.main.path(forResource: "gameOver", ofType: "mp3")!
        url = URL(fileURLWithPath: path)
        do {
            gameOverSound = try AVAudioPlayer(contentsOf: url)
        } catch { print("Error loading game over sound") }
        gameOverSound?.volume = 0.4
    }

    func updateSpikes() {
        for spike in self.spikes! {
            if spike.intersects(player!) {
                //If the player had intersected a spike, and a game over layer has not been created, make one
                if gameScene?.gameOverLayer != nil {

                } else {
                    let layer = GameOverLayer()
                    layer.zPosition = 100
                    gameScene?.gameOverLayer = layer
                    layer.gameScene = gameScene!
                    gameScene?.addChild(layer)
                    layer.display()
                    player?.isMoving = false
                    player?.goalPoint = player?.position
                    canWin = false
                    gameScene?.themeSound?.stop()
                    gameOverSound?.play()
                }
            }
            if spike.isKind(of: RotatingSpike.self) {
                //If the spike is a rotating one it needs to be updated
                spike.update()
            }
        }
        if !(gameScene?.view?.frame.intersects((player?.frame)!))! {
            //If the player goes out of bounds, they lose
            if gameScene?.gameOverLayer != nil {

            } else {
                let layer = GameOverLayer()
                layer.zPosition = 100
                gameScene?.gameOverLayer = layer
                layer.gameScene = gameScene!
                gameScene?.addChild(layer)
                layer.display()
                player?.isMoving = false
                player?.goalPoint = player?.position
                player?.xSpeed = 0.01
                player?.ySpeed = 0.01
                canWin = false
                gameScene?.themeSound?.stop()
                gameOverSound?.play()
            }
        }
    }

    func updateTargets() {
        for target in targets! {
            if target.intersects(player!) {
                if !target.hasStopped {
                    //If the player intersects a target, stop moving
                    player?.isMoving = false
                    //Ensure the target doesn't prevent the player from moving at the next tap
                    target.hasStopped = true
                }
            }
        }
    }

    func updateGoal() {
        if levelGoal!.intersects(player!) {
            if gameScene?.progressLayer != nil {

            } else {
                let layer = ProgressLayer()
                layer.zPosition = 100
                gameScene?.progressLayer = layer
                layer.gameScene = gameScene!
                gameScene?.addChild(layer)
                layer.display()
                player?.isMoving = false
                player?.goalPoint = player?.position
                player?.xSpeed = 0.01
                player?.ySpeed = 0.01
                canLose = false
                gameScene?.themeSound?.stop()
                progressSound?.play()
            }
        }
    }

    func initRight() {
        //Initializes the spikes on the left edge of the screen
        for i in 0...7 {
            let newSpike = Spike()
            newSpike.position = CGPoint(x: 408, y: 55 + (100 * i))
            newSpike.initSpike()
            newSpike.zRotation = CGFloat(.pi/2.0)
            addChild(newSpike)
            spikes?.append(newSpike)
        }
    }

    func initLeft() {
        //Initializes the spikes on the left edge of the screen
        for i in 0...7 {
            let newSpike = Spike()
            newSpike.position = CGPoint(x: 5, y: 55 + (100 * i))
            newSpike.initSpike()
            newSpike.zRotation = CGFloat(.pi/2.0)
            newSpike.yScale = -1
            addChild(newSpike)
            spikes?.append(newSpike)
        }
    }
}
