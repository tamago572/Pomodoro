//
//  TimerManagement.swift
//  Pomodoro
//
//  Created by dev on 2022/10/04.
//

import SwiftUI

class TimerManagement: ObservableObject {
    @Published var working:Bool = true
    @Published var breakTime:Int = 300
    @Published var workTime:Int = 1500
    @Published var count:Int = 1500
    
}
