//
//  SplashView.swift
//  훈민정음
//
//  Created by 오현우 on 2022/08/07.
//


import SwiftUI
import Lottie
import UIKit

struct SplashView: View {
    
    @State var isActive:Bool = false
    @AppStorage ("log_status") var logStatus: Bool = false
    let persistenceController = PersistenceController.shared

    
    var body : some View{
        
        
        
        VStack{
            
            if self.isActive {
                
                ContentView(show: ContentView.Show(),input : ContentView.Input(), indexfr: ContentView.indexFR(), EA: ContentView.ErrorList(), valueCV: ContentView.Value())
                    .preferredColorScheme(.dark)
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)

                
                
            } else {
                // 4.
                AnimatedView()
                    .ignoresSafeArea()
                    .scaledToFill()
            }
            
            
        }
        .ignoresSafeArea()
        .onAppear {
            // 6.
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                // 7.
                withAnimation {
                    self.isActive = true
                }
            }
        }
        
    }
    
    
}


struct AnimatedView: UIViewRepresentable {
    func makeUIView(context: Context) -> LottieAnimationView {
        
        let view = LottieAnimationView(name: "Splash2", bundle: Bundle.main)
        view.play()
        
        
        return view
    }
    
    func updateUIView(_ uiView: LottieAnimationView, context: Context) {
        
    }
}
