//
//  HonnminApp.swift
//  Honnmin
//
//  Created by 오현우 on 2022/08/16.
//

import SwiftUI
import Firebase

@main
struct HonnminApp: App {
    
    
    let persistenceController = PersistenceController.shared
    init(){
        FirebaseApp.configure()
    }

    var body: some Scene {
        
        WindowGroup {
            SplashView()
                .preferredColorScheme(.dark)
                .statusBarHidden()
                .ignoresSafeArea(.keyboard)
                .ignoresSafeArea()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                
                
                
                
        }
    }
    
    
    
}


