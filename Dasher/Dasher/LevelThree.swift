import SpriteKit

class LevelThree: Level {

    override func initLevel() {

        initSounds()

        let spike = Spike()
        spike.position = CGPoint(x: 350.0, y: 5.0)
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
            newSpike.yScale = -1
            addChild(newSpike)
            spikes?.append(newSpike)
        }

        initRight()

        let goal = Goal()
        goal.position = CGPoint(x: 50.0, y: 5.0)
        goal.initGoal()
        addChild(goal)
        levelGoal = goal

        let rotSpike1 = RotatingSpike()
        rotSpike1.position = CGPoint(x: 300.0, y: 430.0)
        rotSpike1.initSpike()
        addChild(rotSpike1)
        spikes?.append(rotSpike1)

        let target = Target()
        target.position = CGPoint(x: 9000, y: 9000)
        target.initTarget()
        addChild(target)
        targets = [target]

        player?.position = CGPoint(x: 320, y: 680)
    }

}
