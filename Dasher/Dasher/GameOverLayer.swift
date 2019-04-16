import SpriteKit
import AVFoundation

//This screen is displayed over the level when the player loses
class GameOverLayer: SKSpriteNode {

    public var gameScene: GameScene?

    func display() {

        //This loads the text, which is an image
        let gameOverImage = SKSpriteNode(imageNamed: "gameOver")
        gameOverImage.position = CGPoint(x: (gameScene?.view?.center.x)!, y: (gameScene?.view?.center.y)!)
        addChild(gameOverImage)

        //This sets the tap to move on mechanic
        let tapMethod = #selector(retry)
        let tapGesture = UITapGestureRecognizer(target: self, action: tapMethod)
        gameScene?.view?.addGestureRecognizer(tapGesture)

    }

    func retry() {
        //This function creates a new GameScene, sets its' level to the current one and loads it
        let scene = GameScene()
        let view = (gameScene?.view)!
        scene.levelNumber = (gameScene?.levelNumber)!
        gameScene?.themeSound?.stop()
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFill
        // Adjust the size of the scene to match the view
        let width = view.bounds.width
        let height = view.bounds.height
        scene.size = CGSize(width: width, height: height)
        let reveal = SKTransition.crossFade(withDuration: 1)
        view.presentScene(scene, transition: reveal)
        view.ignoresSiblingOrder = true
        view.showsFPS = true
        view.showsNodeCount = true
    }

}
