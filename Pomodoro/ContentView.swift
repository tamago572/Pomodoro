//
//  ContentView.swift
//  Pomodoro
//
//  Created by dev on 2022/10/02.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var timerStatus: TimerManagement
    
    
    @State private var timer:Timer!
    @State private var cntbtnText = "開始"
    @State var canCount = false
    @State private var showingSettingsSheet = false
    
    @State private var timerMin = 0
    @State private var timerSec = 0
    @State var zeroFillmin = "25"
    @State var zeroFillsec = "00"
    
    func stopCount() {
        // カウント終了
        canCount = false
        cntbtnText = "開始"
        print("カウントを終了します")
        
        timer.invalidate()
    }
    
    
    func timer_sec_min_calc() {
        timerMin = Int(floor(Double(timerStatus.count / 60)))
        timerSec = timerStatus.count % 60
        
        zeroFillmin = String(format: "%02d", timerMin)
        zeroFillsec = String(format: "%02d", timerSec)
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("ポモドーロ")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    
                Spacer()
                
                Button {
                    showingSettingsSheet = true
                } label: {
                    Image(systemName: "gearshape")
                        .font(.largeTitle)
                }
                .fullScreenCover(isPresented: $showingSettingsSheet) {
                    SettingsView(isActive: $showingSettingsSheet)
                }

            }
            .padding()
            
            Spacer()
            
            Text("\(zeroFillmin):\(zeroFillsec)")
                .font(.largeTitle)
                .padding()
            
            Button {
                // カウントダウンしない場合
                if (canCount) {
                    // カウント終了
                    stopCount()
                
                // カウントダウンする場合
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
                            
                            // 休憩時間に入るか仕事時間に入るか
                            if (timerStatus.working) {
                                // 仕事中(timerStatus.working = true)ならタイマーを休憩時間にセット
                                timerStatus.count = timerStatus.breakTime
                                timerStatus.working = false
                                timer_sec_min_calc()
                                print("休憩時間に入ります")
                            } else {
                                // 休憩中(timerStatus.working = false)ならタイマーを仕事時間にセット
                                timerStatus.count = timerStatus.workTime
                                timerStatus.working = true
                                timer_sec_min_calc()
                                print("仕事時間に入ります")
                            }
                            
                        } else {
                            // タイマー1減らす
                            timerStatus.count -= 1
                            print(timerStatus.count)
                            timer_sec_min_calc()
                        }
                    })
                    
                }
            } label: {
                Text(cntbtnText)
                    .font(.title)
                    .foregroundColor(Color("AccentColor"))
            }

            Spacer()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(TimerManagement())
        SettingsView(isActive: Binding.constant(false))
            .environmentObject(AppSettings())
        
    }
}


// Settings View
struct SettingsView: View {
    @EnvironmentObject var appSettings: AppSettings
    @Binding var isActive: Bool
    var body: some View {
        VStack {
            
            HStack {
                Text("設定")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                Spacer()
                
                Button {
                    isActive = false
                } label: {
                    Text("閉じる")
                }
                .padding()

            }
            
            Divider()
            
            
                
            ScrollView {
                HStack {
                    Text("タイマーの設定")
                        .font(.title2)
                        .fontWeight(.bold)
                        
                    Spacer()
                }.padding([.top, .leading])
                
                VStack {
                    Toggle(isOn: $appSettings.playSoundOnDone) {
                        Text("カウント終了時にサウンドを鳴らす")
                    }
                }
                .padding()
            }
        }
    }
}
