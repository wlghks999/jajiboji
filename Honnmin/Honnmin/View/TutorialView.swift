//
//  TutorialView.swift
//  Honnmin
//
//  Created by 오현우 on 2022/10/22.
//

import SwiftUI
import AVKit
import WebKit

struct TutorialView: View {
    @State var returnButton : Bool = false
    var body: some View {
        if returnButton == false{
            
            ZStack{
                Rectangle()
                    .ignoresSafeArea()
                    .colorMultiply(Color("BackGround"))
                
                VStack(alignment : .leading){
                    
                        
                    HStack{
                        
                        Spacer()
                        
                        Button {
                            withAnimation {
                                returnButton = true
                                
                            }
                            
                            
                            
                            
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .aspectRatio( contentMode: .fit)
                                .frame(width: 28)
                                .foregroundColor(.white)
                                .offset(x: 5, y: 1)
                        }
                    }
                    
                    
                    
                    
                    Spacer()
                    
                    
                    
                    Text("훈민정음 튜토리얼")
                        .font(.system(size: 40, weight: .bold))
                    
                    
                    
                    TutorialWebView()
                        .cornerRadius(10)
                    
                    
                    Spacer()
                    
                    
                }
                .padding()
            }
            .ignoresSafeArea()
            
        }else{
            ContentView(show: ContentView.Show(),input : ContentView.Input(), indexfr: ContentView.indexFR(), EA: ContentView.ErrorList(), valueCV: ContentView.Value())
                .preferredColorScheme(.dark)
                
        }
    }
}

struct TutorialWebView: UIViewRepresentable {
       
    
    var urlToEncode = "https://www.youtube.com/watch_popup?v=9mKd1NPZA_4"
    
    //ui view 만들기
    func makeUIView(context: Context) -> WKWebView {
        

        guard let urlToLoad = encodeURL(urlToEncode) else {
            return WKWebView()
        }
        

        let webView = WKWebView()
        

        webView.load(URLRequest(url: urlToLoad))
        return webView
    }
    

    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<TutorialWebView>) {
        
    }
}

func encodeURL(_ url: String) -> URL? {
        let encodedStr = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        return URL(string: encodedStr)!
    }


struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView()
    }
}
