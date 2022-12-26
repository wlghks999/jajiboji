//
//  LoginViewModel.swift
//  훈민정음
//
//  Created by 오현우 on 2022/08/14.
//

import SwiftUI
import Firebase
import LocalAuthentication

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    
    
    @AppStorage ("use_face_id") var useFaceID: Bool = false
    @AppStorage ("use_face_email") var useFaceIDEmail: String = ""
    @AppStorage ("use_face_password") var useFaceIDPassword: String = ""
    
    @AppStorage ("log_status") var logStatus: Bool = false
    
    
    @Published var showError: Bool = false
    @Published var errorMsg: String = ""
    
    func loginUser(useFaceID: Bool,email: String = "",password: String = "")async throws{
        
        let _ = try await Auth.auth().signIn(withEmail: email != "" ? email : self.email, password: password != "" ? password : self.password)
        
        DispatchQueue.main.async {
            // Stroing Once
            if useFaceID && self.useFaceIDEmail == ""{
                self.useFaceID = useFaceID
                // MARK: Storing for future face ID Login
                self.useFaceIDEmail = self.email
                self.useFaceIDPassword = self.password
                print("Stored")
            }
            
            self.logStatus = true
        }
        
    }
    
    func getBioMetricStatus()->Bool{
        
        let scanner = LAContext()
        
        return scanner.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: .none)
    }
    
    // MARK: FaceID Login
    func authenticateUser()async throws{
        
        let status = try await LAContext().evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "앱에 로그인하기 위해서 필요합니다.")
        
        if status{
            try await loginUser(useFaceID: useFaceID,email: self.useFaceIDEmail,password: self.useFaceIDPassword)
        }
    }
}
