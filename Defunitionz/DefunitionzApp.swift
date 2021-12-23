//
//  DefunitionzApp.swift
//  Defunitionz
//
//  Created by Conqueriings on 22/12/21.
//
import SwiftUI

@main
struct DefunitonzApp: App {
    
    @ObservedObject var defsData = defData()

    @Environment(\.scenePhase) var scenePhase

    
    var body: some Scene {
        WindowGroup {
            ContentView(definitions: $defsData.definitions)
                .onAppear() {
                    defsData.load()
                }
                .onChange(of: scenePhase) { phase in
                    if phase == .inactive {
                        defsData.save()
                    }
                }
        }
    }
}

