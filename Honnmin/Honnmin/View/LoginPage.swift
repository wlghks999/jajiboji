//
//  LoginPage.swift
//  훈민정음
//
//  Created by 오현우 on 2022/08/14.
//

import SwiftUI

struct LoginPage: View {
    @StateObject var loginModel: LoginViewModel = LoginViewModel()
    @State var useFaceID: Bool = false
    @State private var show = false
    let persistenceController = PersistenceController.shared
    
    
    var body: some View {
        
        if UIDevice.current.userInterfaceIdiom == .pad{
            
            if show {
                ContentView(show: ContentView.Show(),input : ContentView.Input(), indexfr: ContentView.indexFR(), EA: ContentView.ErrorList(), valueCV: ContentView.Value())
                    .preferredColorScheme(.dark)
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                
                
            }
            else{
                
                
                
                ZStack{
                    
                    
                    Rectangle()
                        .scaledToFill()
                        .colorMultiply(Color("BackGround"))
                    
                    HStack{
                        VStack{
                            Circle()
                                .trim(from: 0, to: 0.5)
                                .fill (.white)
                                . frame (width: 45, height: 45)
                                . rotationEffect (.init (degrees: -90))
                                .hLeading()
                                .offset(x: -23)
                                .padding (.bottom,30)
                            
                            Text ("훈민정음에 로그인하기")
                                .font (.largeTitle.bold ())
                                .foregroundColor (.white)
                                .hLeading ()
                            
                            
                            TextField("이메일", text: $loginModel.email)
                                .padding ()
                                .background {
                                    RoundedRectangle (cornerRadius: 8)
                                        .fill(Color("TextField"))
                                    
                                }
                                .textInputAutocapitalization(.never)
                                .padding(.top,20)
                            
                            SecureField("비밀번호", text: $loginModel.password)
                                .padding ()
                                .background {
                                    RoundedRectangle (cornerRadius: 8)
                                        .fill(Color("TextField"))
                                    
                                }
                                .textInputAutocapitalization(.never)
                                .padding(.top,20)
                            
                            if loginModel.getBioMetricStatus(){
                                Group{
                                    if loginModel.useFaceID{
                                        
                                        Button {
                                            
                                            
                                            Task{
                                                do{
                                                    try await loginModel.authenticateUser()
                                                    
                                                    withAnimation {
                                                        show = true
                                                    }
                                                    
                                                    
                                                    
                                                } catch{
                                                    loginModel.errorMsg = error.localizedDescription
                                                    loginModel.showError.toggle()
                                                }
                                            }
                                            
                                            
                                            
                                        } label: {
                                            VStack(alignment: .leading, spacing: 10) {
                                                Label {
                                                    Text ("생체 인증을 사용하여 이전에 로그인했던 계정에 로그인")
                                                        .fontWeight(.ultraLight)
                                                        .foregroundColor(.white)
                                                    
                                                } icon: {
                                                    Image(systemName: "touchid")
                                                        .foregroundColor(.white)
                                                    
                                                }
                                            }
                                            .hLeading()
                                        }
                                        
                                    }
                                    else{
                                        
                                        Toggle(isOn: $useFaceID) {
                                            Text("생체인증을 사용하여 로그인하기")
                                                .fontWeight(.ultraLight)
                                                .foregroundColor(.white)
                                            
                                        }.foregroundColor(Color("SideBar"))
                                    }
                                }
                                .padding(.vertical, 20)
                            }
                            
                            
                            Button {
                                
                                Task{
                                    do{
                                        try await loginModel.loginUser(useFaceID: useFaceID)
                                        
                                        withAnimation {
                                            show = true
                                            
                                        }
                                        
                                        
                                    }
                                    catch{
                                        loginModel.errorMsg = "계정을 찾을 수 없습니다."
                                        loginModel.showError.toggle()
                                    }
                                }
                                
                                
                            }label: {
                                Text ("Login")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .padding()
                                    .hCenter()
                                    .background{
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(Color("SideBar"))
                                    }
                                
                            }
                            .padding (.vertical,35)
                            .disabled(loginModel.email == "" || loginModel.password == "")
                            .opacity(loginModel.email == "" || loginModel.password == "" ? 0.5 : 1)
                            
                            
                            Button{
                                
                                withAnimation {
                                    self.show = true
                                    
                                }
                                
                                
                                
                                
                            } label: {
                                
                                Text("오프라인에서 코딩하기")
                                    .fontWeight(.ultraLight)
                                    .foregroundColor(.white)
                            }
                            
                            
                            
                            
                        }
                        .padding (.horizontal,25)
                        .padding (.vertical)
                        .alert(loginModel.errorMsg, isPresented: $loginModel.showError) {
                            
                            Button("확인", role: .cancel){
                                
                            }
                            
                        }
                        
                        Divider()
                        
                        ZStack{
                            Rectangle()
                                .scaledToFit()
                                .colorMultiply(Color("TextField"))
                                .cornerRadius(10)
                                .padding()
                                .frame(height: UIScreen.main.bounds.height * 6/7)
                            
                            
                            Image("LoginAI")
                                .resizable()
                                .scaledToFit()
                            
                        }
                    }
                }
            }
            
        }
        
        if UIDevice.current.userInterfaceIdiom == .phone{
            ContentView(show: ContentView.Show(),input : ContentView.Input(), indexfr: ContentView.indexFR(), EA: ContentView.ErrorList(), valueCV: ContentView.Value())
                .preferredColorScheme(.dark)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .overlay(alignment: .top) {
                    GeometryReader { proxy in
                        let size = proxy.size
                        ContentView.NotificationView(size: size)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    }
                    .ignoresSafeArea()
                }
        }
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}


class Show : ObservableObject{
    @Published var error : Bool = false
    }

extension View{
    func hLeading ()->some View{
        self
            .frame (maxWidth: .infinity,alignment: .leading)
    }
    
    func hTrailing () ->some View{
        self
            .frame (maxWidth: .infinity, alignment: .trailing)
    }
    
    func hCenter () ->some View{
        self
            .frame (maxWidth: .infinity, alignment: .center)
    }
}
