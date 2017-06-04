
//
//  SleepRoutine.swift
//  SleepServer
//
//  Created by Marin postma on 04/06/2017.
//
//

import PerfectThread
#if os(Linux)
    import GlibC
#else
    import Darwin
#endif




class SleepRoutine {
    
    var sleepSchedule: String?{
        didSet{
            
            setPickedSleepSchedule()
            
            
        }
    }

    var pickedSleepSchedule: [UInt32]?
    var ledLevel: Int = 0
    var sleepNoti: Bool = false
    var wakeUp: Bool = false
    var phase = 0
    let uberman: [UInt32] = [1200, 14400]
    let monophasic: [UInt32] = [28800, 57600]
    let biphasic: [UInt32] = [21600, 32400, 1800, 32400]
    let dymaxion: [UInt32] = [1800, 21600]
    let everyman: [UInt32] = [10800, 25200, 1200, 25200, 1200, 25200, 1200, 25200]
    let test: [UInt32] = [10, 10]
    
    func setPickedSleepSchedule(){
        guard let sleep = sleepSchedule else {return}
        
        switch sleep {
        case "uberman":
            pickedSleepSchedule = uberman
        case "dymaxion":
            pickedSleepSchedule = dymaxion
        case "everyman":
            pickedSleepSchedule = everyman
        case "monophasic":
            pickedSleepSchedule = monophasic
        case "biphasic":
            pickedSleepSchedule =  biphasic
            
        default:
            pickedSleepSchedule = test
        }
        updatesleep()
        updateled()
        
    }
    
    
    
    func updatesleep(){
        let timeInterval = pickedSleepSchedule![phase]
        Threading.dispatch {
            sleep(timeInterval)
            if self.phase % 2 == 0{
                self.sleepNoti = true
                self.wakeUp = false
            } else {
                self.sleepNoti = false
                self.wakeUp = true
            }
            self.updatesleep()
            self.phase = (self.phase + 1) % self.pickedSleepSchedule!.count
        }
    }
    
    func updateled() {
        let timeInterval = pickedSleepSchedule![phase]/9
        Threading.dispatch {
            sleep(timeInterval)
            self.ledLevel = (self.ledLevel + 1) % 10
            self.updateled()
        }
    }
    
    
   
}
