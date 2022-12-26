//
//  ContentView.swift
//  0805
//
//  Created by 오현우 on 2022/08/05.
//
import SwiftUI
import Foundation
import UIKit
import HighlightedTextEditor
import Firebase
import CoreData
import UIKit
import Combine



let betweenUnderscores = try! NSRegularExpression(pattern: "출력한다", options: []) //try는 왜 하는가, NSRegular... 은 뭐하는 건가, options가 비어있는건 옵션이 없는 건가 -> 이건 몰라, 저게 색 칠해주는 라이브러리 그대로
let betweenUnderscores2 = try! NSRegularExpression(pattern: "더하기", options: [])
let betweenUnderscores3 = try! NSRegularExpression(pattern: "곱하기", options: [])
let betweenUnderscores4 = try! NSRegularExpression(pattern: "나누기", options: [])
let betweenUnderscores5 = try! NSRegularExpression(pattern: "빼기", options: [])
let betweenUnderscores19 = try! NSRegularExpression(pattern: "나머지", options: [])
let betweenUnderscores20 = try! NSRegularExpression(pattern: "일 동안", options: [])

let betweenUnderscores6 = try! NSRegularExpression(pattern: "(은|는)", options: [])
let betweenUnderscores7 = try! NSRegularExpression(pattern: "이다", options: [])
let betweenUnderscores8 = try! NSRegularExpression(pattern: "(단|자)", options: [])

let betweenUnderscores9 = try! NSRegularExpression(pattern: "(\\줄)", options: [])
let betweenUnderscores10 = try! NSRegularExpression(pattern: "-", options: [])
let betweenUnderscores11 = try! NSRegularExpression(pattern: "바꾼다", options: [])
let betweenUnderscores12 = try! NSRegularExpression(pattern: "(로|으로)", options: [])
let betweenUnderscores13 = try! NSRegularExpression(pattern: "(을|를)", options: [])

let betweenUnderscores14 = try! NSRegularExpression(pattern: "(과|와)", options: [])

let betweenUnderscores15 = try! NSRegularExpression(pattern: "미분", options: [])

let betweenUnderscores16 = try! NSRegularExpression(pattern: "입력받는다", options: [])

let betweenUnderscores17 = try! NSRegularExpression(pattern: "만약", options: [])

let betweenUnderscores18 = try! NSRegularExpression(pattern: "->", options: [])








struct ContentView: View {
    @State var textSave = UserDefaults.standard.string(forKey: "maintext") //forkey는 무엇인가 -> 훈민정음에 저장 기능이 있는데, 텍스트 저장해 놓는 공간 이름을 forkey라고 하는거 같음
    @State var text = ""
    @State var result = ""
    @State var result1 = ""
    @State var result2 = ""
    @State var result3 = ""
    @State var result4 = ""
    @State var results = ""
    @State var resultF = ""
    @State var vari = ""
    @State var varir = ""
    @State var full = 0
    @State var i = 0
    @State var showTutorial : Bool = false
    @State var showError : Bool = false
    @FocusState var isInputActive: Bool //focusstate가 무엇인가 -> 아이폰 UI 때문에 들어간건데 키보드가 입력상태인지 아닌지 확인하는 변수
    
    @State private var showing : Bool = false
    @State private var error : Bool = false
    @State private var loginshow : Bool = false
    
    
    @State var reset : Bool = false
    @State var declare : Bool = false
    
    
    @AppStorage ("log_status") var logStatus: Bool = false //앱 저장소의 "log_status"라는 저장소에 logStatus라는 변수를 저장하는 것이 맞나 -> ㅇㅇ 맞을거임
    @AppStorage("use_face_email") var faceIDEmail: String = "" //faceID를 도입할 것인가 -> 이미 도입 됨. 이게 터치아이디/faceID 구분 있는게 아니라 생체인증으로 통합되어있어서 faceID 있는 기기에서는 로그인 할때 faceID 작동함
    @AppStorage("use_face_password") var faceIDPassword: String = ""
    
