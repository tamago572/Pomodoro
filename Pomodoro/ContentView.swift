//
//  ContentView.swift
//  Pomodoro
//
//  Created by dev on 2022/10/02.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var timerStatus: TimerManagement
    
    @State var timer:Timer!
    @State var canCount = false
    @State var cntbtnText = "開始"
    
    func stopCount() {
        // カウント終了
        canCount = false
        cntbtnText = "開始"
        print("カウントを終了します")
        
        timer.invalidate()
    }
    
    
    
    var body: some View {
        VStack {
            HStack {
                Text("ポモドーロ")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                Spacer()
            }
            
            
            Spacer()
//            Text("\(count)")
            Text("\(timerStatus.count)")
                .font(.largeTitle)
                .padding()
            
            Button {
                if (canCount) {
                    // カウント終了
                    stopCount()
                } else {
                    // カウント開始
                    canCount = true
                    cntbtnText = "停止"
                    print("カウントを開始します")
                    
                    // カウントダウン処理
                    timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: {_ in
                        
                        // タイマーが0以下のとき
                        if (timerStatus.count <= 1) {
                            // カウント終了処理
                            
                            stopCount()
                            
                            if (timerStatus.working) {
                                // 仕事中(timerStatus.working = true)ならタイマーを休憩時間にセット
                                timerStatus.count = timerStatus.breakTime
                                timerStatus.working = false
                                print("休憩時間に入ります")
                            } else {
                                // 休憩中(timerStatus.working = false)ならタイマーを仕事時間にセット
                                timerStatus.count = timerStatus.workTime
                                timerStatus.working = true
                                print("仕事時間に入ります")
                            }
                        } else {
                            // タイマー1減らす
                            timerStatus.count -= 1
                        }
                    })
                    
                }
            } label: {
                Text(cntbtnText)
                    .font(.title)
            }

            Spacer()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(TimerManagement())
    }
}
