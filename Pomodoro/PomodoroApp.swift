import SwiftUI

@main
struct MyProject1App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate  // この行を追加する
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

// 追加
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // 起動時に1回だけやる処理をここに記述する
        print("こんにちは")
        return true
    }
}
