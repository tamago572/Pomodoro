//
//  TimerProcess.swift
//  Pomodoro
//
//  Created by dev on 2022/10/29.
//

import Foundation
import SwiftUI

class TimerProcess {
    @EnvironmentObject var timerStatus: TimerStatus
    var timerMin = 0
    var timerSec = 0
    var zeroFillmin = "25"
    var zeroFillsec = "00"
    
    func timer_sec_min_calc() {
        timerMin = Int(floor(Double(timerStatus.count / 60)))
        timerSec = timerStatus.count % 60
        
        zeroFillmin = String(format: "%02d", timerMin)
        zeroFillsec = String(format: "%02d", timerSec)
    }
}
