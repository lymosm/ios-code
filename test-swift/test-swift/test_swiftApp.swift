//
//  test_swiftApp.swift
//  test-swift
//
//  Created by lymos on 2021/10/14.
//

import SwiftUI

@main
struct test_swiftApp: App {
    @Environment (\.scenePhase) private var scenePhase
    var body: some Scene {
        WindowGroup {
            ContentView()
            ContentView2()
        }.onChange(of: scenePhase){
            newScenePhase in switch newScenePhase{
            case .active:
                print("App active")
            case .inactive:
                print("App inactive")
            case .background:
                print("App background")
            @unknown default:
                print("App other")
            }
        }
    }
}