    @ObservedObject var show : Show
    @ObservedObject var input : Input
    @ObservedObject var indexfr : indexFR
    @ObservedObject var EA : ErrorList
    @ObservedObject var valueCV : Value
    
    
    
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: Dfunc.entity(), sortDescriptors: [])
    var FD : FetchedResults<Dfunc> //함수 불러오는 코드인가 -> 그렇다고 보면 편할거 같은데, 이건
    
    
    
    
    
    
    
    
    
    
    private let rules: [HighlightRule] = [
        HighlightRule(pattern: betweenUnderscores, formattingRules: [
            TextFormattingRule(fontTraits: [.traitBold]),
            TextFormattingRule(key: .foregroundColor, value: UIColor.orange),
            
        ]),
        
        HighlightRule(pattern: betweenUnderscores2, formattingRules: [
            TextFormattingRule(fontTraits: [.traitItalic, .traitBold]),
            TextFormattingRule(key: .foregroundColor, value: UIColor.systemPurple),
            
        ]),
        
        HighlightRule(pattern: betweenUnderscores3, formattingRules: [
            TextFormattingRule(fontTraits: [.traitItalic, .traitBold]),
            TextFormattingRule(key: .foregroundColor, value: UIColor.systemPurple),
            
        ]),
        
        HighlightRule(pattern: betweenUnderscores4, formattingRules: [
            TextFormattingRule(fontTraits: [.traitItalic, .traitBold]),
            TextFormattingRule(key: .foregroundColor, value: UIColor.systemPurple),
            
        ]),
        
        
        HighlightRule(pattern: betweenUnderscores5, formattingRules: [
            TextFormattingRule(fontTraits: [.traitItalic, .traitBold]),
            TextFormattingRule(key: .foregroundColor, value: UIColor.systemPurple),
            
        ]),
        
        HighlightRule(pattern: betweenUnderscores6, formattingRules: [
            TextFormattingRule(fontTraits: [.traitItalic, .traitBold]),
            TextFormattingRule(key: .foregroundColor, value: UIColor.systemCyan),
            
        ]),
        
        HighlightRule(pattern: betweenUnderscores7, formattingRules: [
            TextFormattingRule(fontTraits: [.traitItalic, .traitBold]),
            TextFormattingRule(key: .foregroundColor, value: UIColor.systemCyan),
            
        ]),
        
        HighlightRule(pattern: betweenUnderscores8, formattingRules: [
            TextFormattingRule(fontTraits: [.traitItalic, .traitBold]),
            TextFormattingRule(key: .foregroundColor, value: UIColor(Color("단"))),
            
        ]),
        HighlightRule(pattern: betweenUnderscores9, formattingRules: [
            TextFormattingRule(fontTraits: [.traitItalic, .traitBold]),
            TextFormattingRule(key: .foregroundColor, value: UIColor.green),
            
        ]),
        HighlightRule(pattern: betweenUnderscores10, formattingRules: [
            TextFormattingRule(fontTraits: [.traitItalic, .traitBold]),
            TextFormattingRule(key: .foregroundColor, value: UIColor(Color("단"))),
            
        ]),
        
        HighlightRule(pattern: betweenUnderscores11, formattingRules: [
            TextFormattingRule(fontTraits: [.traitItalic, .traitBold]),
            TextFormattingRule(key: .foregroundColor, value: UIColor(Color("바꾸자"))),
            
        ]),
        
        HighlightRule(pattern: betweenUnderscores12, formattingRules: [
            TextFormattingRule(fontTraits: [.traitItalic, .traitBold]),
            TextFormattingRule(key: .foregroundColor, value: UIColor(Color("바꾸자"))),
            
        ]),
        HighlightRule(pattern: betweenUnderscores13, formattingRules: [
            TextFormattingRule(fontTraits: [.traitItalic, .traitBold]),
            TextFormattingRule(key: .foregroundColor, value: UIColor(Color("바꾸자"))),
            
        ]),
        
        HighlightRule(pattern: betweenUnderscores14, formattingRules: [
            TextFormattingRule(fontTraits: [.traitItalic, .traitBold]),
            TextFormattingRule(key: .foregroundColor, value: UIColor(Color("와과"))),
            
        ]),
        
        HighlightRule(pattern: betweenUnderscores15, formattingRules: [
            TextFormattingRule(fontTraits: [.traitItalic, .traitBold]),
            TextFormattingRule(key: .foregroundColor, value: UIColor(Color("미분"))),
            
        ]),
        HighlightRule(pattern: betweenUnderscores16, formattingRules: [
            TextFormattingRule(fontTraits: [.traitItalic, .traitBold]),
            TextFormattingRule(key: .foregroundColor, value: UIColor.systemCyan),
            
        ]),
        HighlightRule(pattern: betweenUnderscores17, formattingRules: [
            TextFormattingRule(fontTraits: [.traitItalic, .traitBold]),
            TextFormattingRule(key: .foregroundColor, value: UIColor(Color("단"))),
            
        ]),
        
        HighlightRule(pattern: betweenUnderscores18, formattingRules: [
            TextFormattingRule(fontTraits: [.traitItalic, .traitBold]),
            TextFormattingRule(key: .foregroundColor, value: UIColor.orange),
            
        ]),
        HighlightRule(pattern: betweenUnderscores19, formattingRules: [
            TextFormattingRule(fontTraits: [.traitItalic, .traitBold]),
            TextFormattingRule(key: .foregroundColor, value: UIColor.systemPurple),
            
        ]),
        HighlightRule(pattern: betweenUnderscores20, formattingRules: [
            TextFormattingRule(fontTraits: [.traitItalic, .traitBold]),
            TextFormattingRule(key: .foregroundColor, value: UIColor(Color("바꾸자"))),
            
        ])
        
        
        
        
        
        
        
        
        
        
    ]
    
    
    
    
    
    var body: some View { //some 은 뭔가
        
        
        if UIDevice.current.userInterfaceIdiom == .pad{
            
            
            if loginshow{
                LoginPage()
            }else if showTutorial{
                TutorialView()
            }
            
            else{
                
                
                
                
                
                ZStack{
                    
                    HStack{
                        GeometryReader { proxy in
                            
                            
                            
                            HStack{
                                
                                ZStack{
                                    Rectangle()
                                        .path(in: CGRect(x: 0, y: 0, width: proxy.size.width / 6, height: proxy.size.height))
                                        .fill(Color("SideBar"))
                                    
                                    VStack{
                                        
                                        
                                        
                                        Image("Top")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .padding()
                                        
                                        Group{
                                            
                                            
                                            Button {
                                                
                                                self.EA.errorArray.removeAll()
                                                self.valueCV.errorcatchforVar = 0
                                                self.valueCV.errorcatchforConst = 0
                                                self.valueCV.const.removeAll()
                                                self.valueCV.constR.removeAll()
                                                self.valueCV.varI.removeAll()
                                                self.valueCV.varIR.removeAll()
                                                
                                                
                                                
                                                
                                                indexfr.indexF = FD.map { $0.name ?? "" } //이건 뭐하는 거임 -> 이것도 마찬가지로 나중에
                                                indexfr.indexFC = FD.map { $0.fc ?? "" }
                                                
                                                
                                                
                                                if text.contains("입력받는다."){
                                                    
                                                    
                                                    
                                                    input.input = true
                                                    Userinput(text: text) //이걸 여러번 하면 입력 여러 개 되는 거 아님? -> 결정적인 이유는 사실 벡엔드가 아니라 UI가 이상해서 포기한게 큼
                                                    
                                                    
                                                    
                                                    
                                                    
                                                }
                                                else{
                                                    if text == ""{
                                                        self.EA.errorArray.append("유효한 코드를 입력하지 않았습니다.") //어떠한 코드도 입력하지 않음 ->
                                                        show.error = true
                                                    }else{
                                                        if !(text.contains(".")){
                                                            resultF = ""
                                                            self.EA.errorArray.append("유효한 코드를 입력하지 않았습니다.") //줄마침 기호를 쓰지 않음
                                                            show.error = true
                                                        }
                                                        
                                                        
                                                        if !(text.contains("출력한다")) && !(text.contains("이다")) && !(text.contains("바꾼다")) && !(text.contains("실행한다")){
                                                            resultF = ""
                                                            self.EA.errorArray.append("유효한 코드를 입력하지 않았습니다.") //어떠한 동작하는 코드도 입력하지 않음
                                                            show.error = true
                                                        }
                                                        
                                                        if show.error==false{
                                                            resultF = finishpoint(text: text).joined(separator: "") // 에러가 없다면 finishpoint를 실행하고
                                                                                                                    // 그 반환값을 resultF에 넣음
                                                        }
                                                    }
                                                }
                                            } label: {
                                                
                                                HStack{
                                                    Image(systemName: "terminal")
                                                        .foregroundColor(.white)
                                                    
                                                    
                                                    Text("컴파일")
                                                        .foregroundColor(.white)
                                                        .font(.system(size: 20, weight: .ultraLight))
                                                    
                                                    Spacer()
                                                }
                                                .padding()
                                            }
                                            .sheet(isPresented: $show.error ){
                                                
                                                errorView()
                                                    .onAppear(){
                                                        resultF = "" //에러를 표시하는 거임?
                                                    }
                                                
                                                
                                                
                                            }
                                            .alert("값을 입력하세요", isPresented: $input.input){
                                                TextField(input.inputArray, text: $result2)
                                                    .foregroundColor(Color("Text"))
                                                Button("확인", role : .cancel) {
                                                    self.input.inputResult = result2
                                                    
                                                    indexfr.indexF = FD.map { $0.name ?? "" }
                                                    indexfr.indexFC = FD.map { $0.fc ?? "" }
                                                    
                                                    resultF = finishpoint(text: ".")[0]
                                                    
                                                    i = 0
                                                    
                                                    
                                                    
                                                    
                                                    
                                                    full = finishpoint(text: text).count
                                                    if full == 0 {
                                                        
                                                        if finishpoint(text: text) == [] {
                                                            
                                                            error = true //finishpoint에 저장된 값이 없으면 에러임? 변수 저장만 해도 에러임? -> 아닐걸? 왠지는 모름
    //********************************************여기까지 함********************************************
                                                            
                                                        }else{
                                                            
                                                            if show.error {
                                                                
                                                                resultF = ""
                                                                
                                                            }else{
                                                                resultF = finishpoint(text: text)[0] //왜 첫번째 단어만 resultF에 들어가나
                                                            }
                                                        }
                                                        
                                                    }
                                                    
                                                    if show.error{
                                                        
                                                        resultF = ""
                                                        
                                                    }else{
                                                        while i != full{
                                                            resultF = resultF + finishpoint(text: text)[i]//왜 첫번째 단어를 두 번 넣는 거임?
                                                            i += 1
                                                            
                                                        }
                                                    }
                                                    
                                                }
                                                
                                            }
                                            
                                            Button{ //함수 선언 버튼
                                                
                                                declare = true
                                                
                                            } label : {
                                                
                                                HStack{
                                                    Image(systemName: "function") //systemName은 뭐임?
                                                        .foregroundColor(.white)
                                                    
                                                    Text("함수 선언")
                                                        .foregroundColor(.white)
                                                        .font(.system(size: 20, weight: .ultraLight))
                                                    
                                                    Spacer()
                                                }
                                                .padding()
                                                
                                            }.sheet(isPresented: $declare){
                                                
                                                FuncDeclare()
                                                
                                            }
                                            
                                            Button { // 초기화 버튼
                                                
                                                result = ""
                                                result1 = "" //1?
                                                resultF = finishpoint(text: ".")[0] //어차피 입력이 . 하나인데 굳이 첫 번째 단어만 resultF에 넣는 이유가 뭐임?
                                      
                                                i = 0
                                                
                                                text = ""
                                                
                                                
                                            } label: {
                                                HStack{
                                                    Image(systemName: "eraser.fill")
                                                        .foregroundColor(.white)
            
                                                    Text("초기화")
                                                        .foregroundColor(.white)
                                                        .font(.system(size: 20, weight: .ultraLight))
                                                    
                                                    Spacer()
                                                }
                                                .padding()
                                            }
                                            
                                            Button { // 저장 버튼
                                                
                                                textSave = text
                                                UserDefaults.standard.set(text, forKey: "maintext") //이건 뭐하는 거임
                                                
                                            } label: {
                                                HStack{
                                                    Image(systemName: "pencil.and.outline")
                                                        .foregroundColor(.white)
                                                    
                                                    
                                                    Text("저장")
                                                        .foregroundColor(.white)
                                                        .font(.system(size: 20, weight: .ultraLight))
                                                    
                                                    Spacer()
                                                }
                                                .padding()
                                            }//저장하는 기능은 어딨음?
                                            
                                            Button { //종료 버튼
                                                
                                                showing = true
                                                
                                            } label: {
                                                HStack{
                                                    Image(systemName: "power")
                                                        .foregroundColor(.white)
                                                    
                                                    
                                                    Text("종료")
                                                        .foregroundColor(.white)
                                                        .font(.system(size: 20, weight: .ultraLight))
                                                    
                                                    Spacer()
                                                }
                                                .padding()
                                            }.alert("정말로 종료하시겠습니까?", isPresented: $showing) {
                                                Button("종료", role: .destructive) {
                                                    
                                                    exit(-1)
                                                }
                                                Button("취소", role: .cancel) {}
                                            }
                                            
                                        }
                                        
                                        
                                        
                                        Divider()
                                            .padding()
                                        
                                        if logStatus{
                                            
                                            Button { //로그아웃버튼
                                                try? Auth.auth().signOut()
                                                logStatus = false //signOut()이 안 되면 false로 하면 안 되는 것 아닌가
                                                
                                                withAnimation {
                                                    loginshow = true
                                                    
                                                }
                                            } label: {
                                                HStack{
                                                    Image(systemName: "rectangle.portrait.and.arrow.forward")
                                                        .foregroundColor(.white)
                                                    
                                                    
                                                    Text("로그아웃")
                                                        .foregroundColor(.white)
                                                        .font(.system(size: 20, weight: .ultraLight))
                                                    
                                                    Spacer()
                                                }
                                                .padding()
                                            }
                                            
                                            
                                            Button {//튜토리얼 버튼
                                                
                                                withAnimation {
                                                    showTutorial = true
                                                }
                                                
                                                
                                            } label: {
                                                HStack{
                                                    Image(systemName: "testtube.2")
                                                        .foregroundColor(.white)
                                                    
                                                    
                                                    Text("튜토리얼")
                                                        .foregroundColor(.white)
                                                        .font(.system(size: 20, weight: .ultraLight))
                                                    
                                                    Spacer()
                                                }
                                                .padding()
                                            }
                                            
                                            
                                            
                                            
                                        }
                                        else{ //로그인이 안 되어 있다면 로그인 하기
                                            
                                            Button { //로그인 버튼
                                                
                                                
                                                withAnimation {
                                                    loginshow = true
                                                    
                                                }
                                            } label: {
                                                HStack{
                                                    Image(systemName: "person.text.rectangle.fill")
                                                        .foregroundColor(.white)
                                                    
                                                    
                                                    Text("로그인하기")
                                                        .foregroundColor(.white)
                                                        .font(.system(size: 20, weight: .ultraLight))
                                                    
                                                    Spacer()
                                                }
                                                .padding()
                                            }
                                            
                                            
                                            
                                            Button {//튜토리얼 버튼. 그냥 로그인하기, 로그아웃하기 버튼만 if else로 묶고 튜토리얼을 한 번만 쓰면 되는 거 아님?
                                                
                                                withAnimation {
                                                    showTutorial = true
                                                }
                                                
                                            } label: {
                                                HStack{
                                                    Image(systemName: "testtube.2")
                                                        .foregroundColor(.white)
                                                    
                                                    
                                                    Text("튜토리얼")
                                                        .foregroundColor(.white)
                                                        .font(.system(size: 20, weight: .ultraLight))
                                                    
                                                    Spacer()
                                                }
                                                .padding()
                                            }
                                            
                                            
                                            
                                            
                                            
                                            
                                        }
                                        
                                        
                                        Spacer()
                                        Spacer() //이건 뭐임?
                                    }
                                    
                                }
                                
                                ZStack{
                                    
                                    Rectangle()
                                        .frame(width: proxy.size.width * 5/6, height: proxy.size.height)
                                        .colorMultiply(Color("BackGround"))
                                    
                                    
                                    
                                    
                                    
                                    
                                    HStack{
                                        
                                        VStack{
                                            
                                            HStack{
                                                
                                                Text("코드 입력")
                                                    .font(.system(size: 30, weight: .bold))
                                                    .padding()
                                                
                                                Spacer()
                                            }
                                            
                                            
                                            HighlightedTextEditor(text: $text, highlightRules: rules)
                                                .onCommit { print("commited") }
                                                .onEditingChanged { print("editing changed") }
                                                .onTextChange { print("latest text value", $0) }
                                                .onSelectionChange { (range: NSRange) in
                                                    print(range)
                                                    
                                                }
                                                .introspect { editor in
                                                    // access underlying UITextView or NSTextView
                                                    editor.textView
                                                        .backgroundColor = UIColor(Color("TextField"))
                                                    
                                                    
                                                    
                                                }
                                            
                                                .cornerRadius(10)
                                                .frame(width: UIScreen.main.bounds.width * 2/5, height: UIScreen.main.bounds.height * 6/7)
                                                .ignoresSafeArea(.keyboard)
                                                
                                            
                                            Spacer()
                                            
                                            
                                        }
                                        
                                        
                                        Spacer()
                                        
                                        
                                        
                                        VStack{
                                            
                                            HStack{
                                                
                                                Text("실행 결과")
                                                    .font(.system(size: 30, weight: .bold))
                                                    .padding()
                                                
                                                Spacer()
                                            }
                                            
                                            HighlightedTextEditor(text: $resultF, highlightRules: rules)
                                                .onCommit { print("commited") }
                                                .onEditingChanged { print("editing changed") }
                                                .onTextChange { print("latest text value", $0) }
                                                .onSelectionChange { (range: NSRange) in
                                                    print(range)
                                                    
                                                }
                                                .introspect { editor in
                                                    
                                                    editor.textView
                                                        .backgroundColor = UIColor(Color("TextField"))
                                                }
                                            
                                                .cornerRadius(10)
                                                .foregroundColor(.white)
                                                .frame(width: UIScreen.main.bounds.width * 2/5, height: UIScreen.main.bounds.height * 6/7)
                                                .ignoresSafeArea(.keyboard)
                                            
                                            Spacer()
                                            
                                        }
                                        
                                    }
                                    .padding()
                                    
                                    
                                    
                                }
                                
                                
                                
                            }
                            
                            
                            
                        }
                        
                        
                    }
                    
                    
                    HStack{
                        
                        Spacer(minLength: 10)
                        
                        
                        
                        
                        Spacer(minLength: 5)
                        
                        
                    }
                    
                    
                    
                }
                .ignoresSafeArea(.keyboard)
                .ignoresSafeArea()
                .onAppear(){
                    text = textSave ?? ""
                }
                
            }
            
            
        }
            
        
        if UIDevice.current.userInterfaceIdiom == .phone{ //아이폰 UI(자세히 보지는 않음)
            
            
            
            ZStack{
                Rectangle()
                    .foregroundColor(Color("BackGround"))
                    .ignoresSafeArea()
                    .onTapGesture {
                        self.endTextEditing()
                    }
                
                
                
                
                
                Rectangle()
                    .foregroundColor(Color("SideBar"))
                    .ignoresSafeArea()
                    .frame(height: 150)
                    .cornerRadius(30)
                    .offset(y : 390)
                
                VStack{
                    
                    HighlightedTextEditor(text: $text, highlightRules: rules)
                        .onCommit { print("commited") }
                        .onEditingChanged { print("editing changed") }
                        .onTextChange { print("latest text value", $0) }
                        .onSelectionChange { (range: NSRange) in
                            print(range)
                            
                        }
                        .introspect { editor in
                            // access underlying UITextView or NSTextView
                            editor.textView
                                .backgroundColor = UIColor(Color("TextField"))
                            
                            
                            
                        }
                    
                        .cornerRadius(20)
                        .frame(width: 370, height: 640)
                        .ignoresSafeArea(.keyboard)
                        .padding()
                        .offset(y: 35)
                        
                    
                    
                    
                    HStack{
                        
                        Button {
                            result = ""
                            result1 = ""
                            resultF = finishpoint(text: ".")[0]
                  
                            i = 0
                            
                            text = ""
                            
                            
                        } label: {
                            ZStack{
                                
                                Circle()
                                    .fill(Color("CompileButton"))
                                    .frame(width: 40, height : 40)
                                    .shadow(color: .black.opacity(0.6), radius: 8, x: 5, y: 10)
                                    
                                
                                Image(systemName: "eraser.fill")
                                
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 20)
                                    
                                
                            }
                            
                        }
                        .foregroundColor(.black)
                        .offset(y : 340)
                        
                        Spacer()
                        Button {
                            declare = true
                            
                            
                        } label: {
                            ZStack{
                                
                                Circle()
                                    .fill(Color("CompileButton"))
                                    .frame(width: 40, height : 40)
                                    .shadow(color: .black.opacity(0.6), radius: 8, x: 5, y: 10)
                                    
                                
                                Image(systemName: "function")
                                
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 20)
                                
                            }
                            
                        }
                        .foregroundColor(.black)
                        .offset(y : 340)
                        .sheet(isPresented: $declare){
                            
                            FuncDeclare()
                            
                        }
                        
                        Spacer()
                        
                        Button {
                            
                            self.EA.errorArray.removeAll()
                            self.valueCV.errorcatchforVar = 0
                            self.valueCV.errorcatchforConst = 0
                            self.valueCV.const.removeAll()
                            self.valueCV.constR.removeAll()
                            self.valueCV.varI.removeAll()
                            self.valueCV.varIR.removeAll()
                            
                            
                            
                            
                            indexfr.indexF = FD.map { $0.name ?? "" }
                            indexfr.indexFC = FD.map { $0.fc ?? "" }
                            
                            
                            
                            if text.contains("입력받는다."){
                                
                                
                                
                                input.input = true
                                Userinput(text: text)
                                
                                
                                
                                
                                
                            }
                            else{
                                if text == ""{
                                    self.EA.errorArray.append("유효한 코드를 입력하지 않았습니다.")
                                    show.error = true
                                }else{
                                    if !(text.contains(".")){
                                        resultF = ""
                                        self.EA.errorArray.append("유효한 코드를 입력하지 않았습니다.")
                                        show.error = true
                                    }
                                    
                                    
                                    if !(text.contains("출력한다")) && !(text.contains("이다")) && !(text.contains("바꾼다")) && !(text.contains("실행한다")){
                                        resultF = ""
                                        self.EA.errorArray.append("유효한 코드를 입력하지 않았습니다.")
                                        show.error = true
                                    }
                                    
                                    if show.error == true{
                                        resultF = ""
                                    }
                                    else{
                                        
                                        resultF = finishpoint(text: text).joined(separator: "")
                                    }
                                }
                                
                                
                                
                                
                                
                                
                            }
                            
                            
                            NotificationCenter.default.post(name: .init("NOTIFY"), object: NotificationModel(title: "실행 결과", content: resultF))
                            
                            
                            
                            
                            
                        } label: {
                            ZStack{
                                
                                Circle()
                                    .fill(Color("CompileButton"))
                                    .frame(width: 65, height : 65)
                                    .shadow(color: .black.opacity(0.6), radius: 8, x: 5, y: 10)
                                
                                Image(systemName: "terminal")
                                
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 35, height: 35)
                                
                            }
                            
                        }
                        .foregroundColor(.black)
                        .offset(y : 330)

                        
                        Spacer()
                        
                        Button {
                            textSave = text
                            UserDefaults.standard.set(text, forKey: "maintext")
                            
                        } label: {
                            ZStack{
                                
                                Circle()
                                    .fill(Color("CompileButton"))
                                    .frame(width: 40, height : 40)
                                    .shadow(color: .black.opacity(0.6), radius: 8, x: 5, y: 10)
                                
                                Image(systemName: "pencil.and.outline")
                                
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 20)
                                
                            }
                            
                        }
                        .foregroundColor(.black)
                        .offset(y : 340)

                        
                        Spacer()
                        
                        Button {
                            showing = true
                            
                        } label: {
                            ZStack{
                                
                                Circle()
                                    .fill(Color("CompileButton"))
                                    .frame(width: 40, height : 40)
                                    .shadow(color: .black.opacity(0.6), radius: 8, x: 5, y: 10)
                                
                                Image(systemName: "power")
                                
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 20)
                                
                            }
                            
                        }
                        .foregroundColor(.black)
                        .offset(y : 340)
                        .alert("정말로 종료하시겠습니까?", isPresented: $showing) {
                            Button("종료", role: .destructive) {
                                
                                exit(-1)
                            }
                            Button("취소", role: .cancel) {}
                        }

                        
                        
                        Spacer()
                        
                        
                    }
                    .padding()
                    .offset(x : 8, y : -320)
                }

                    
            }
            .onAppear(){
                text = textSave ?? ""
            }
        }
        
        
        
    }
        
    struct NotificationModel {
        var title: String
        var content: String
    }
    
    
    struct NotificationView: View {
        var size: CGSize //CGSize가 뭐임
        @State var isExpanded: Bool = false //@State는 뭐임?
        @State var notification: NotificationModel? //뭘 물어보는 거야
        var body: some View {
            HStack{
                VStack(alignment: .leading) {
                    Text("실행 결과")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.title)
                    
                    Spacer()
                    
                    
                    
                    Text(notification?.content ?? "") //물음표 왜 찍는 거임
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                
                Spacer()
            }
            .padding()

            .frame(width: isExpanded ? size.width - 22 : 126, height: isExpanded ? 250 : 37.33)
            .blur(radius: isExpanded ? 0 : 30)
            .opacity(isExpanded ? 1 : 0)
            .scaleEffect(isExpanded ? 1 : 0.5, anchor: .top)
            .background {
                RoundedRectangle(cornerRadius: isExpanded ? 50 : 63, style: .continuous)
                    .fill(.black)
            }
            .clipped()
            .offset(y: 11)
            .onReceive(NotificationCenter.default.publisher(for: .init("NOTIFY"))) { output in
                guard let notification = output.object as? NotificationModel else { return }
                self.notification = notification
                withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.7, blendDuration: 0.7)) {
                    isExpanded = true

                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
                        withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.7, blendDuration: 0.7)) {
                            isExpanded = false
                            self.notification = nil
                        }
                    }
                }
            }
        }
    }
    
    
    
    struct GrowingButton: ButtonStyle {//이건 뭐임
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .padding()
                .background(.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
                .scaleEffect(configuration.isPressed ? 1.2 : 1)
                .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
        }
    }

    
    
    @ViewBuilder //이건 뭐임
    func errorView() -> some View{ //some View가 뭐하는 거임 some View를 반환하는 거임? 근데 some View가 뭐임
        VStack{
            
            HStack{
                Text("에러 리스트")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding()
                    .offset(y : 10)
                
                Spacer()
            }
            
            ScrollView {
                
            
            ForEach(self.EA.errorArray, id: \.self) {index in //이렇게 줄바꿈 해도 됨? 그리고 \.self는 뭐임? 그리고 self.EA.errorArray에 있는 건 뭔가 모양이 있는 개체인 거임? 그래서 위치만 잡아주는 거임?
                ZStack{
                    Rectangle()
                        .frame(maxWidth: .infinity)
                        .frame(height: 90)
                        .foregroundColor(.red)
                        .cornerRadius(10)
                        .opacity(0.4)
                        .padding()
                    
                    
                    
                    Text(index)
                        .foregroundColor(.white)
                        .hLeading() //이건 뭐야
                        .offset(x : 25)
                    
                }
            }
        }
        }
    }
  
    
    
 
    
   
    func plus(text: String, line : Int) -> String { //더하기 함수
        var s = 0
        var t = 0
        var q = 0
        var textreturn = ""
        var replace = ""
        var P1 = 0
        var P2 = 0
        var textindexs : String.Index = text.startIndex //이건 뭔 뜻임 특히 s t p q 는 뭐임
        var textindext : String.Index = text.startIndex
        var textindexp : String.Index = text.startIndex
        var textindexq : String.Index = text.startIndex
        
        //전역 변수 불러오기
        @EnvironmentObject var EA : ErrorList
        @EnvironmentObject var show : Show
        
        if let rangeS = text.range(of: "("){//괄호가 필요한 이유가 다중 연산 때문임?
            
            s = text.distance(from: text.startIndex, to: rangeS.lowerBound)
            
            
        }
        
        if let rangeT = text.range(of: "더"){//'더'만 오면 뒤에 두 글자는 뭐가 와도 상관 없는 거임?
            
            
            t = text.distance(from: text.startIndex, to: rangeT.lowerBound)
            
        }
        
        
        
        
        if let rangeQ = text.range(of: ")"){
            
            q = text.distance(from: text.startIndex, to: rangeQ.lowerBound)
        }
        
        if (s + 1 > 0) && (t - 2 > 0) && (t + 4 > 0) && (q - 1 > 0) && (q  != t + 3) && (s != t - 2) {//이게 뭐하는 거임? 그리고 t-2가 양수이면 당연히 t+4도 양수 아님?
            textindexs = text.index(text.startIndex, offsetBy: s+1)
            textindext = text.index(text.startIndex, offsetBy: t-2)
            textindexp = text.index(text.startIndex, offsetBy: t+4)
            textindexq = text.index(text.startIndex, offsetBy: q-1)
            let range = text.index(text.startIndex, offsetBy: s) ..< text.index(text.startIndex, offsetBy: q+1) //..< 이건 뭐임
            
        
            
            if (Int(text[textindexs...textindext]) != nil) && (Int(text[textindexp...textindexq]) != nil){ //nil이 뭐임? null이랑 다름? int니까 i 들어가서 nil임?
                P1 = Int(text[textindexs...textindext])! //느낌표는 뭐임?
                P2 = Int(text[textindexp...textindexq])!
                
                replace = String(P1 + P2)
                
                textreturn = text.replacingOccurrences(of: text[range], with: replace)//text[range]가 만약 A,B를 더한다고 하면 "A+B" 전체를 replace로 바꾸는 거임?
            }
            else{//더하기 구문에 쓰인 수가 nil이 아닐 때
                
                replace = "error"
                
                if !self.EA.errorArray.contains("정수가 아닌 값을 연산할 수 없습니다."){
                    self.EA.errorArray.append("정수가 아닌 값을 연산할 수 없습니다.")
                    
                }
                
                self.show.error = true
                
                
            }

        }else{//뭔가 더하기 구문의 문법이 틀렸을 때
            
            if !self.EA.errorArray.contains("사칙 연산의 값이 입력되지 않았거나 띄어쓰기가 잘못되었습니다."){
                self.EA.errorArray.append("사칙 연산의 값이 입력되지 않았거나 띄어쓰기가 잘못되었습니다.")
            }
            
            
            self.show.error = true
        }
    
        
        return textreturn
        
    }
    
    
    
    
    func sub(text: String, line : Int) -> String { //빼기 함수
        var s = 0
        var t = 0
        var q = 0
        var textreturn = ""
        var replace = ""
        var P1 = 0
        var P2 = 0
        var textindexs : String.Index = text.startIndex
        var textindext : String.Index = text.startIndex
        var textindexp : String.Index = text.startIndex
        var textindexq : String.Index = text.startIndex
        @EnvironmentObject var EA : ErrorList
        @EnvironmentObject var show : Show
        
        if let rangeS = text.range(of: "("){
            
            s = text.distance(from: text.startIndex, to: rangeS.lowerBound)
            
            
        }
        
        if let rangeT = text.range(of: "빼"){
            
            
            t = text.distance(from: text.startIndex, to: rangeT.lowerBound)
            
        }
        
        
        
        
        if let rangeQ = text.range(of: ")"){
            
            q = text.distance(from: text.startIndex, to: rangeQ.lowerBound)
        }
        
        if (s + 1 > 0) && (t - 2 > 0) && (t + 3 > 0) && (q - 1 > 0) && (q  != t + 2) && (s != t - 2) {//여기도 t-2>0이면 당연히 t+3>0 아님?, 그리고 t는 '빼'의 위치이고 Q는 )의 위치인데 q==t+2이면 "빼기)" 인 거임?
            textindexs = text.index(text.startIndex, offsetBy: s+1)
            textindext = text.index(text.startIndex, offsetBy: t-2)
            textindexp = text.index(text.startIndex, offsetBy: t+3)
            textindexq = text.index(text.startIndex, offsetBy: q-1)
            let range = text.index(text.startIndex, offsetBy: s) ..< text.index(text.startIndex, offsetBy: q+1)
            
        
            
            if (Int(text[textindexs...textindext]) != nil) && (Int(text[textindexp...textindexq]) != nil){
                P1 = Int(text[textindexs...textindext])!
                P2 = Int(text[textindexp...textindexq])!
                
                replace = String(P1 - P2)
                
                textreturn = text.replacingOccurrences(of: text[range], with: replace)
            }
            else{//정수가 아니라 다른 값이 주어졌을 때
                
                replace = "error"
                if !self.EA.errorArray.contains("정수가 아닌 값을 연산할 수 없습니다."){
                    
                    self.EA.errorArray.append("정수가 아닌 값을 연산할 수 없습니다.")
                }
                self.show.error = true
                
                
            }



        }else{ // 빼기 문법이 틀렸을 때
            self.EA.errorArray.append("사칙 연산의 값이 입력되지 않았거나 띄어쓰기가 잘못되었습니다.")
            
            self.show.error = true
        }
    
        
        
        return textreturn
        
    }
    
    
    func mul(text: String, line : Int) -> String { //곱하기 함수. ->String은 String을 반환한다는 뜻임?
        var s = 0
        var t = 0
        var q = 0
        var textreturn = ""
        var replace = ""
        var P1 = 0
        var P2 = 0
        var textindexs : String.Index = text.startIndex
        var textindext : String.Index = text.startIndex
        var textindexp : String.Index = text.startIndex
        var textindexq : String.Index = text.startIndex
        @EnvironmentObject var EA : ErrorList //에러 추가를 위해 전역변수 불러오기, 사실 불러와야 되는 거면 전역 변수가 아닌 것 아닌가?
        @EnvironmentObject var show : Show
        
        if let rangeS = text.range(of: "("){
            
            s = text.distance(from: text.startIndex, to: rangeS.lowerBound)
            
            
        }

        if let rangeT = text.range(of: "곱하기"){
            
            
            t = text.distance(from: text.startIndex, to: rangeT.lowerBound)
            
        }
        
        
        
        
        if let rangeQ = text.range(of: ")"){
            
            q = text.distance(from: text.startIndex, to: rangeQ.lowerBound)
        }
        
        if  (t - 2 > 0)  && (q - 1 > 0) && (q  != t + 3) && (s != t - 2) {
            textindexs = text.index(text.startIndex, offsetBy: s+1)
            textindext = text.index(text.startIndex, offsetBy: t-2)
            textindexp = text.index(text.startIndex, offsetBy: t+4)
            textindexq = text.index(text.startIndex, offsetBy: q-1)
            let range = text.index(text.startIndex, offsetBy: s) ..< text.index(text.startIndex, offsetBy: q+1)
            
        
            
            if (Int(text[textindexs...textindext]) != nil) && (Int(text[textindexp...textindexq]) != nil){
                P1 = Int(text[textindexs...textindext])!
                P2 = Int(text[textindexp...textindexq])!
                
                replace = String(P1 * P2)
                
                textreturn = text.replacingOccurrences(of: text[range], with: replace)
            }
            else{
                
                replace = "error"
                if !self.EA.errorArray.contains("정수가 아닌 값을 연산할 수 없습니다."){
                    
                    self.EA.errorArray.append("정수가 아닌 값을 연산할 수 없습니다.")
                }
                
                self.show.error = true
                
                
            }


        }else{
            self.EA.errorArray.append("사칙 연산의 값이 입력되지 않았거나 띄어쓰기가 잘못되었습니다.")
            
            self.show.error = true
        }
        
        return textreturn
        
    }
    
    
    
    func div(text: String, line : Int) -> String {
        var s = 0
        var t = 0
        var q = 0
        var textreturn = ""
        var replace = ""
        var P1 = 0
        var P2 = 0
        var textindexs : String.Index = text.startIndex
        var textindext : String.Index = text.startIndex
        var textindexp : String.Index = text.startIndex
        var textindexq : String.Index = text.startIndex
        @EnvironmentObject var EA : ErrorList
        @EnvironmentObject var show : Show
        
        if let rangeS = text.range(of: "("){
            
            s = text.distance(from: text.startIndex, to: rangeS.lowerBound)
            
            
        }
        
        if let rangeT = text.range(of: "나누기"){
            
            
            t = text.distance(from: text.startIndex, to: rangeT.lowerBound)
            
        }
        
        
        
        
        if let rangeQ = text.range(of: ")"){
            
            q = text.distance(from: text.startIndex, to: rangeQ.lowerBound)
        }
        
        if (s + 1 > 0) && (t - 2 > 0) && (t + 4 > 0) && (q - 1 > 0) && (q  != t + 3) && (s != t - 2) {
            textindexs = text.index(text.startIndex, offsetBy: s+1)
            textindext = text.index(text.startIndex, offsetBy: t-2)
            textindexp = text.index(text.startIndex, offsetBy: t+4)
            textindexq = text.index(text.startIndex, offsetBy: q-1)
            let range = text.index(text.startIndex, offsetBy: s) ..< text.index(text.startIndex, offsetBy: q+1)
            
        
            
            if (Int(text[textindexs...textindext]) != nil) && (Int(text[textindexp...textindexq]) != nil){
                P1 = Int(text[textindexs...textindext])!
                P2 = Int(text[textindexp...textindexq])!
                
                if P2 == 0 {
                    textreturn = text.replacingOccurrences(of: text[range], with: "error")
                    if !self.EA.errorArray.contains("0으로 나눌 수 없습니다."){
                        self.EA.errorArray.append("0으로 나눌 수 없습니다")
                    }
                    self.show.error = true
                }else{
                    
                    replace = String(P1 / P2)
                    
                    textreturn = text.replacingOccurrences(of: text[range], with: replace)
                }
            }
            else{
                
                replace = "error"
                
                if !self.EA.errorArray.contains("정수가 아닌 값을 연산할 수 없습니다."){
                    self.EA.errorArray.append("정수가 아닌 값을 연산할 수 없습니다.")
                }
                
                self.show.error = true
                
                
            }



        }else{
            if !self.EA.errorArray.contains("사칙 연산의 값이 입력되지 않았거나 띄어쓰기가 잘못되었습니다."){
                
                self.EA.errorArray.append("사칙 연산의 값이 입력되지 않았거나 띄어쓰기가 잘못되었습니다.")
            }
            
            self.show.error = true
        }
    
        
        return textreturn
        
    }
    
    
    func mod(text: String, line : Int) -> String {
        var s = 0
        var t = 0
        var q = 0
        var textreturn = ""
        var replace = ""
        var P1 = 0
        var P2 = 0
        var textindexs : String.Index = text.startIndex
        var textindext : String.Index = text.startIndex
        var textindexp : String.Index = text.startIndex
        var textindexq : String.Index = text.startIndex
        @EnvironmentObject var EA : ErrorList
        @EnvironmentObject var show : Show
        
        if let rangeS = text.range(of: "("){
            
            s = text.distance(from: text.startIndex, to: rangeS.lowerBound)
            
            
        }
        
        if let rangeT = text.range(of: "나머지"){
            
            
            t = text.distance(from: text.startIndex, to: rangeT.lowerBound)
            
        }
        
        
        
        
        if let rangeQ = text.range(of: ")"){
            
            q = text.distance(from: text.startIndex, to: rangeQ.lowerBound)
        }
        
        if (s + 1 > 0) && (t - 2 > 0) && (t + 4 > 0) && (q - 1 > 0) && (q  != t + 3) && (s != t - 2) {
            textindexs = text.index(text.startIndex, offsetBy: s+1)
            textindext = text.index(text.startIndex, offsetBy: t-2)
            textindexp = text.index(text.startIndex, offsetBy: t+4)
            textindexq = text.index(text.startIndex, offsetBy: q-1)
            let range = text.index(text.startIndex, offsetBy: s) ..< text.index(text.startIndex, offsetBy: q+1)
            
        
            
            if (Int(text[textindexs...textindext]) != nil) && (Int(text[textindexp...textindexq]) != nil){
                P1 = Int(text[textindexs...textindext])!
                P2 = Int(text[textindexp...textindexq])!
                
                if P2 == 0{
                    textreturn = text.replacingOccurrences(of: text[range], with: "error")
                    if !self.EA.errorArray.contains("정수가 아닌 값을 연산할 수 없습니다."){
                        self.EA.errorArray.append("정수가 아닌 값을 연산할 수 없습니다.")
                    }
                    self.show.error = true
                    
                }else{
                    
                    replace = String(P1 % P2)
                    
                    textreturn = text.replacingOccurrences(of: text[range], with: replace)
                }
            }
            else{
                
                replace = "error"
                if !self.EA.errorArray.contains("정수가 아닌 값을 연산할 수 없습니다."){
                    self.EA.errorArray.append("정수가 아닌 값을 연산할 수 없습니다.")
                }
                
                self.show.error = true
                
                
            }



        }else{
            if !self.EA.errorArray.contains("사칙 연산의 값이 입력되지 않았거나 띄어쓰기가 잘못되었습니다."){
                
                self.EA.errorArray.append("사칙 연산의 값이 입력되지 않았거나 띄어쓰기가 잘못되었습니다.")
            }
            self.show.error = true
        }
    
        
        
        return textreturn
        
    }
    
    
    
    
    func vari(text: String) -> [String]  {
        let pattern: String = "(와|과)"
        var i = 0
        var s = 0
        var indexR = [String]()
        var sen = text
        var textindexA : String.Index
        var textindexB : String.Index
        
        
        
        if let rangeP = text.range(of: "자 "){
            
            let p = text.distance(from: text.startIndex, to: rangeP.lowerBound)
            textindexA = text.index(text.startIndex, offsetBy: p+1)
            
            if let rangeQ = text.range(of: "는"){
                
                let q = text.distance(from: text.startIndex, to: rangeQ.lowerBound)
                textindexB = text.index(text.startIndex, offsetBy: q-1)
                sen = String(text[textindexA...textindexB])
            }
            
            if let rangeQ = text.range(of: "은"){
                
                let q = text.distance(from: text.startIndex, to: rangeQ.lowerBound)
                textindexB = text.index(text.startIndex, offsetBy: q-1)
                sen = String(text[textindexA...textindexB])
            }
            
            
            
            
            do {
                let regex = try NSRegularExpression(pattern: pattern, options: [])
                let result = regex.matches(in: text, options: [], range: NSRange(location: 0, length: text.count))
                
                let rexStrings = result.map { (element) -> String in
                    let range = Range(element.range, in: text)!
                 
                    
                    
                    return String(text[range])
                    
                    
                }
                while i != rexStrings.count {
                    
                    if let range = sen.range(of: rexStrings[i]){
                        s = sen.distance(from: sen.startIndex, to: range.lowerBound)
                        let textindex1 = sen.index(sen.startIndex, offsetBy: s-1)
                        indexR.append(String(sen[sen.startIndex...textindex1]).replacingOccurrences(of: " ", with: ""))
                        sen = String(sen[sen.index(after: range.lowerBound)...])
                        
                    }
                    
                    i = i + 1
                    
                }
                
                indexR.append(sen.replacingOccurrences(of: " ", with: ""))
                
            }
            
            
            catch let error {
                print(error.localizedDescription)
            }
            
            
        }
        
        
        return indexR
        
    }
    
    func varir(text: String) -> [String] {
        let pattern: String = "(와|과)"
        var i = 0
        var s = 0
        var indexR = [String]()
        var sen = text
        var textindexA : String.Index
        var textindexB : String.Index
        
        if let rangeP = text.range(of: "는"){
            
            let p = text.distance(from: text.startIndex, to: rangeP.lowerBound)
            textindexA = text.index(text.startIndex, offsetBy: p+1)
            
            if let rangeQ = text.range(of: "이다"){
                
                let q = text.distance(from: text.startIndex, to: rangeQ.lowerBound)
                textindexB = text.index(text.startIndex, offsetBy: q-1)
                sen = String(text[textindexA...textindexB])
            }
            
            
            
            
            do {
                let regex = try NSRegularExpression(pattern: pattern, options: [])
                let result = regex.matches(in: text, options: [], range: NSRange(location: 0, length: text.count))
                
                let rexStrings = result.map { (element) -> String in
                    let range = Range(element.range, in: text)!
         
                    
                    
                    return String(text[range])
                    
                    
                }
                while i != rexStrings.count {
                    
                    if let range = sen.range(of: rexStrings[i]){
                        s = sen.distance(from: sen.startIndex, to: range.lowerBound)
                        let textindex1 = sen.index(sen.startIndex, offsetBy: s-1)
                        indexR.append(String(sen[sen.startIndex...textindex1]).replacingOccurrences(of: " ", with: ""))
                        sen = String(sen[sen.index(after: range.lowerBound)...])
                        
                    }
                    
                    i = i + 1
                    
                }
                
                indexR.append(sen.replacingOccurrences(of: " ", with: ""))
             
            }
            
            
            catch let error {
                print(error.localizedDescription)
            }
        }
        if let rangeP = text.range(of: "은"){
            
            let p = text.distance(from: text.startIndex, to: rangeP.lowerBound)
            textindexA = text.index(text.startIndex, offsetBy: p+1)
            
            if let rangeQ = text.range(of: "이다"){
                
                let q = text.distance(from: text.startIndex, to: rangeQ.lowerBound)
                textindexB = text.index(text.startIndex, offsetBy: q-1)
                sen = String(text[textindexA...textindexB])
            }
            
            
            
            
            do {
                let regex = try NSRegularExpression(pattern: pattern, options: [])
                let result = regex.matches(in: text, options: [], range: NSRange(location: 0, length: text.count))
                
                let rexStrings = result.map { (element) -> String in
                    let range = Range(element.range, in: text)!
                    
                    
                    return String(text[range])
                    
                    
                }
                while i != rexStrings.count {
                    
                    if let range = sen.range(of: rexStrings[i]){
                        s = sen.distance(from: sen.startIndex, to: range.lowerBound)
                        let textindex1 = sen.index(sen.startIndex, offsetBy: s-1)
                        indexR.append(String(sen[sen.startIndex...textindex1]).replacingOccurrences(of: " ", with: ""))
                        sen = String(sen[sen.index(after: range.lowerBound)...])
                        
                    }
                    
                    i = i + 1
                    
                }
                
                indexR.append(sen.replacingOccurrences(of: " ", with: ""))
           
            }
            
            
            catch let error {
                print(error.localizedDescription)
            }
        }
        
        return indexR
        
    }
    
    
    func Userinput(text: String) {
        let pattern: String = "(를 입력받는다|을 입력받는다)"
        var i = 0
        var s = 0
        var indexR = [String]()
        var sen = text
        var textindexB : String.Index
        @EnvironmentObject var input : Input
        
        
        
        if text.range(of: "입력받는다") != nil{
            
            
            
            if let rangeQ = text.range(of: "을 입력받는다"){
                
                let q = text.distance(from: text.startIndex, to: rangeQ.lowerBound)
                textindexB = text.index(text.startIndex, offsetBy: q-1)
                sen = String(text[text.startIndex...textindexB])
            }
            
            if let rangeQ = text.range(of: "를 입력받는다"){
                
                let q = text.distance(from: text.startIndex, to: rangeQ.lowerBound)
                textindexB = text.index(text.startIndex, offsetBy: q-1)
                sen = String(text[text.startIndex...textindexB])
            }
            
            
            
            
            do {
                let regex = try NSRegularExpression(pattern: pattern, options: [])
                let result = regex.matches(in: text, options: [], range: NSRange(location: 0, length: text.count))
                
                let rexStrings = result.map { (element) -> String in
                    let range = Range(element.range, in: text)!
 
                    
                    
                    return String(text[range])
                    
                    
                }
                while i != rexStrings.count {
                    
                    if let range = sen.range(of: rexStrings[i]){
                        print(sen)
                        s = sen.distance(from: sen.startIndex, to: range.lowerBound)
                        let textindex1 = sen.index(sen.startIndex, offsetBy: s-1)
                        indexR.append(String(sen[sen.startIndex...textindex1]).replacingOccurrences(of: " ", with: ""))
                        sen = String(sen[sen.index(after: range.lowerBound)...])
                        
                    }
                    
                    i = i + 1
                    
                }
                
                indexR.append(sen.replacingOccurrences(of: " ", with: ""))
         
            }
            
            
            catch let error {
                print(error.localizedDescription)
            }
            
            
        }
        
        self.input.inputArray = indexR[0]
        
        
    }
    
    
    
    
    func variX(text: String) -> [String]  {
        let pattern: String = "(와|과)"
        var i = 0
        var s = 0
        var indexR = [String]()
        var sen = text
        var textindexA : String.Index
        var textindexB : String.Index
        
        if let rangeP = text.range(of: "단 "){
            
            let p = text.distance(from: text.startIndex, to: rangeP.lowerBound)
            textindexA = text.index(text.startIndex, offsetBy: p+1)
            
            if let rangeQ = text.range(of: "는"){
                
                let q = text.distance(from: text.startIndex, to: rangeQ.lowerBound)
                textindexB = text.index(text.startIndex, offsetBy: q-1)
                sen = String(text[textindexA...textindexB])
            }
            
            
            if let rangeQ = text.range(of: "은"){
                
                let q = text.distance(from: text.startIndex, to: rangeQ.lowerBound)
                textindexB = text.index(text.startIndex, offsetBy: q-1)
                sen = String(text[textindexA...textindexB])
            }
            
            
            
            
            
            do {
                let regex = try NSRegularExpression(pattern: pattern, options: [])
                let result = regex.matches(in: text, options: [], range: NSRange(location: 0, length: text.count))
                
                let rexStrings = result.map { (element) -> String in
                    let range = Range(element.range, in: text)!
         
                    
                    
                    return String(text[range])
                    
                    
                }
                while i != rexStrings.count {
                    
                    if let range = sen.range(of: rexStrings[i]){
                        print(sen)
                        s = sen.distance(from: sen.startIndex, to: range.lowerBound)
                        let textindex1 = sen.index(sen.startIndex, offsetBy: s-1)
                        indexR.append(String(sen[sen.startIndex...textindex1]).replacingOccurrences(of: " ", with: ""))
                        sen = String(sen[sen.index(after: range.lowerBound)...])
                        
                    }
                    
                    i = i + 1
                    
                }
                
                indexR.append(sen.replacingOccurrences(of: " ", with: ""))
               
            }
            
            
            catch let error {
                print(error.localizedDescription)
            }
            
            
        }
        
        
        return indexR
        
    }
    
    func varirX(text: String) -> [String] {
        let pattern: String = "(와|과)"
        
        
        var i = 0
        var s = 0
        var indexR = [String]()
        var sen = text
        var textindexA : String.Index
        var textindexB : String.Index
        
        if let rangeP = text.range(of: "는"){
            
            let p = text.distance(from: text.startIndex, to: rangeP.lowerBound)
            textindexA = text.index(text.startIndex, offsetBy: p+1)
            
            if let rangeQ = text.range(of: "이다"){
                
                let q = text.distance(from: text.startIndex, to: rangeQ.lowerBound)
                textindexB = text.index(text.startIndex, offsetBy: q-1)
                sen = String(text[textindexA...textindexB])
            }
            
            
            
            
            do {
                let regex = try NSRegularExpression(pattern: pattern, options: [])
                let result = regex.matches(in: text, options: [], range: NSRange(location: 0, length: text.count))
                
                let rexStrings = result.map { (element) -> String in
                    let range = Range(element.range, in: text)!
                    print(range)
                    print(text[range])
                    
                    
                    return String(text[range])
                    
                    
                }
                while i != rexStrings.count {
                    
                    if let range = sen.range(of: rexStrings[i]){
                        print(sen)
                        s = sen.distance(from: sen.startIndex, to: range.lowerBound)
                        let textindex1 = sen.index(sen.startIndex, offsetBy: s-1)
                        indexR.append(String(sen[sen.startIndex...textindex1]).replacingOccurrences(of: " ", with: ""))
                        sen = String(sen[sen.index(after: range.lowerBound)...])
                        
                    }
                    
                    i = i + 1
                    
                }
                
                indexR.append(sen.replacingOccurrences(of: " ", with: ""))
                print(rexStrings)
                print(indexR)
                
                print(sen)
            }
            
            
            catch let error {
                print(error.localizedDescription)
            }
        }
        if let rangeP = text.range(of: "은"){
            
            let p = text.distance(from: text.startIndex, to: rangeP.lowerBound)
            textindexA = text.index(text.startIndex, offsetBy: p+1)
            
            if let rangeQ = text.range(of: "이다"){
                
                let q = text.distance(from: text.startIndex, to: rangeQ.lowerBound)
                textindexB = text.index(text.startIndex, offsetBy: q-1)
                sen = String(text[textindexA...textindexB])
            }
            
            
            
            
            do {
                let regex = try NSRegularExpression(pattern: pattern, options: [])
                let result = regex.matches(in: text, options: [], range: NSRange(location: 0, length: text.count))
                
                let rexStrings = result.map { (element) -> String in
                    let range = Range(element.range, in: text)!
                    print(range)
                    print(text[range])
                    
                    
                    return String(text[range])
                    
                    
                }
                while i != rexStrings.count {
                    
                    if let range = sen.range(of: rexStrings[i]){
                        print(sen)
                        s = sen.distance(from: sen.startIndex, to: range.lowerBound)
                        let textindex1 = sen.index(sen.startIndex, offsetBy: s-1)
                        indexR.append(String(sen[sen.startIndex...textindex1]).replacingOccurrences(of: " ", with: ""))
                        sen = String(sen[sen.index(after: range.lowerBound)...])
                        
                    }
                    
                    i = i + 1
                    
                }
                
                indexR.append(sen.replacingOccurrences(of: " ", with: ""))
                print(rexStrings)
                print(indexR)
                
                print(sen)
            }
            
            
            catch let error {
                print(error.localizedDescription)
            }
        }
        
        return indexR
        
    }
    
    func mathD(text:String) -> String{
        var s = 0
        var t = 0
        var i = 0
        var p = 0
        
        var indexR : [String] = []
        
        
        
        
        
        
        
        if let range = text.range(of: "("){
            
            s = text.distance(from: text.startIndex, to: range.lowerBound)
        }
        
        
        if let range = text.range(of: ")"){
            
            t = text.distance(from: text.startIndex, to: range.lowerBound)
        }
        
        if let range = text.range(of: "미"){
            
            p = text.distance(from: text.startIndex, to: range.lowerBound)
        }
        
        
        
        
        let textindex1 = text.index(text.startIndex, offsetBy: s + 1)
        let textindex2 = text.index(text.startIndex, offsetBy: t - 1)
        let textindex3 = text.index(text.startIndex, offsetBy: p)
        let textindex4 = text.index(text.startIndex, offsetBy: t)
        
        
        let Dtext = String(text[textindex1...textindex2])
        
        let indexD = Dtext.split(separator: ",")
        
        let n = indexD.count - 1
        
        i = n
        
        var i2 = 0
        
        while i != 0 {
            
            
            let S = Int(indexD[i2])!
            let R = i * S
            
            indexR.append(String(R))
            
            i = i - 1
            i2 = i2 + 1
            
            
        }
        
        let replace = String(text[textindex3...textindex4])
        
        
        
        
        return text.replacingOccurrences(of: replace, with: indexR.joined(separator: " "))
    }
    
    func ifRecognize(text : String) -> Bool{
        
        var s = 0
        var t = 0
        var p = 0
        var q = 0
        var re : Bool = false
        
        
        if let range = text.range(of: "만약"){
            t = text.distance(from: text.startIndex, to: range.lowerBound) + 3
        }
        
        if let range = text.range(of: "이면"){
            
            s = text.distance(from: text.startIndex, to: range.lowerBound) - 2
        }
        
        
        
        
        
        
        
        
        
        let condition2 = text.index(text.startIndex, offsetBy: s)
        
        let condition1 = text.index(text.startIndex, offsetBy: t)
        let condition = String(text[condition1...condition2])
        
        
        if condition.contains("="){
            
            
            
            if let range = condition.range(of: "="){
                p = condition.distance(from: condition.startIndex, to: range.lowerBound) - 2
                
                q = condition.distance(from: condition.startIndex, to: range.lowerBound) + 2
                
                let condition3 = condition.index(condition.startIndex, offsetBy: p)
                
                let condition4 = condition.index(condition.startIndex, offsetBy: q)
                
                let conditionC1 = String(condition[condition.startIndex...condition3])
                
                let conditionC2 = String(condition[condition4..<condition.endIndex])
                
                if conditionC1 == conditionC2{
                    
                    re = true
                    
                } else{
                    re = false
                }
            }
            
        }
        
        if condition.contains("!="){
            
            
            
            if let range = condition.range(of: "!="){
                p = condition.distance(from: condition.startIndex, to: range.lowerBound) - 2
                
                q = condition.distance(from: condition.startIndex, to: range.lowerBound) + 3
                
                let condition3 = condition.index(condition.startIndex, offsetBy: p)
                
                let condition4 = condition.index(condition.startIndex, offsetBy: q)
                
                let conditionC1 = String(condition[condition.startIndex...condition3])
                
                let conditionC2 = String(condition[condition4..<condition.endIndex])
                
                if conditionC1 == conditionC2{
                    
                    re = false
                    
                } else{
                    re = true
                }
            }
            
        }
        
        if condition.contains(">"){
            
            
            if let range = condition.range(of: ">"){
                p = condition.distance(from: condition.startIndex, to: range.lowerBound) - 2
                
                q = condition.distance(from: condition.startIndex, to: range.lowerBound) + 2
                
                let condition3 = condition.index(condition.startIndex, offsetBy: p)
                
                let condition4 = condition.index(condition.startIndex, offsetBy: q)
                
                let conditionC1 = String(condition[condition.startIndex...condition3])
                
                let conditionC2 = String(condition[condition4..<condition.endIndex])
                
                if Int(conditionC1) ?? 0 > Int(conditionC2) ?? 0{
                    
                    re = true
                    
                } else{
                    re = false
                }
            }
            
        }
        
        
        if condition.contains(">="){
            
            
            if let range = condition.range(of: ">="){
                p = condition.distance(from: condition.startIndex, to: range.lowerBound) - 2
                
                q = condition.distance(from: condition.startIndex, to: range.lowerBound) + 3
                
                let condition3 = condition.index(condition.startIndex, offsetBy: p)
                
                let condition4 = condition.index(condition.startIndex, offsetBy: q)
                
                let conditionC1 = String(condition[condition.startIndex...condition3])
                
                let conditionC2 = String(condition[condition4..<condition.endIndex])
                
                if Int(conditionC1) ?? 0 >= Int(conditionC2) ?? 0{
                    
                    re = true
                    
                } else{
                    re = false
                }
            }
            
        }
        
        if condition.contains("<"){
            
            
            
            
            if let range = condition.range(of: "<"){
                p = condition.distance(from: condition.startIndex, to: range.lowerBound) - 2
                
                q = condition.distance(from: condition.startIndex, to: range.lowerBound) + 2
                
                let condition3 = condition.index(condition.startIndex, offsetBy: p)
                
                let condition4 = condition.index(condition.startIndex, offsetBy: q)
                
                let conditionC1 = String(condition[condition.startIndex...condition3])
                
                let conditionC2 = String(condition[condition4..<condition.endIndex])
                
                if Int(conditionC1) ?? 0 < Int(conditionC2) ?? 0{
                    
                    re = true
                    
                } else{
                    re = false
                }
            }
            
            
        }
        
        
        if condition.contains("<="){
            
            
            
            
            if let range = condition.range(of: "<="){
                p = condition.distance(from: condition.startIndex, to: range.lowerBound) - 2
                
                q = condition.distance(from: condition.startIndex, to: range.lowerBound) + 3
                
                let condition3 = condition.index(condition.startIndex, offsetBy: p)
                
                let condition4 = condition.index(condition.startIndex, offsetBy: q)
                
                let conditionC1 = String(condition[condition.startIndex...condition3])
                
                let conditionC2 = String(condition[condition4..<condition.endIndex])
                
                if Int(conditionC1) ?? 0 <= Int(conditionC2) ?? 0{
                    
                    re = true
                    
                } else{
                    re = false
                }
            }
            
            
        }
        
        
        
        
        
        
        
        return re
        
        
    }
    
    func ifNotRecognize(text : String) -> Bool{
        
        var s = 0
        var t = 0
        var p = 0
        var q = 0
        var re : Bool = false
        
        
        if let range = text.range(of: "만약"){
            t = text.distance(from: text.startIndex, to: range.lowerBound) + 3
        }
        
        if let range = text.range(of: "이 아니면"){
            
            s = text.distance(from: text.startIndex, to: range.lowerBound) - 2
        }
        
        if let range = text.range(of: "가 아니면"){
            
            s = text.distance(from: text.startIndex, to: range.lowerBound) - 2
        }
        
        
        
        
        
        
        
        
        
        let condition2 = text.index(text.startIndex, offsetBy: s)
        
        let condition1 = text.index(text.startIndex, offsetBy: t)
        let condition = String(text[condition1...condition2])
        
        
        
        if condition.contains("="){
            
            if let range = condition.range(of: "="){
                p = condition.distance(from: condition.startIndex, to: range.lowerBound) - 2
                
                q = condition.distance(from: condition.startIndex, to: range.lowerBound) + 2
                
                let condition3 = condition.index(condition.startIndex, offsetBy: p)
                
                let condition4 = condition.index(condition.startIndex, offsetBy: q)
                
                let conditionC1 = String(condition[condition.startIndex...condition3])
                
                let conditionC2 = String(condition[condition4..<condition.endIndex])
                
                if conditionC1 == conditionC2{
                    
                    re = false
                    
                } else{
                    re = true
                }
            }
            
        }
        
        if condition.contains(">"){
            
            
            if let range = condition.range(of: ">"){
                p = condition.distance(from: condition.startIndex, to: range.lowerBound) - 2
                
                q = condition.distance(from: condition.startIndex, to: range.lowerBound) + 2
                
                let condition3 = condition.index(condition.startIndex, offsetBy: p)
                
                let condition4 = condition.index(condition.startIndex, offsetBy: q)
                
                let conditionC1 = String(condition[condition.startIndex...condition3])
                
                let conditionC2 = String(condition[condition4..<condition.endIndex])
                
                if Int(conditionC1) ?? 0 > Int(conditionC2) ?? 0{
                    
                    re = false
                    
                } else{
                    re = true
                }
            }
            
        }
        
        if condition.contains("<"){
            
            
            if let range = condition.range(of: "<"){
                p = condition.distance(from: condition.startIndex, to: range.lowerBound) - 2
                
                q = condition.distance(from: condition.startIndex, to: range.lowerBound) + 2
                
                let condition3 = condition.index(condition.startIndex, offsetBy: p)
                
                let condition4 = condition.index(condition.startIndex, offsetBy: q)
                
                let conditionC1 = String(condition[condition.startIndex...condition3])
                
                let conditionC2 = String(condition[condition4..<condition.endIndex])
                
                if Int(conditionC1) ?? 0 < Int(conditionC2) ?? 0{
                    
                    re = false
                    
                } else{
                    re = true
                }
            }
            
            
        }
        
        
        
        
        
        
        
        return re
        
        
    }
    
    
    class indexFR : ObservableObject {
        @Published var indexF = [String]()
        @Published var indexFC = [String]()
    }
    
    
    
    class Value : ObservableObject{
        @Published var const = [String]()
        @Published var constR = [String]()
        @Published var varI = [String]()
        @Published var varIR = [String]()
        @Published var errorcatchforVar = 0
        @Published var errorcatchforConst = 0

    }
    
    
    
    func finishpoint(text: String) -> [String]{
        
        var indexX = [String]()
        
        var i = 0
        var Newtext = text
        var errorcatchforConst = 0
        var check1  : Bool = false
        
        @EnvironmentObject var index : indexFR
        @EnvironmentObject var show : Show
        @EnvironmentObject var valueCV : Value
        
        
        
        
        indexX.removeAll()
        self.valueCV.constR.removeAll()
        self.valueCV.const.removeAll()
        self.valueCV.varI.removeAll()
        self.valueCV.varIR.removeAll()
        
        
        
        
        
        if Newtext.contains("만약"){
            
            Newtext = ifcompile(text: Newtext)
            
            
        }
        
        if Newtext.contains("동안") {
            Newtext = whiilecompile(text: Newtext)
        }
        
        else{
            Newtext = Newtext.replacingOccurrences(of: "\n", with: "")
        }
        
        
        
        
        
        indexX = Newtext.components(separatedBy: ".")
        
        
        
        
        while indexX.count != i + 1 {
            
            
            var k = 0
            
            
            while k != indexfr.indexF.count {
                
                if indexX[i].contains(indexfr.indexF[k] + "()") {
                    indexX[i] = indexX[i].replacingOccurrences(of: indexfr.indexF[k] + "()", with: FPforFD(text: indexfr.indexFC[k]))
                    print("성공")
                }
                
                k = k + 1
            }
            
            
            if (indexX[i].contains("이다")) && (!(indexX[i].contains("단")) && !(indexX[i].contains("자"))) {
                if !self.EA.errorArray.contains("상수 혹은 변수를 정의하려면 각각 '단' 혹은 '자'를 사용해야합니다. 값을 바꾸려면 바꾼다 방식으로 바꿀 수 있습니다."){
                    self.EA.errorArray.append("상수 혹은 변수를 정의하려면 각각 '단' 혹은 '자'를 사용해야합니다. 값을 바꾸려면 바꾼다 방식으로 바꿀 수 있습니다.")
                }
                self.show.error = true

            }
            
            
            if (vari(text: indexX[i]).contains("--")) || (variX(text: indexX[i]).contains("--")) {
                if !self.EA.errorArray.contains("--을 사용할 수 없습니다."){
                    self.EA.errorArray.append("--을 사용할 수 없습니다.")
                    
                }
                self.show.error = true
            }
            
            if indexX[i].contains("-" + input.inputArray){
                indexX[i] = indexX[i].replacingOccurrences(of: "-" + input.inputArray, with: input.inputResult)
            }
           
            
            var i2 = 0
            
            if indexX[i].contains("단"){
                
                var putsitem = indexX[i]
                
                
                if putsitem.contains("더하기"){
                    if !(putsitem.contains("(")) || !(putsitem.contains(")")){
                        if !self.EA.errorArray.contains("사칙연산에는 괄호가 필요합니다."){
                            self.EA.errorArray.append("사칙연산에는 괄호가 필요합니다.")
                        }
                        self.show.error = true
                        check1 = true
                        return []
                    }else{
                        putsitem = plus(text: putsitem, line: i + 1)
                    }
                    
                }
                
                
                if putsitem.contains("빼기"){
                    if !(putsitem.contains("(")) || !(putsitem.contains(")")){
                        if !self.EA.errorArray.contains("사칙연산에는 괄호가 필요합니다."){
                            self.EA.errorArray.append("사칙연산에는 괄호가 필요합니다.")
                        }
                        self.show.error = true
                        check1 = true
                        return []
                        
                    }else{
                        putsitem = sub(text: putsitem, line: i + 1)
                    }
                }
                
                if putsitem.contains("곱하기"){
                    if !(putsitem.contains("(")) || !(putsitem.contains(")")){
                        if !self.EA.errorArray.contains("사칙연산에는 괄호가 필요합니다."){
                            self.EA.errorArray.append("사칙연산에는 괄호가 필요합니다.")
                        }
                        self.show.error = true
                        check1 = true
                        return []
                        
                    }else{
                        putsitem = mul(text: putsitem, line: i + 1)
                    }
                }
                
                if putsitem.contains("나누기"){
                    if !(putsitem.contains("(")) || !(putsitem.contains(")")){
                        if !self.EA.errorArray.contains("사칙연산에는 괄호가 필요합니다."){
                            self.EA.errorArray.append("사칙연산에는 괄호가 필요합니다.")
                        }
                        self.show.error = true
                        check1 = true
                        return []
                        
                    }else{
                        putsitem = div(text: putsitem, line: i + 1)
                    }
                }
                if putsitem.contains("나머지"){
                    if !(putsitem.contains("(")) || !(putsitem.contains(")")){
                        if !self.EA.errorArray.contains("사칙연산에는 괄호가 필요합니다."){
                            self.EA.errorArray.append("사칙연산에는 괄호가 필요합니다.")
                        }
                        self.show.error = true
                        check1 = true
                        return []

                    }else{
                        putsitem = mod(text: putsitem, line: i + 1)
                    }
                }
                
                if !self.show.error{
                    
                    if (self.valueCV.varI.contains(variX(text: putsitem)[0])) || (self.valueCV.const.contains(variX(text: putsitem)[0])){
                        self.EA.errorArray.append("두 개 이상의 값이 같은 이름으로 정의되었습니다3.")
                        self.show.error = true
                        
                    }else{
                        
                        
                        self.valueCV.const.append(contentsOf: variX(text: putsitem))
                        self.valueCV.constR.append(contentsOf: varirX(text: putsitem))
                    }
                    
                }
                
                
                indexX[i] = putsitem
            }
            
            if (indexX[i].contains("자")) && !(indexX[i].contains("바꾼다")){
                
                var putsitem = indexX[i]
                
                
                
                if putsitem.contains("더하기"){
                    if !(putsitem.contains("(")) || !(putsitem.contains(")")){
                        if !self.EA.errorArray.contains("사칙연산에는 괄호가 필요합니다."){
                            self.EA.errorArray.append("사칙연산에는 괄호가 필요합니다.")
                        }
                        self.show.error = true
                        check1 = true
                        return []
                    }else{
                        putsitem = plus(text: putsitem, line: i + 1)
                    }
                    
                }
                
                
                if putsitem.contains("빼기"){
                    if !(putsitem.contains("(")) || !(putsitem.contains(")")){
                        if !self.EA.errorArray.contains("사칙연산에는 괄호가 필요합니다."){
                            self.EA.errorArray.append("사칙연산에는 괄호가 필요합니다.")
                        }
                        self.show.error = true
                        check1 = true
                        return []
                        
                    }else{
                        putsitem = sub(text: putsitem, line: i + 1)
                    }
                }
                
                if putsitem.contains("곱하기"){
                    if !(putsitem.contains("(")) || !(putsitem.contains(")")){
                        if !self.EA.errorArray.contains("사칙연산에는 괄호가 필요합니다."){
                            self.EA.errorArray.append("사칙연산에는 괄호가 필요합니다.")
                        }
                        self.show.error = true
                        check1 = true
                        return []
                        
                    }else{
                        putsitem = mul(text: putsitem, line: i + 1)
                    }
                }
                
                if putsitem.contains("나누기"){
                    if !(putsitem.contains("(")) || !(putsitem.contains(")")){
                        if !self.EA.errorArray.contains("사칙연산에는 괄호가 필요합니다."){
                            self.EA.errorArray.append("사칙연산에는 괄호가 필요합니다.")
                        }
                        self.show.error = true
                        check1 = true
                        return []
                        
                    }else{
                        putsitem = div(text: putsitem, line: i + 1)
                    }
                }
                if putsitem.contains("나머지"){
                    if !(putsitem.contains("(")) || !(putsitem.contains(")")){
                        if !self.EA.errorArray.contains("사칙연산에는 괄호가 필요합니다."){
                            self.EA.errorArray.append("사칙연산에는 괄호가 필요합니다.")
                        }
                        self.show.error = true
                        check1 = true
                        return []

                    }else{
                        putsitem = mod(text: putsitem, line: i + 1)
                    }
                }
                
                
            }
            
            if (indexX[i].contains("-")){
                if indexX[i].contains("--"){
                    if !self.EA.errorArray.contains("-를 두번 사용하여 값을 호출하는 것이 불가능합니다."){
                        self.EA.errorArray.append("-를 두번 사용하여 값을 호출하는 것이 불가능합니다.")
                    }
                }
                
                if indexX[i].contains(self.input.inputArray){
                    indexX[i] = indexX[i].replacingOccurrences(of: "-" + self.input.inputArray, with: self.input.inputResult)
                
                    
                   
                
                   
                
            }
                
                while i2 != self.valueCV.const.count{
                    
                   
                        
                    if indexX[i].contains("-" + self.valueCV.const[i2]){
                            
                        indexX[i] = indexX[i].replacingOccurrences(of: "-" + self.valueCV.const[i2], with: self.valueCV.constR[i2])
                            
                        }else{
                            
                            errorcatchforConst = errorcatchforConst + 1

                        
                    }
                    
                    
                    
                    i2 = i2 + 1
                }
                var i3 = 0
                
                while i3 != self.valueCV.varI.count {
                    
                    if indexX[i].contains("-"){
                        
                        if indexX[i].contains("-" + self.valueCV.varI[i3]){
                            
                            indexX[i] = indexX[i].replacingOccurrences(of: "-" + self.valueCV.varI[i3], with: self.valueCV.varIR[i3])
                            
                        }else{
                            self.valueCV.errorcatchforVar = self.valueCV.errorcatchforVar + 1

                            
                        }
                    }
                    i3 = i3 + 1
                }
                
                if (i3 == self.valueCV.errorcatchforVar) && (i2 == self.valueCV.errorcatchforConst) {
                    if !self.EA.errorArray.contains("정의하지 않은 값을 호출했습니다1."){
                        self.EA.errorArray.append("정의하지 않은 값을 호출했습니다1.")
                    }
                    self.show.error = true
                }
                
                
                
                
                
                
                
                
            }
            
           
            
            
            
            var s1 = 0
            var s2 = 0
            
            if indexX[i].contains("바꾼다"){
                
                var putsitem = indexX[i]
                
                if putsitem.contains("더하기"){
                    if !(putsitem.contains("(")) && !(putsitem.contains(")")){
                        self.EA.errorArray.append("사칙연산에는 괄호가 필요합니다.")
                        self.show.error = true
                    }else{
                        putsitem = plus(text: putsitem, line: i + 1)
                    }
                    
                }
                
                
                if putsitem.contains("빼기"){
                    if !(putsitem.contains("(")) && !(putsitem.contains(")")){
                        self.EA.errorArray.append("사칙연산에는 괄호가 필요합니다.")
                        self.show.error = true
                    }else{
                        putsitem = sub(text: putsitem, line: i + 1)
                    }
                }
                
                if putsitem.contains("곱하기"){
                    if !(putsitem.contains("(")) && !(putsitem.contains(")")){
                        self.EA.errorArray.append("사칙연산에는 괄호가 필요합니다.")
                        self.show.error = true
                    }else{
                        putsitem = mul(text: putsitem, line: i + 1)
                    }
                }
                
                if putsitem.contains("나누기"){
                    if !(putsitem.contains("(")) && !(putsitem.contains(")")){
                        self.EA.errorArray.append("사칙연산에는 괄호가 필요합니다.")
                        self.show.error = true
                    }else{
                        putsitem = div(text: putsitem, line: i + 1)
                    }
                }
                if putsitem.contains("나머지"){
                    if !(putsitem.contains("(")) && !(putsitem.contains(")")){
                        self.EA.errorArray.append("사칙연산에는 괄호가 필요합니다.")
                        self.show.error = true
                    }else{
                        putsitem = mod(text: putsitem, line: i + 1)
                    }
                }
                
                if ((putsitem.contains("를")) || (putsitem.contains("을"))) && ((putsitem.contains("로")) || (putsitem.contains("으로"))){
                    
                    
                    
                    
                    
                    if let range = putsitem.range(of: "를"){
                        s1 = putsitem.distance(from: putsitem.startIndex, to: range.lowerBound)
                    }
                    
                    if let range = putsitem.range(of: "을"){
                        s1 = putsitem.distance(from: putsitem.startIndex, to: range.lowerBound)
                    }
                    
                    if let range = putsitem.range(of: "로"){
                        s2 = putsitem.distance(from: putsitem.startIndex, to: range.lowerBound)
                    }
                    
                    if let range = putsitem.range(of: "으로"){
                        s2 = putsitem.distance(from: putsitem.startIndex, to: range.lowerBound)
                    }
                    
                    
                    let textindex1 = putsitem.index(putsitem.startIndex, offsetBy: s1 - 1)
                    let textindex2 = putsitem.index(putsitem.startIndex, offsetBy: s1 + 2)
                    let textindex3 = putsitem.index(putsitem.startIndex, offsetBy: s2 - 1)
                    
                    let const1 = String(putsitem[putsitem.startIndex...textindex1])
                    let constR1 = String(putsitem[textindex2...textindex3])
                    
                    if let a = self.valueCV.varI.firstIndex(of: const1){
                        
                        self.valueCV.varIR[a] = constR1
                    } else{
                        if !(self.EA.errorArray.contains("상수의 값을 바꾸려는 시도가 있습니다3.")){
                            self.EA.errorArray.append("상수의 값을 바꾸려는 시도가 있습니다3.")
                        }
                        self.show.error = true

                        
                        
                    }
                }else{
                    self.EA.errorArray.append("변수의 값을 바꾸는 코드에서 문법을 지키지 않았습니다.")
                    self.show.error = true
                }
            }
            
            
            
            
            
            
            if indexX[i].contains("빼기"){
                if !(indexX[i].contains("(")) && !(indexX[i].contains(")")){
                    self.EA.errorArray.append("사칙연산에는 괄호가 필요합니다.")
                    self.show.error = true
                }else{
                    indexX[i] = sub(text: indexX[i], line: i + 1)
                }
            }
            if indexX[i].contains("더하기"){
                if !(indexX[i].contains("(")) && !(indexX[i].contains(")")){
                    self.EA.errorArray.append("사칙연산에는 괄호가 필요합니다.")
                    self.show.error = true
                }else{
                    indexX[i] = plus(text: indexX[i], line: i + 1)
                }
            }
            
            if indexX[i].contains("곱하기"){
                if !(indexX[i].contains("(")) && !(indexX[i].contains(")")){
                    self.EA.errorArray.append("사칙연산에는 괄호가 필요합니다.")
                    self.show.error = true
                }else{
                    indexX[i] = mul(text: indexX[i], line: i + 1)
                }
            }
            if indexX[i].contains("나누기"){
                if !(indexX[i].contains("(")) && !(indexX[i].contains(")")){
                    self.EA.errorArray.append("사칙연산에는 괄호가 필요합니다.")
                    self.show.error = true
                }else{
                    indexX[i] = div(text: indexX[i], line: i + 1)
                }
            }
            
            
            if indexX[i].contains("나머지"){
                if !(indexX[i].contains("(")) && !(indexX[i].contains(")")){
                    self.EA.errorArray.append("사칙연산에는 괄호가 필요합니다.")
                    self.show.error = true
                }else{
                    indexX[i] = mod(text: indexX[i], line: i + 1)
                }
            }
            
            
            
            if indexX[i].contains("미분"){
                indexX[i] = mathD(text: indexX[i])
            }
            
            
            
            indexX[i] = indexX[i].replacingOccurrences(of: "\\줄", with: "\n")
            
            
            
            
            
            
            if let range = indexX[i].range(of: "출력한다"){
                if !(indexX[i].contains("을")) && !(indexX[i].contains("를")){
                    if !self.EA.errorArray.contains("출력할 때 조사를 입력해야합니다."){
                        self.EA.errorArray.append("출력할 때 조사를 입력해야합니다.")
                    }
                    self.show.error = true
                }else{
                    
                    indexX[i] = indexX[i].replacingOccurrences(of: "출력한다", with: "")
                    
                    
                    let S = indexX[i].distance(from: indexX[i].startIndex, to: range.lowerBound)
                    
                    if (indexX[i].last != " ") || (indexX[i].last != " "){
                        if !self.EA.errorArray.contains("출력하는 코드 중 띄어쓰기가 잘못된 코드가 있습니다."){
                            self.EA.errorArray.append("출력하는 코드 중 띄어쓰기가 잘못된 코드가 있습니다.")
                        }
                        self.show.error = true
                    }else{
                        let textindex = indexX[i].index(indexX[i].startIndex, offsetBy: S-3)
                        indexX[i] = String(indexX[i][indexX[i].startIndex...textindex])
                    }
                    
                }
            }
            
            else {
                
                
                if let range = indexX[i].range(of: "실행한다"){
                    indexX[i] = indexX[i].replacingOccurrences(of: "실행한다", with: "")
                    
                    let S = indexX[i].distance(from: indexX[i].startIndex, to: range.lowerBound)
                    let textindex = indexX[i].index(indexX[i].startIndex, offsetBy: S-3)
                    indexX[i] = String(indexX[i][indexX[i].startIndex...textindex])
                    
                    
                    
                    
                }else{
                    indexX[i] = ""
                }
                
                
                
            }
            
            
            
            
            
            
            
            
            i = i + 1
        }
        
        
        
        
        
        
        return indexX
        
        
    }
    
    
    
    
    
    
    
    func FPforIF(text: String) -> [String]{
        
        var indexX = [String]()

        var i = 0
        let Newtext = text
        var errorcatchforConst = 0
        var errorcatchforVar = 0
        var check1  : Bool = false


        @EnvironmentObject var index : indexFR
        @EnvironmentObject var show : Show
        
        
        
        
        indexX.removeAll()

        
        
        
        
        
        
       
        
        
        indexX = Newtext.components(separatedBy: ".")
        
        
        
        
        
        while indexX.count != i + 1 {
            
            indexX[i] = indexX[i].replacingOccurrences(of: "\n", with: "")
            
            var k = 0
            
            
            while k != indexfr.indexF.count {
                
                if indexX[i].contains(indexfr.indexF[k] + "()") {
                    indexX[i] = indexX[i].replacingOccurrences(of: indexfr.indexF[k] + "()", with: FPforFD(text: indexfr.indexFC[k]))
                    print("성공")
                }
                
                k = k + 1
            }
            
            
            if (indexX[i].contains("이다")) && (!(indexX[i].contains("단")) && !(indexX[i].contains("자"))) {
                if !self.EA.errorArray.contains("상수 혹은 변수를 정의하려면 각각 '단' 혹은 '자'를 사용해야합니다. 값을 바꾸려면 바꾼다 방식으로 바꿀 수 있습니다."){
                    self.EA.errorArray.append("상수 혹은 변수를 정의하려면 각각 '단' 혹은 '자'를 사용해야합니다. 값을 바꾸려면 바꾼다 방식으로 바꿀 수 있습니다.")
                }
                self.show.error = true

            }
            
            
            if (vari(text: indexX[i]).contains("--")) || (variX(text: indexX[i]).contains("--")) {
                if !self.EA.errorArray.contains("--을 사용할 수 없습니다."){
                    self.EA.errorArray.append("--을 사용할 수 없습니다.")
                    
                }
                self.show.error = true
            }
            
            if indexX[i].contains("-" + input.inputArray){
                indexX[i] = indexX[i].replacingOccurrences(of: "-" + input.inputArray, with: input.inputResult)
            }
           
            
            var i2 = 0
            
            if indexX[i].contains("단"){
                
                var putsitem = indexX[i]
                
                
                if putsitem.contains("더하기"){
                    if !(putsitem.contains("(")) || !(putsitem.contains(")")){
                        if !self.EA.errorArray.contains("사칙연산에는 괄호가 필요합니다."){
                            self.EA.errorArray.append("사칙연산에는 괄호가 필요합니다.")
                        }
                        self.show.error = true
                        check1 = true
                        return []
                    }else{
                        putsitem = plus(text: putsitem, line: i + 1)
                    }
                    
                }
                
                
                if putsitem.contains("빼기"){
                    if !(putsitem.contains("(")) || !(putsitem.contains(")")){
                        if !self.EA.errorArray.contains("사칙연산에는 괄호가 필요합니다."){
                            self.EA.errorArray.append("사칙연산에는 괄호가 필요합니다.")
                        }
                        self.show.error = true
                        check1 = true
                        return []
                        
                    }else{
                        putsitem = sub(text: putsitem, line: i + 1)
                    }
                }
                
                if putsitem.contains("곱하기"){
                    if !(putsitem.contains("(")) || !(putsitem.contains(")")){
                        if !self.EA.errorArray.contains("사칙연산에는 괄호가 필요합니다."){
                            self.EA.errorArray.append("사칙연산에는 괄호가 필요합니다.")
                        }
                        self.show.error = true
                        check1 = true
                        return []
                        
                    }else{
                        putsitem = mul(text: putsitem, line: i + 1)
                    }
                }
                
                if putsitem.contains("나누기"){
                    if !(putsitem.contains("(")) || !(putsitem.contains(")")){
                        if !self.EA.errorArray.contains("사칙연산에는 괄호가 필요합니다."){
                            self.EA.errorArray.append("사칙연산에는 괄호가 필요합니다.")
                        }
                        self.show.error = true
                        check1 = true
                        return []
                        
                    }else{
                        putsitem = div(text: putsitem, line: i + 1)
                    }
                }
                if putsitem.contains("나머지"){
                    if !(putsitem.contains("(")) || !(putsitem.contains(")")){
                        if !self.EA.errorArray.contains("사칙연산에는 괄호가 필요합니다."){
                            self.EA.errorArray.append("사칙연산에는 괄호가 필요합니다.")
                        }
                        self.show.error = true
                        check1 = true
                        return []

                    }else{
                        putsitem = mod(text: putsitem, line: i + 1)
                    }
                }
                
                if !self.show.error{
                    
                    if (self.valueCV.varI.contains(variX(text: putsitem)[0])) || (self.valueCV.const.contains(variX(text: putsitem)[0])){
                        self.EA.errorArray.append("두 개 이상의 값이 같은 이름으로 정의되었습니다5.")
                        self.show.error = true
                        
                    }else{
                        
                        
                        self.valueCV.const.append(contentsOf: variX(text: putsitem))
                        self.valueCV.constR.append(contentsOf: varirX(text: putsitem))
                    }
                    
                }
                
                
                indexX[i] = putsitem
            }
            
            if (indexX[i].contains("자")) && !(indexX[i].contains("바꾼다")){
                
                var putsitem = indexX[i]
                
                
                
                if putsitem.contains("더하기"){
                    if !(putsitem.contains("(")) || !(putsitem.contains(")")){
                        if !self.EA.errorArray.contains("사칙연산에는 괄호가 필요합니다."){
                            self.EA.errorArray.append("사칙연산에는 괄호가 필요합니다.")
                        }
                        self.show.error = true
                        check1 = true
                        return []
                    }else{
                        putsitem = plus(text: putsitem, line: i + 1)
                    }
                    
                }
                
                
                if putsitem.contains("빼기"){
                    if !(putsitem.contains("(")) || !(putsitem.contains(")")){
                        if !self.EA.errorArray.contains("사칙연산에는 괄호가 필요합니다."){
                            self.EA.errorArray.append("사칙연산에는 괄호가 필요합니다.")
                        }
                        self.show.error = true
                        check1 = true
                        return []
                        
                    }else{
                        putsitem = sub(text: putsitem, line: i + 1)
                    }
                }
                
                if putsitem.contains("곱하기"){
                    if !(putsitem.contains("(")) || !(putsitem.contains(")")){
                        if !self.EA.errorArray.contains("사칙연산에는 괄호가 필요합니다."){
                            self.EA.errorArray.append("사칙연산에는 괄호가 필요합니다.")
                        }
                        self.show.error = true
                        check1 = true
                        return []
                        
                    }else{
                        putsitem = mul(text: putsitem, line: i + 1)
                    }
                }
                
                if putsitem.contains("나누기"){
                    if !(putsitem.contains("(")) || !(putsitem.contains(")")){
                        if !self.EA.errorArray.contains("사칙연산에는 괄호가 필요합니다."){
                            self.EA.errorArray.append("사칙연산에는 괄호가 필요합니다.")
                        }
                        self.show.error = true
                        check1 = true
                        return []
                        
                    }else{
                        putsitem = div(text: putsitem, line: i + 1)
                    }
                }
                if putsitem.contains("나머지"){
                    if !(putsitem.contains("(")) || !(putsitem.contains(")")){
                        if !self.EA.errorArray.contains("사칙연산에는 괄호가 필요합니다."){
                            self.EA.errorArray.append("사칙연산에는 괄호가 필요합니다.")
                        }
                        self.show.error = true
                        check1 = true
                        return []

                    }else{
                        putsitem = mod(text: putsitem, line: i + 1)
                    }
                }
                
                if !self.show.error{
                    
                    if (self.valueCV.varI.contains(vari(text: putsitem)[0])) || (self.valueCV.const.contains(vari(text: putsitem)[0])){
                        self.EA.errorArray.append("두 개 이상의 값이 같은 이름으로 정의되었습니다6.")
                        self.show.error = true
                        
                    }else{
                        
                        
                        self.valueCV.varI.append(contentsOf: vari(text: putsitem))
                        self.valueCV.varIR.append(contentsOf: varir(text: putsitem))
                    }
                    
                }
            }
            
            if (indexX[i].contains("-")){
                if indexX[i].contains("--"){
                    if !self.EA.errorArray.contains("-를 두번 사용하여 값을 호출하는 것이 불가능합니다."){
                        self.EA.errorArray.append("-를 두번 사용하여 값을 호출하는 것이 불가능합니다.")
                    }
                }
                
                if indexX[i].contains(self.input.inputArray){
                    indexX[i] = indexX[i].replacingOccurrences(of: "-" + self.input.inputArray, with: self.input.inputResult)
                
                    
                   
                
                   
                
            }
                
                while i2 != self.valueCV.const.count{
                    
                   
                        
                    if indexX[i].contains("-" + self.valueCV.const[i2]){
                            
                        indexX[i] = indexX[i].replacingOccurrences(of: "-" + self.valueCV.const[i2], with: self.valueCV.constR[i2])
                            
                        }else{
                            
                            self.valueCV.errorcatchforConst = self.valueCV.errorcatchforConst + 1

                        
                    }
                    
                    
                    
                    i2 = i2 + 1
                }
                var i3 = 0
                
                while i3 != self.valueCV.varI.count {
                    
                    if indexX[i].contains("-"){
                        
                        if indexX[i].contains("-" + self.valueCV.varI[i3]){
                            
                            indexX[i] = indexX[i].replacingOccurrences(of: "-" + self.valueCV.varI[i3], with: self.valueCV.varIR[i3])
                            
                        }else{
                            self.valueCV.errorcatchforVar = self.valueCV.errorcatchforVar + 1

                            
                        }
                    }
                    i3 = i3 + 1
                }
                
                
                
                
                
                
                
                
                
                
            }
            
           
            
            
            
            var s1 = 0
            var s2 = 0
            
            if indexX[i].contains("바꾼다"){
                
                var putsitem = indexX[i]
                
                if putsitem.contains("더하기"){
                    if !(putsitem.contains("(")) && !(putsitem.contains(")")){
                        self.EA.errorArray.append("사칙연산에는 괄호가 필요합니다.")
                        self.show.error = true
                    }else{
                        putsitem = plus(text: putsitem, line: i + 1)
                    }
                    
                }
                
                
                if putsitem.contains("빼기"){
                    if !(putsitem.contains("(")) && !(putsitem.contains(")")){
                        self.EA.errorArray.append("사칙연산에는 괄호가 필요합니다.")
                        self.show.error = true
                    }else{
                        putsitem = sub(text: putsitem, line: i + 1)
                    }
                }
                
                if putsitem.contains("곱하기"){
                    if !(putsitem.contains("(")) && !(putsitem.contains(")")){
                        self.EA.errorArray.append("사칙연산에는 괄호가 필요합니다.")
                        self.show.error = true
                    }else{
                        putsitem = mul(text: putsitem, line: i + 1)
                    }
                }
                
                if putsitem.contains("나누기"){
                    if !(putsitem.contains("(")) && !(putsitem.contains(")")){
                        self.EA.errorArray.append("사칙연산에는 괄호가 필요합니다.")
                        self.show.error = true
                    }else{
                        putsitem = div(text: putsitem, line: i + 1)
                    }
                }
                if putsitem.contains("나머지"){
                    if !(putsitem.contains("(")) && !(putsitem.contains(")")){
                        self.EA.errorArray.append("사칙연산에는 괄호가 필요합니다.")
                        self.show.error = true
                    }else{
                        putsitem = mod(text: putsitem, line: i + 1)
                    }
                }
                
                if ((putsitem.contains("를")) || (putsitem.contains("을"))) && ((putsitem.contains("로")) || (putsitem.contains("으로"))){
                    
                    
                    
                    
                    
                    if let range = putsitem.range(of: "를"){
                        s1 = putsitem.distance(from: putsitem.startIndex, to: range.lowerBound)
                    }
                    
                    if let range = putsitem.range(of: "을"){
                        s1 = putsitem.distance(from: putsitem.startIndex, to: range.lowerBound)
                    }
                    
                    if let range = putsitem.range(of: "로"){
                        s2 = putsitem.distance(from: putsitem.startIndex, to: range.lowerBound)
                    }
                    
                    if let range = putsitem.range(of: "으로"){
                        s2 = putsitem.distance(from: putsitem.startIndex, to: range.lowerBound)
                    }
                    
                    
                    let textindex1 = putsitem.index(putsitem.startIndex, offsetBy: s1 - 1)
                    let textindex2 = putsitem.index(putsitem.startIndex, offsetBy: s1 + 2)
                    let textindex3 = putsitem.index(putsitem.startIndex, offsetBy: s2 - 1)
                    
                    let const1 = String(putsitem[putsitem.startIndex...textindex1]).replacingOccurrences(of: "->", with: "")
                    let constR1 = String(putsitem[textindex2...textindex3])
                    
                    
                    if let a = self.valueCV.varI.firstIndex(of: const1){
                        
                        self.valueCV.varIR[a] = constR1
                    } else{
                        if !(self.EA.errorArray.contains("상수의 값을 바꾸려고 했거나, 정의하지 않은 값에 접근했습니다.")){
                            self.EA.errorArray.append("상수의 값을 바꾸려고 했거나, 정의하지 않은 값에 접근했습니다.")
                        }
                        self.show.error = true

                        
                        
                    }
                }else{
                    self.EA.errorArray.append("변수의 값을 바꾸는 코드에서 문법을 지키지 않았습니다.")
                    self.show.error = true
                }
            }
            
            
            
            
            
            
            if indexX[i].contains("빼기"){
                if !(indexX[i].contains("(")) && !(indexX[i].contains(")")){
                    self.EA.errorArray.append("사칙연산에는 괄호가 필요합니다.")
                    self.show.error = true
                }else{
                    indexX[i] = sub(text: indexX[i], line: i + 1)
                }
            }
            if indexX[i].contains("더하기"){
                if !(indexX[i].contains("(")) && !(indexX[i].contains(")")){
                    self.EA.errorArray.append("사칙연산에는 괄호가 필요합니다.")
                    self.show.error = true
                }else{
                    indexX[i] = plus(text: indexX[i], line: i + 1)
                }
            }
            
            if indexX[i].contains("곱하기"){
                if !(indexX[i].contains("(")) && !(indexX[i].contains(")")){
                    self.EA.errorArray.append("사칙연산에는 괄호가 필요합니다.")
                    self.show.error = true
                }else{
                    indexX[i] = mul(text: indexX[i], line: i + 1)
                }
            }
            if indexX[i].contains("나누기"){
                if !(indexX[i].contains("(")) && !(indexX[i].contains(")")){
                    self.EA.errorArray.append("사칙연산에는 괄호가 필요합니다.")
                    self.show.error = true
                }else{
                    indexX[i] = div(text: indexX[i], line: i + 1)
                }
            }
            
            
            if indexX[i].contains("나머지"){
                if !(indexX[i].contains("(")) && !(indexX[i].contains(")")){
                    self.EA.errorArray.append("사칙연산에는 괄호가 필요합니다.")
                    self.show.error = true
                }else{
                    indexX[i] = mod(text: indexX[i], line: i + 1)
                }
            }
            
            
            
            if indexX[i].contains("미분"){
                indexX[i] = mathD(text: indexX[i])
            }
            
            
            
            indexX[i] = indexX[i].replacingOccurrences(of: "\\줄", with: "\n")
            
            
            
            
            
            
           
            
                
                
                if let range = indexX[i].range(of: "실행한다"){
                    indexX[i] = indexX[i].replacingOccurrences(of: "실행한다", with: "")
                    
                    let S = indexX[i].distance(from: indexX[i].startIndex, to: range.lowerBound)
                    let textindex = indexX[i].index(indexX[i].startIndex, offsetBy: S-3)
                    indexX[i] = String(indexX[i][indexX[i].startIndex...textindex])
                    
                    
                    
                    
                }
                
                
            

            
            
            
            
            
            
            
            i = i + 1
        }
        
        
        
        
        
        
        return indexX
        
        
    }
    
    
    func FPforFD(text: String) -> String{
        
        var indexX = [String]()
        var const = [String]()
        var constR = [String]()
        var varI = [String]()
        var varIR = [String]()
        var i = 0
        var Newtext = text
        var errorcatchforConst = 0
        var errorcatchforVar = 0
        var check1  : Bool = false
        
        @EnvironmentObject var index : indexFR
        @EnvironmentObject var show : Show
        
        
        
        
        indexX.removeAll()
        constR.removeAll()
        const.removeAll()
        varI.removeAll()
        varIR.removeAll()
        
        
        
        
        
        if Newtext.contains("만약"){
            
            Newtext = ifcompile(text: Newtext)
        }
        
        
        
        
        
        indexX = Newtext.components(separatedBy: ".")
        
        
        
        
        
        while indexX.count != i + 1 {
            
            indexX[i] = indexX[i].replacingOccurrences(of: "\n", with: "")
            
            var k = 0
            
            
            while k != indexfr.indexF.count {
                
                if indexX[i].contains(indexfr.indexF[k] + "()") {
                    indexX[i] = indexX[i].replacingOccurrences(of: indexfr.indexF[k] + "()", with: FPforFD(text: indexfr.indexFC[k]))
                    print("성공")
                }
                
                k = k + 1
            }
            
            
            if (indexX[i].contains("이다")) && (!(indexX[i].contains("단")) && !(indexX[i].contains("자"))) {
                if !self.EA.errorArray.contains("상수 혹은 변수를 정의하려면 각각 '단' 혹은 '자'를 사용해야합니다. 값을 바꾸려면 바꾼다 방식으로 바꿀 수 있습니다."){
                    self.EA.errorArray.append("상수 혹은 변수를 정의하려면 각각 '단' 혹은 '자'를 사용해야합니다. 값을 바꾸려면 바꾼다 방식으로 바꿀 수 있습니다.")
                }
                self.show.error = true

            }
            
            
            if (vari(text: indexX[i]).contains("--")) || (variX(text: indexX[i]).contains("--")) {
                if !self.EA.errorArray.contains("--을 사용할 수 없습니다."){
                    self.EA.errorArray.append("--을 사용할 수 없습니다.")
                    
                }
                self.show.error = true
            }
            
           
            
            var i2 = 0
            
            if indexX[i].contains("단"){
                
                var putsitem = indexX[i]
                
                
                
                
                
                if putsitem.contains("더하기"){
                    if !(putsitem.contains("(")) || !(putsitem.contains(")")){
                        if !self.EA.errorArray.contains("사칙연산에는 괄호가 필요합니다."){
                            self.EA.errorArray.append("사칙연산에는 괄호가 필요합니다.")
                        }
                        self.show.error = true
                        check1 = true
                        
                    }else{
                        putsitem = plus(text: putsitem, line: i + 1)
                    }
                    
                }
                
                
                if putsitem.contains("빼기"){
                    if !(putsitem.contains("(")) || !(putsitem.contains(")")){
                        if !self.EA.errorArray.contains("사칙연산에는 괄호가 필요합니다."){
                            self.EA.errorArray.append("사칙연산에는 괄호가 필요합니다.")
                        }
                        self.show.error = true
                        check1 = true
                        
                    }else{
                        putsitem = sub(text: putsitem, line: i + 1)
                    }
                }
                
                if putsitem.contains("곱하기"){
                    if !(putsitem.contains("(")) || !(putsitem.contains(")")){
                        if !self.EA.errorArray.contains("사칙연산에는 괄호가 필요합니다."){
                            self.EA.errorArray.append("사칙연산에는 괄호가 필요합니다.")
                        }
                        self.show.error = true
                        check1 = true
                        
                    }else{
                        putsitem = mul(text: putsitem, line: i + 1)
                    }
                }
                
                if putsitem.contains("나누기"){
                    if !(putsitem.contains("(")) || !(putsitem.contains(")")){
                        if !self.EA.errorArray.contains("사칙연산에는 괄호가 필요합니다."){
                            self.EA.errorArray.append("사칙연산에는 괄호가 필요합니다.")
                        }
                        self.show.error = true
                        check1 = true
                        
                    }else{
                        putsitem = div(text: putsitem, line: i + 1)
                    }
                }
                if putsitem.contains("나머지"){
                    if !(putsitem.contains("(")) || !(putsitem.contains(")")){
                        if !self.EA.errorArray.contains("사칙연산에는 괄호가 필요합니다."){
                            self.EA.errorArray.append("사칙연산에는 괄호가 필요합니다.")
                        }
                        self.show.error = true
                        check1 = true

                    }else{
                        putsitem = mod(text: putsitem, line: i + 1)
                    }
                }
                
                if !self.show.error{
                    
                    if (varI.contains(variX(text: putsitem)[0])) || (const.contains(variX(text: putsitem)[0])){
                        self.EA.errorArray.append("두 개 이상의 값이 같은 이름으로 정의되었습니다1.")
                        self.show.error = true
                        
                    }else{
                        
                        
                        const.append(contentsOf: vari(text: putsitem))
                        constR.append(contentsOf: varir(text: putsitem))
                    }
                    
                }
            }
            
            if indexX[i].contains("자"){
                
                var putsitem = indexX[i]
                
                
                
                if putsitem.contains("더하기"){
                    if !(putsitem.contains("(")) || !(putsitem.contains(")")){
                        if !self.EA.errorArray.contains("사칙연산에는 괄호가 필요합니다."){
                            self.EA.errorArray.append("사칙연산에는 괄호가 필요합니다.")
                        }
                        self.show.error = true
                        check1 = true
                    }else{
                        putsitem = plus(text: putsitem, line: i + 1)
                    }
                    
                }
                
                
                if putsitem.contains("빼기"){
                    if !(putsitem.contains("(")) || !(putsitem.contains(")")){
                        if !self.EA.errorArray.contains("사칙연산에는 괄호가 필요합니다."){
                            self.EA.errorArray.append("사칙연산에는 괄호가 필요합니다.")
                        }
                        self.show.error = true
                        check1 = true
                        
                    }else{
                        putsitem = sub(text: putsitem, line: i + 1)
                    }
                }
                
                if putsitem.contains("곱하기"){
                    if !(putsitem.contains("(")) || !(putsitem.contains(")")){
                        if !self.EA.errorArray.contains("사칙연산에는 괄호가 필요합니다."){
                            self.EA.errorArray.append("사칙연산에는 괄호가 필요합니다.")
                        }
                        self.show.error = true
                        check1 = true
                        
                    }else{
                        putsitem = mul(text: putsitem, line: i + 1)
                    }
                }
                
                if putsitem.contains("나누기"){
                    if !(putsitem.contains("(")) || !(putsitem.contains(")")){
                        if !self.EA.errorArray.contains("사칙연산에는 괄호가 필요합니다."){
                            self.EA.errorArray.append("사칙연산에는 괄호가 필요합니다.")
                        }
                        self.show.error = true
                        check1 = true
                        
                    }else{
                        putsitem = div(text: putsitem, line: i + 1)
                    }
                }
                if putsitem.contains("나머지"){
                    if !(putsitem.contains("(")) || !(putsitem.contains(")")){
                        if !self.EA.errorArray.contains("사칙연산에는 괄호가 필요합니다."){
                            self.EA.errorArray.append("사칙연산에는 괄호가 필요합니다.")
                        }
                        self.show.error = true
                        check1 = true

                    }else{
                        putsitem = mod(text: putsitem, line: i + 1)
                    }
                }
                
                if !self.show.error{
                    
                    if (varI.contains(vari(text: putsitem)[0])) || (const.contains(vari(text: putsitem)[0])){
                        self.EA.errorArray.append("두 개 이상의 값이 같은 이름으로 정의되었습니다2.")
                        self.show.error = true
                        
                    }else{
                        
                        
                        varI.append(contentsOf: vari(text: putsitem))
                        varIR.append(contentsOf: varir(text: putsitem))
                    }
                    
                }
            }
            
            if indexX[i].contains("-"){
                if indexX[i].contains("--"){
                    if !self.EA.errorArray.contains("-를 두번 사용하여 값을 호출하는 것이 불가능합니다."){
                        self.EA.errorArray.append("-를 두번 사용하여 값을 호출하는 것이 불가능합니다.")
                    }
                }
                else{
                    
                }
                
                while i2 != const.count{
                    
                    if indexX[i].contains("-"){
                        
                        if indexX[i].contains("-" + const[i2]){
                            
                            indexX[i] = indexX[i].replacingOccurrences(of: "-" + const[i2], with: constR[i2])
                            self.valueCV.errorcatchforConst = self.valueCV.errorcatchforConst + 1
                            
                        }else{
                            
                            
                        }
                    }
                    
                    
                    
                    i2 = i2 + 1
                }
                
                
                var i3 = 0
                
                while i3 != varI.count {
                    
                    if indexX[i].contains("-"){
                        
                        if indexX[i].contains("-" + varI[i3]){
                            
                            indexX[i] = indexX[i].replacingOccurrences(of: "-" + varI[i3], with: varIR[i3])
                            self.valueCV.errorcatchforVar = self.valueCV.errorcatchforVar + 1
                            
                        }else{
                          
                            
                        }
                    }
                    i3 = i3 + 1
                }
                
                if indexX[i].contains("-" + input.inputArray){
                    indexX[i] = indexX[i].replacingOccurrences(of: "-" + input.inputArray, with: input.inputResult)
                }
                
            }
            
           
            
            
            
            var s1 = 0
            var s2 = 0
            
            if indexX[i].contains("바꾼다"){
                
                var putsitem = indexX[i]
                
                if putsitem.contains("더하기"){
                    if !(putsitem.contains("(")) && !(putsitem.contains(")")){
                        self.EA.errorArray.append("사칙연산에는 괄호가 필요합니다.")
                        self.show.error = true
                    }else{
                        putsitem = plus(text: putsitem, line: i + 1)
                    }
                    
                }
                
                
                if putsitem.contains("빼기"){
                    if !(putsitem.contains("(")) && !(putsitem.contains(")")){
                        self.EA.errorArray.append("사칙연산에는 괄호가 필요합니다.")
                        self.show.error = true
                    }else{
                        putsitem = sub(text: putsitem, line: i + 1)
                    }
                }
                
                if putsitem.contains("곱하기"){
                    if !(putsitem.contains("(")) && !(putsitem.contains(")")){
                        self.EA.errorArray.append("사칙연산에는 괄호가 필요합니다.")
                        self.show.error = true
                    }else{
                        putsitem = mul(text: putsitem, line: i + 1)
                    }
                }
                
                if putsitem.contains("나누기"){
                    if !(putsitem.contains("(")) && !(putsitem.contains(")")){
                        self.EA.errorArray.append("사칙연산에는 괄호가 필요합니다.")
                        self.show.error = true
                    }else{
                        putsitem = div(text: putsitem, line: i + 1)
                    }
                }
                if putsitem.contains("나머지"){
                    if !(putsitem.contains("(")) && !(putsitem.contains(")")){
                        self.EA.errorArray.append("사칙연산에는 괄호가 필요합니다.")
                        self.show.error = true
                    }else{
                        putsitem = mod(text: putsitem, line: i + 1)
                    }
                }
                
                if ((putsitem.contains("를")) || (putsitem.contains("을"))) && ((putsitem.contains("로")) || (putsitem.contains("으로"))){
                    
                    
                    
                    
                    
                    if let range = putsitem.range(of: "를"){
                        s1 = putsitem.distance(from: putsitem.startIndex, to: range.lowerBound)
                    }
                    
                    if let range = putsitem.range(of: "을"){
                        s1 = putsitem.distance(from: putsitem.startIndex, to: range.lowerBound)
                    }
                    
                    if let range = putsitem.range(of: "로"){
                        s2 = putsitem.distance(from: putsitem.startIndex, to: range.lowerBound)
                    }
                    
                    if let range = putsitem.range(of: "으로"){
                        s2 = putsitem.distance(from: putsitem.startIndex, to: range.lowerBound)
                    }
                    
                    
                    let textindex1 = putsitem.index(putsitem.startIndex, offsetBy: s1 - 1)
                    let textindex2 = putsitem.index(putsitem.startIndex, offsetBy: s1 + 2)
                    let textindex3 = putsitem.index(putsitem.startIndex, offsetBy: s2 - 1)
                    
                    let const1 = String(putsitem[putsitem.startIndex...textindex1])
                    let constR1 = String(putsitem[textindex2...textindex3])
                    
                    if let a = varI.firstIndex(of: const1){
                        
                        varIR[a] = constR1
                    } else{
                        if !(self.EA.errorArray.contains("상수의 값을 바꾸려는 시도가 있습니다2.")){
                            self.EA.errorArray.append("상수의 값을 바꾸려는 시도가 있습니다2.")
                            

                        }
                        self.show.error = true

                        
                    }
                }else{
                    self.EA.errorArray.append("변수의 값을 바꾸는 코드에서 문법을 지키지 않았습니다.")
                    self.show.error = true
                }
            }
            
            
            
            
            
            
            if indexX[i].contains("빼기"){
                if !(indexX[i].contains("(")) && !(indexX[i].contains(")")){
                    self.EA.errorArray.append("사칙연산에는 괄호가 필요합니다.")
                    self.show.error = true
                }else{
                    indexX[i] = sub(text: indexX[i], line: i + 1)
                }
            }
            if indexX[i].contains("더하기"){
                if !(indexX[i].contains("(")) && !(indexX[i].contains(")")){
                    self.EA.errorArray.append("사칙연산에는 괄호가 필요합니다.")
                    self.show.error = true
                }else{
                    indexX[i] = plus(text: indexX[i], line: i + 1)
                }
            }
            
            if indexX[i].contains("곱하기"){
                if !(indexX[i].contains("(")) && !(indexX[i].contains(")")){
                    self.EA.errorArray.append("사칙연산에는 괄호가 필요합니다.")
                    self.show.error = true
                }else{
                    indexX[i] = mul(text: indexX[i], line: i + 1)
                }
            }
            if indexX[i].contains("나누기"){
                if !(indexX[i].contains("(")) && !(indexX[i].contains(")")){
                    self.EA.errorArray.append("사칙연산에는 괄호가 필요합니다.")
                    self.show.error = true
                }else{
                    indexX[i] = div(text: indexX[i], line: i + 1)
                }
            }
            
            
            if indexX[i].contains("나머지"){
                if !(indexX[i].contains("(")) && !(indexX[i].contains(")")){
                    self.EA.errorArray.append("사칙연산에는 괄호가 필요합니다.")
                    self.show.error = true
                }else{
                    indexX[i] = mod(text: indexX[i], line: i + 1)
                }
            }
            
            
            
            if indexX[i].contains("미분"){
                indexX[i] = mathD(text: indexX[i])
            }
            
            
            
            indexX[i] = indexX[i].replacingOccurrences(of: "\\줄", with: "\n")
            
            
            
            
            
            
            if let range = indexX[i].range(of: "출력한다"){
                if !(indexX[i].contains("을")) && !(indexX[i].contains("를")){
                    if !self.EA.errorArray.contains("출력할 때 조사를 입력해야합니다."){
                        self.EA.errorArray.append("출력할 때 조사를 입력해야합니다.")
                    }
                    self.show.error = true
                }else{
                    
                    indexX[i] = indexX[i].replacingOccurrences(of: "출력한다", with: "")
                    
                    
                    let S = indexX[i].distance(from: indexX[i].startIndex, to: range.lowerBound)
                    
                    if (indexX[i].last != " ") || (indexX[i].last != " "){
                        if !self.EA.errorArray.contains("출력하는 코드 중 띄어쓰기가 잘못된 코드가 있습니다."){
                            self.EA.errorArray.append("출력하는 코드 중 띄어쓰기가 잘못된 코드가 있습니다.")
                        }
                        self.show.error = true
                    }else{
                        let textindex = indexX[i].index(indexX[i].startIndex, offsetBy: S-3)
                        indexX[i] = String(indexX[i][indexX[i].startIndex...textindex])
                    }
                    
                }
            }
            
            else {
                
                
                if let range = indexX[i].range(of: "실행한다"){
                    indexX[i] = indexX[i].replacingOccurrences(of: "실행한다", with: "")
                    
                    let S = indexX[i].distance(from: indexX[i].startIndex, to: range.lowerBound)
                    let textindex = indexX[i].index(indexX[i].startIndex, offsetBy: S-3)
                    indexX[i] = String(indexX[i][indexX[i].startIndex...textindex])
                    
                    
                    
                    
                }else{
                    indexX[i] = ""
                }
                
                
                
            }
            
            
            
            
            
            
            
            
            i = i + 1
        }
        
        
        
        
        
        
        return indexX.joined(separator: "")
        
        
    }
    
    
    
    
    
    
    
    
  
    
    
    class ErrorList : ObservableObject{
        @Published var errorArray = [String]()
        
        
        
    }
    
    
    
    
    
    
    
    
    
    class Show : ObservableObject{
        @Published var error : Bool = false
        
    }
    
    
    
    
    
    
    
    class Input : ObservableObject{
        @Published var input : Bool = false
        @Published var inputString : String = ""
        @Published var inputArray : String = "*ㅕ*&*ㅇㄹ*ㅇ*&*&*"
        @Published var inputResult : String = "ㅇ(ㄹ*야ㅕ랴ㅒ로ㅓㅣ나"
    }
    
    
    
    struct FuncDeclare : View {
        
        @Environment(\.managedObjectContext) private var viewContext
        
        @FetchRequest(entity: Dfunc.entity(), sortDescriptors: [])
        var FD : FetchedResults<Dfunc>
        
        
        
        
        @State var add : Bool = false
        @State var name = ""
        @State var explain = ""
        @State var nameAE = ""
        @State var explainAE = ""
        @State var SaveFD = []
        @State var funcContext = ""
        @State var funcResult = ""
        
        var content : ContentView = ContentView(show: ContentView.Show(),input : ContentView.Input(), indexfr: ContentView.indexFR(),  EA: ContentView.ErrorList(), valueCV: ContentView.Value())
        
        private let rules: [HighlightRule] = [
            HighlightRule(pattern: betweenUnderscores, formattingRules: [
                TextFormattingRule(fontTraits: [.traitBold]),
                TextFormattingRule(key: .foregroundColor, value: UIColor.orange),
                
            ]),
            
            HighlightRule(pattern: betweenUnderscores2, formattingRules: [
                TextFormattingRule(fontTraits: [.traitItalic, .traitBold]),
                TextFormattingRule(key: .foregroundColor, value: UIColor.systemPurple),
                
            ]),
            
            HighlightRule(pattern: betweenUnderscores3, formattingRules: [
                TextFormattingRule(fontTraits: [.traitItalic, .traitBold]),
                TextFormattingRule(key: .foregroundColor, value: UIColor.systemPurple),
                
            ]),
            
            HighlightRule(pattern: betweenUnderscores4, formattingRules: [
                TextFormattingRule(fontTraits: [.traitItalic, .traitBold]),
                TextFormattingRule(key: .foregroundColor, value: UIColor.systemPurple),
                
            ]),
            
            
            HighlightRule(pattern: betweenUnderscores5, formattingRules: [
                TextFormattingRule(fontTraits: [.traitItalic, .traitBold]),
                TextFormattingRule(key: .foregroundColor, value: UIColor.systemPurple),
                
            ]),
            
            HighlightRule(pattern: betweenUnderscores6, formattingRules: [
                TextFormattingRule(fontTraits: [.traitItalic, .traitBold]),
                TextFormattingRule(key: .foregroundColor, value: UIColor.systemCyan),
                
            ]),
            
            HighlightRule(pattern: betweenUnderscores7, formattingRules: [
                TextFormattingRule(fontTraits: [.traitItalic, .traitBold]),
                TextFormattingRule(key: .foregroundColor, value: UIColor.systemCyan),
                
            ]),
            
            HighlightRule(pattern: betweenUnderscores8, formattingRules: [
                TextFormattingRule(fontTraits: [.traitItalic, .traitBold]),
                TextFormattingRule(key: .foregroundColor, value: UIColor(Color("단"))),
                
            ]),
            HighlightRule(pattern: betweenUnderscores9, formattingRules: [
                TextFormattingRule(fontTraits: [.traitItalic, .traitBold]),
                TextFormattingRule(key: .foregroundColor, value: UIColor.green),
                
            ]),
            HighlightRule(pattern: betweenUnderscores10, formattingRules: [
                TextFormattingRule(fontTraits: [.traitItalic, .traitBold]),
                TextFormattingRule(key: .foregroundColor, value: UIColor(Color("단"))),
                
            ]),
            
            HighlightRule(pattern: betweenUnderscores11, formattingRules: [
                TextFormattingRule(fontTraits: [.traitItalic, .traitBold]),
                TextFormattingRule(key: .foregroundColor, value: UIColor(Color("바꾸자"))),
                
            ]),
            
            HighlightRule(pattern: betweenUnderscores12, formattingRules: [
                TextFormattingRule(fontTraits: [.traitItalic, .traitBold]),
                TextFormattingRule(key: .foregroundColor, value: UIColor(Color("바꾸자"))),
                
            ]),
            HighlightRule(pattern: betweenUnderscores13, formattingRules: [
                TextFormattingRule(fontTraits: [.traitItalic, .traitBold]),
                TextFormattingRule(key: .foregroundColor, value: UIColor(Color("바꾸자"))),
                
            ]),
            
            HighlightRule(pattern: betweenUnderscores14, formattingRules: [
                TextFormattingRule(fontTraits: [.traitItalic, .traitBold]),
                TextFormattingRule(key: .foregroundColor, value: UIColor(Color("와과"))),
                
            ]),
            
            HighlightRule(pattern: betweenUnderscores15, formattingRules: [
                TextFormattingRule(fontTraits: [.traitItalic, .traitBold]),
                TextFormattingRule(key: .foregroundColor, value: UIColor(Color("미분"))),
                
            ])
            
            
            
            
            
            
        ]
        
        
        var body: some View{
            
            
            
            NavigationView {
                
                List{
                    
                    ForEach(FD, id: \.id) {FD in
                        
                        NavigationLink{
                            
                            VStack{
                                
                                HStack{
                                    Text(FD.name ?? "함수")
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .offset(y : -37)
                                    
                                    
                                    Spacer()
                                }
                                .padding()
                                
                                HighlightedTextEditor(text: $funcContext, highlightRules: rules)
                                    .onCommit { print("commited") }
                                    .onEditingChanged { print("editing changed") }
                                    .onTextChange { print("latest text value", $0) }
                                    .onSelectionChange { (range: NSRange) in
                                        print(range)
                                        
                                    }
                                    .introspect { editor in
                                        // access underlying UITextView or NSTextView
                                        editor.textView
                                            .backgroundColor = UIColor(Color("TextField"))
                                        
                                    }
                                    .cornerRadius(10)
                                    .ignoresSafeArea(.keyboard)
                                    .padding()
                                    .offset(y : -50)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .onAppear{
                                        self.funcContext = FD.fc ?? ""
                                        
                                        
                                    }
                                    .onDisappear{
                                        FD.fc  = self.funcContext
                                        
                                        
                                        
                                        
                                        
                                        var i = 0
                                        
                                        let full = self.content.finishpoint(text: self.funcContext).count
                                        
                                        
                                        if full == 0{
                                            if self.content.finishpoint(text: self.funcContext) != [] {
                                                self.funcResult = self.content.finishpoint(text: self.funcContext)[0]
                                                
                                                
                                                while i != full{
                                                    self.funcResult = self.funcResult + self.content.finishpoint(text: self.funcContext)[i]
                                                    
                                                    i += 1
                                                }
                                            }
                                        }
                                        
                                        
                                        
                                        FD.fr = self.funcResult
                                        
                                        
                                        
                                        
                                        try? self.viewContext.save()
                                    }
                                
                            }
                            
                            
                            
                            
                        } label: {
                            VStack(alignment: .leading){
                                Text(FD.name ?? "이름 없음")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                
                                Text(FD.explain ?? "설명 없음")
                                    .fontWeight(.ultraLight)
                                    .foregroundColor(.white)
                            }
                        }
                        
                        
                    }
                    .onDelete(perform: deleteItems)
                    
                }
                .navigationTitle("함수 리스트")
                .toolbar {
                    
                    
                    ToolbarItem {
                        
                        Button {
                            
                            add = true
                            
                        } label: {
                            
                            Image(systemName: "square.and.pencil")
                                .foregroundColor(.white)
                        }
                        .alert("함수 정의", isPresented: $add) {
                            
                            VStack{
                                
                                TextField("함수 이름",text: $name)
                                    .foregroundColor(Color("Text"))
                                TextField("함수 설명",text: $explain)
                                    .foregroundColor(Color("Text"))
                                
                            }
                            
                            VStack{
                                
                                Button {
                                    addItem()
                                    
                                    
                                    
                                    
                                    
                                    
                                } label: {
                                    Text("함수 추가")
                                }
                                
                                
                                Button("취소", role: .cancel){}
                                
                            }
                                
                            
                        }
                        
                        
                    }
                    
                }
                
                
            }
            .accentColor(.white)
            
        }
        private func saveItems() {
            do {
                try viewContext.save()
            }
            catch{
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
        
        
        private func addItem() {
            withAnimation {
                let newItem = Dfunc(context: viewContext)
                newItem.id = UUID()
                newItem.name = self.name
                newItem.explain = self.explain
                
                saveItems()
                
                do {
                    try viewContext.save()
                } catch {
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            }
        }
        
        private func deleteItems(offsets: IndexSet) {
            withAnimation {
                offsets.map { FD[$0] }.forEach(viewContext.delete)
                
                do {
                    try viewContext.save()
                } catch {
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            }
        }
        
        
        
    }
    
    
    
    func whiilecompile(text : String) -> String{
        
        var block = 0
        
        var st = ""
        var stAy = [String]()
        var syAyr = [String]()
        var coAy = [String]()
        var stMay = [String]()
        var re = text.replacingOccurrences(of: ",", with: ".")
        let indexX = re.components(separatedBy: ".")
        var stF = ""
        var condition = ""
        var pre = [String]()
        var k = 0
        var s = 0
       
        
        while block != indexX.count{
            if indexX[block].contains("동안"){
                coAy.append(indexX[block])
                st = indexX[block+1].replacingOccurrences(of: "->", with: "")
                var r = 2
                while indexX[block + r].contains("->"){
                    st = st + "." + indexX[block + r].replacingOccurrences(of: "->", with: "") + "."
                    st = st.replacingOccurrences(of: "\n", with: "\n->")
                    
                    r = r + 1
                }
                
                stAy.append(st)
            }
            
            
            
            

        
            block = block + 1

            
          }
        
        while !indexX[s].contains("동안"){
            pre.append(indexX[s])
            s = s + 1
        }
        
        print(pre)
        print(self.input.inputArray)
        
        _ = FPforIF(text: pre.joined(separator: ".") + ".")
        
        
        
        while k != coAy.count {
            while whileConditionCheck(text: FPforIF(text: coAy[k] + ".")[0]){
                stMay.append(FPforIF(text: stAy[k]).joined(separator: "."))
            }
            
            syAyr.append(stMay.joined())
            stMay.removeAll()
            
            k = k + 1
        }
        
        
        var stTest = 0
        
        while stTest != stAy.count{
            re = re.replacingOccurrences(of: stAy[stTest], with: syAyr[stTest])
            
            stTest = stTest + 1
        }
        

        
        return re.replacingOccurrences(of: "->", with: "")
    }
    
    
    
    
    
    
    
    func whileConditionCheck(text : String) -> Bool{
        var s = 0
        var p = 0
        var q = 0
        var re : Bool = false
        
        
        if let range = text.range(of : "일 동안"){
            s = text.distance(from: text.startIndex, to: range.lowerBound) - 2
        }
        
        

        let condition2 = text.index(text.startIndex, offsetBy: s)
           
        let condition = String(text[text.startIndex...condition2])
        
        if condition.contains("="){
            
            
            
            if let range = condition.range(of: "="){
                p = condition.distance(from: condition.startIndex, to: range.lowerBound) - 2
                
                q = condition.distance(from: condition.startIndex, to: range.lowerBound) + 2
                
                let condition3 = condition.index(condition.startIndex, offsetBy: p)
                
                let condition4 = condition.index(condition.startIndex, offsetBy: q)
                
                let conditionC1 = String(condition[condition.startIndex...condition3])
                
                let conditionC2 = String(condition[condition4..<condition.endIndex])
                
                if conditionC1 == conditionC2{
                    
                    re = true
                    
                } else{
                    re = false
                }
            }
            
        }
        
        if condition.contains("!="){
            
            
            
            if let range = condition.range(of: "!="){
                p = condition.distance(from: condition.startIndex, to: range.lowerBound) - 2
                
                q = condition.distance(from: condition.startIndex, to: range.lowerBound) + 3
                
                let condition3 = condition.index(condition.startIndex, offsetBy: p)
                
                let condition4 = condition.index(condition.startIndex, offsetBy: q)
                
                let conditionC1 = String(condition[condition.startIndex...condition3])
                
                let conditionC2 = String(condition[condition4..<condition.endIndex])
                
                if conditionC1 == conditionC2{
                    
                    re = false
                    
                } else{
                    re = true
                }
            }
            
        }
        
        if condition.contains(">"){
            
            
            if let range = condition.range(of: ">"){
                p = condition.distance(from: condition.startIndex, to: range.lowerBound) - 2
                
                q = condition.distance(from: condition.startIndex, to: range.lowerBound) + 2
                
                let condition3 = condition.index(condition.startIndex, offsetBy: p)
                
                let condition4 = condition.index(condition.startIndex, offsetBy: q)
                
                let conditionC1 = String(condition[condition.startIndex...condition3])
                
                let conditionC2 = String(condition[condition4..<condition.endIndex])
                
                if Int(conditionC1) ?? 0 > Int(conditionC2) ?? 0{
                    
                    re = true
                    
                } else{
                    re = false
                }
            }
            
        }
        
        
        if condition.contains(">="){
            
            
            if let range = condition.range(of: ">="){
                p = condition.distance(from: condition.startIndex, to: range.lowerBound) - 2
                
                q = condition.distance(from: condition.startIndex, to: range.lowerBound) + 3
                
                let condition3 = condition.index(condition.startIndex, offsetBy: p)
                
                let condition4 = condition.index(condition.startIndex, offsetBy: q)
                
                let conditionC1 = String(condition[condition.startIndex...condition3])
                
                let conditionC2 = String(condition[condition4..<condition.endIndex])
                
                if Int(conditionC1) ?? 0 >= Int(conditionC2) ?? 0{
                    
                    re = true
                    
                } else{
                    re = false
                }
            }
            
        }
        
        if condition.contains("<"){
            
            
            
            
            if let range = condition.range(of: "<"){
                p = condition.distance(from: condition.startIndex, to: range.lowerBound) - 2
                
                q = condition.distance(from: condition.startIndex, to: range.lowerBound) + 2
                
                let condition3 = condition.index(condition.startIndex, offsetBy: p)
                
                let condition4 = condition.index(condition.startIndex, offsetBy: q)
                
                let conditionC1 = String(condition[condition.startIndex...condition3])
                
                let conditionC2 = String(condition[condition4..<condition.endIndex])
                
                if Int(conditionC1) ?? 0 < Int(conditionC2) ?? 0{
                    
                    re = true
                    
                } else{
                    re = false
                }
            }
            
            
        }
        
        
        if condition.contains("<="){
            
            
            
            
            if let range = condition.range(of: "<="){
                p = condition.distance(from: condition.startIndex, to: range.lowerBound) - 2
                
                q = condition.distance(from: condition.startIndex, to: range.lowerBound) + 3
                
                let condition3 = condition.index(condition.startIndex, offsetBy: p)
                
                let condition4 = condition.index(condition.startIndex, offsetBy: q)
                
                let conditionC1 = String(condition[condition.startIndex...condition3])
                
                let conditionC2 = String(condition[condition4..<condition.endIndex])
                
                if Int(conditionC1) ?? 0 <= Int(conditionC2) ?? 0{
                    
                    re = true
                    
                } else{
                    re = false
                }
            }
            
            
        }
        
        
        
        return re
    }
    
    func ifcompile(text : String)->String{
        
        var block = 0
        
        var st = ""
        var stAy = [String]()
        var re = FPforIF(text: text.replacingOccurrences(of: ",", with: ".")).joined(separator: ".")
        let indexX = re.components(separatedBy: ".")
        
        
        
        
        
        while block != indexX.count{
            if indexX[block].contains("만약"){
                
                st = indexX[block]
                
                
                var r = 1
                while indexX[block + r].contains("->"){
                    st = st + "." + indexX[block + r]
                    
                    r = r + 1
                }
                
                
                
                stAy.append(st)
                
            }
            
            block = block + 1
            
            
            
        }
        
        
        
        
        var stTest = 0
        while stTest != stAy.count{
            let indexstTest = stAy[stTest].components(separatedBy: ".")
            
            
            if indexstTest[0].contains("이면"){
                
                if ifRecognize(text: indexstTest[0]){
                    
                    var newindexstTest = indexstTest
                    
                    newindexstTest.remove(at: 0)
                    let replace = newindexstTest.joined(separator: ".")
                    
                    re = re.replacingOccurrences(of: stAy[stTest], with: replace)
                    
                    
                    
                }else{
                    re = re.replacingOccurrences(of: stAy[stTest], with: "")
                }
            }
            
            
            if indexstTest[0].contains("이 아니면"){
                if ifNotRecognize(text: indexstTest[0]){
                    
                    var newindexstTest2 = indexstTest
                    
                    newindexstTest2.remove(at: 0)
                    let replace = newindexstTest2.joined(separator: ".\n")
                    
                    re = re.replacingOccurrences(of: stAy[stTest], with: replace)
                    
                    
                    
                    
                }else{
                    re = re.replacingOccurrences(of: stAy[stTest], with: "")
                }
            }
            
            if indexstTest[0].contains("가 아니면"){
                if ifNotRecognize(text: indexstTest[0]){
                    
                    var newindexstTest2 = indexstTest
                    
                    newindexstTest2.remove(at: 0)
                    let replace = newindexstTest2.joined(separator: ".\n")
                    
                    re = re.replacingOccurrences(of: stAy[stTest], with: replace)
                    
                    
                    
                    
                }else{
                    re = re.replacingOccurrences(of: stAy[stTest], with: "")
                }
            }
            
            stTest += 1
            
        }
        
        
        
        
        
        
        
        
        return re.replacingOccurrences(of: "->", with: "")
    
    }
    
    
    
    
    
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView(show: Show(),input: Input() ,indexfr: ContentView.indexFR(), EA: ContentView.ErrorList(), valueCV: ContentView.Value())
            
            
        }
    }
    
    
}
