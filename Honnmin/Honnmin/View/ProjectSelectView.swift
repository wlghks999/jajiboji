//
//  ProjectSelectView.swift
//  Honnmin
//
//  Created by 오현우 on 2022/10/11.
//

import SwiftUI

struct ProjectSelectView: View {
    var body: some View {
        
        ZStack{
            
            Rectangle()
                .scaledToFill()
                .colorMultiply(Color("BackGround"))
            
            ScrollView() {
                        VStack {
                            ForEach(1..<100) {_ in
                                Text("Item") //$표시 필수
                                    .font(.title)
                                
                               
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                    }
            
            
            
            
            
        }
        
    
        
        
        
    }
}

struct ProjectSelectView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectSelectView()
    }
}
