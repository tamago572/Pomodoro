//
//  TimerManagement.swift
//  Pomodoro
//
//  Created by dev on 2022/10/04.
//

import SwiftUI

class TimerManagement: ObservableObject {
    @Published var working:Bool = true
    @Published var breakTime:Int = 3
    @Published var workTime:Int = 15
    @Published var count:Int = 0
    
    

}
