import SwiftUI

@main
struct PomodoroApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(TimerManagement())
                .environmentObject(AppSettings())
        }
    }
}


