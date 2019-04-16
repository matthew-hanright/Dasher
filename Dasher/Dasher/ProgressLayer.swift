import SpriteKit
import AVFoundation

//This screen displays over the level when the player wins
class ProgressLayer: SKSpriteNode {

    public var gameScene: GameScene?
    let file = "level.txt"

    func display() {

        //Load the text, which is an image
        let progressImage = SKSpriteNode(imageNamed: "progress")
        progressImage.position = CGPoint(x: (gameScene?.view?.center.x)!, y: (gameScene?.view?.center.y)!)
        addChild(progressImage)

        //Set the tap to move on mechanic
        let tapMethod = #selector(nextLevel)
        let tapGesture = UITapGestureRecognizer(target: self, action: tapMethod)
        gameScene?.view?.addGestureRecognizer(tapGesture)

    }

    //This is the function to move on, after the player taps
    func nextLevel() {
        gameScene?.themeSound?.stop()
        //If there is another level, move to it, otherwise return to the main menu
        if (gameScene?.levelNumber)! < (gameScene?.levels?.count)! - 1 {
            //This saves the current level
            if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let fileURL = dir.appendingPathComponent(file)
                do {
                    let text = String((gameScene?.levelNumber)! + 1)
                    try text.write(to: fileURL, atomically: false, encoding: .utf8)
                } catch {
                    print("Error: Couldn't save level")
                }
            }
            let scene = GameScene()
            let view = (gameScene?.view)!
            scene.levelNumber = (gameScene?.levelNumber)! + 1
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            // Adjust the size of the scene to match the view
            let width = view.bounds.width
            let height = view.bounds.height
            scene.size = CGSize(width: width, height: height)
            let reveal = SKTransition.crossFade(withDuration: 1)
            view.presentScene(scene, transition: reveal)
            view.ignoresSiblingOrder = true
        } else {
            let scene = MenuScene()
            let view = (gameScene?.view)!
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
