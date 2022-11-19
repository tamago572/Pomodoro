import SwiftUI

@main
struct PomodoroApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(TimerSettings())
                .environmentObject(TimerStatus())
        }
    }
}


