import SpriteKit

class LevelTwo: Level {

    override func initLevel() {

        initSounds()

        let target = Target()
        target.position = CGPoint(x: 100, y: 500)
        target.initTarget()
        addChild(target)
        targets = [target]

        let spike = Spike()
        spike.position = CGPoint(x: 350.0, y: 5.0)
        spike.initSpike()
        addChild(spike)
        spikes = [spike]
        for i in 0...1 {
            let newSpike = Spike()
            newSpike.position = CGPoint(x: 150 + (100 * i), y: 5)
            newSpike.initSpike()
            newSpike.yScale = -1
            addChild(newSpike)
            spikes?.append(newSpike)
        }

        initLeft()

        for i in 0...2 {
            let newSpike = Spike()
            newSpike.position = CGPoint(x: 54 + (100 * i), y: 731)
            newSpike.initSpike()
            newSpike.yScale = -1
            addChild(newSpike)
            spikes?.append(newSpike)
        }
        let spike15 = Spike()
        spike15.position = CGPoint(x: 50.0, y: 5.0)
        spike15.initSpike()
        spike15.yScale = -1
        addChild(spike15)
        spikes?.append(spike15)

        initRight()

        let goal = Goal()
        goal.position = CGPoint(x: 354.0, y: 731.0)
        goal.initGoal()
        addChild(goal)
        levelGoal = goal

        for i in 0...2 {
            let newSpike = Spike()
            newSpike.position = CGPoint(x: 200, y: 50 + (100 * i))
            newSpike.initSpike()
            newSpike.zRotation = CGFloat(.pi/2.0)
            newSpike.yScale = -1
            addChild(newSpike)
            spikes?.append(newSpike)
        }

        player?.position = CGPoint(x: 100, y: 100)
    }

}
