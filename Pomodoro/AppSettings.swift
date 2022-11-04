import SwiftUI

// タイマーの設を定管理するクラス
class TimerSettings: ObservableObject {
    @Published var playSoundOnDone:Bool = true
    
    
}

//  タイマーを管理するクラスです。
class TimerStatus: ObservableObject {
    @Published var working:Bool = true
    @Published var breakTime:Int = 300
    @Published var workTime:Int = 1500
    @Published var count:Int = 1500
    @Published var scheduledTimerProgress:Int = 0
    
}
