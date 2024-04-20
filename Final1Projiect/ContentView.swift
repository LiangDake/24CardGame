//
//  ContentView.swift
//  NewWidget
//
//  Created by 梁大可 on 2023/8/11.
//

import SwiftUI
import WidgetKit

import SwiftUI
import WidgetKit
struct ContentView:View{
    @State var Card1:String = "1"
    @State var Card2:String = "2"
    @State var Card3:String = "3"
    @State var Card4:String = "4"
    @State var Card5:String = "5"
    @State var Card6:String = "6"
    @State var Card7:String = "7"
    @State var Card8:String = "8"
    @State var Card9:String = "9"
    @State var Card10:String = "10"
    @State var Card11:String = "11"
    @State var Card12:String = "12"
    @State var Card13:String = "13"
    @State var TCard1:String = ""
    @State var TCard2:String = ""
    @State var TCard3:String = ""
    @State var TCard4:String = ""
    
    @State var userInput = ""
    @State var result = ""
    
    @AppStorage("All Count") var totalCount = 0
    @State var account:Int = 0
    
    @State private var showingAlert = false
    @State var answer:String = "1*2*3*4"
    
    @State var countTimer = 0
    @State var difficulty = 0
    @Binding var chosenDifficulty: Int
    @State var timeRunning = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State private var showingListView = false
    @State private var showingStartView = false
    
    let operators = ["add", "division", "multiplication"]
    
    var body: some View{
        NavigationView{
            ZStack{
                LinearGradient(gradient: Gradient(colors: [.yellow, .white]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
                VStack(spacing: -200){
                    HStack{
                        VStack{
                            Button(action: {
                                userInput = ""
                                Refresh()
                                }){
                                Image(systemName: "arrow.clockwise.circle")
                                    .font(.system(size: 40))
                                    .foregroundColor(.brown)
                            }
                            Text("刷新").font(.subheadline)
                            Spacer(minLength: 50)
                            Button(action: {
                                self.showingAlert = true
                                @State var c1:Int = (Int(TCard1) ?? 1)
                                @State var c2:Int = (Int(TCard2) ?? 1)
                                @State var c3:Int = (Int(TCard3) ?? 1)
                                @State var c4:Int = (Int(TCard4) ?? 1)
                                @State var checkin :Int = Calculate(a: c1, b: c2, c: c3, d: c4)
                                Question(a: checkin)
                            }){
                                Image(systemName: "questionmark.circle")
                                    .font(.system(size:40))
                                    .foregroundColor(.brown)
                            }.alert(isPresented: $showingAlert)
                            {
                                Alert(title:Text("答案\n\(answer)")
                                )
                            }
                            Text("答案").font(.subheadline)
                            Spacer(minLength: 300)
                        }
                        .frame(width: 40, height: 200)
                        VStack(spacing: 15){
                            VStack(){
                                HStack(spacing: 10){
                                    Button(action: {
                                        cal(cell: Card1)
                                        self.Card1 = "back"
                                    }){
                                        Image(Card1)
                                    }
                                    Button(action: {
                                        cal(cell: Card2)
                                        self.Card2 = "back"
                                    }){
                                        Image(Card2)
                                    }
                                }.frame(width: 70,height: 170)
                                HStack(spacing: 10){
                                    Button(action: {
                                        cal(cell: Card3)
                                        self.Card3 = "back"
                                    }){
                                        Image(Card3)
                                    }
                                    Button(action: {
                                        cal(cell: Card4)
                                        self.Card4 = "back"
                                    }){
                                        Image(Card4)
                                    }
                                }.frame(width: 70, height: 170)
                            }.frame(width: 270, height: 370)
                                .background(Color.yellow)
                                .cornerRadius(20)
                            VStack(){
                                HStack(spacing: 10){
                                    Button(action: {
                                        cal(cell: "add")
                                    }){
                                        Image(systemName: "plus.circle.fill")
                                            .font(.system(size: 75))
                                            .foregroundColor(.yellow)
                                    }
                                    Button(action: {
                                        cal(cell: "minus")
                                    }){
                                        Image(systemName: "minus.circle.fill")
                                            .font(.system(size: 75))
                                            .foregroundColor(.yellow)
                                    }
                                    Button(action: {
                                        cal(cell: "multiplication")
                                    }){
                                        Image(systemName: "multiply.circle.fill")
                                            .font(.system(size: 75))
                                            .foregroundColor(.yellow)
                                    }
                                }
                                HStack(spacing: 10){
                                    Button(action: {
                                        cal(cell: "division")
                                    }){
                                        Image(systemName: "divide.circle.fill")
                                            .font(.system(size: 75))
                                            .foregroundColor(.yellow)
                                    }
                                    Button(action: {
                                        cal(cell: "leftBracket")
                                    }){
                                        Image(systemName: "lessthan.circle.fill")
                                            .font(.system(size: 75))
                                            .foregroundColor(.yellow)
                                    }
                                    Button(action: {
                                        cal(cell: "rightBracket")
                                    }){
                                        Image(systemName: "greaterthan.circle.fill")
                                            .font(.system(size: 75))
                                            .foregroundColor(.yellow)
                                    }
                                }
                            }
                        }
                        
                        VStack(spacing: 100){
                            VStack(spacing: 20){
                                Text("总分:")
                                Text("\(totalCount)")
                                    .font(.system(size: 15))
                                    .bold()
                                Text("得分:")
                                Text("\(account)")
                                    .font(.system(size: 15))
                                    .bold()
                                Text("用时:")
                                Text("\(countTimer)")
                                    .font(.system(size: 15))
                                    .bold()
                                    .onReceive(timer) { _ in
                                        if timeRunning{
                                            countTimer += 1
                                        }
                                        else{
                                            timeRunning = false
                                        }
                                    }
                            }
                            Spacer(minLength: 170)
                        }.frame(width: 40, height: 50)
                    }
                    Spacer()
                    VStack{
                        Text(userInput)
                            .font(.system(size: 40))
                            .fontWeight(.bold)
                            .frame(width: 300)
                        
                        HStack(spacing: 30.0){
                            Button(action: {
                                if(account > 3 && totalCount > 3){
                                    account -= 3
                                    totalCount -= 3
                                }
                                else{
                                    account = account
                                    totalCount = totalCount
                                }
                                    randomChange()
                                    countTimer = 0
                                    timeRunning = true},
                                   label:{ Text("跳过")
                                    .padding()
                                    .frame(width: 150, height: 70)
                                    .background(Color.yellow.cornerRadius(20))
                                    .foregroundColor(.black)
                                .font(.headline)})
                            
                            Button(action: {
                                timeRunning = false
                                cal(cell: "equal")
                                Account()
                                WidgetCenter.shared.reloadAllTimelines()
                            }, label:{ Text("确认")
                                    .padding()
                                    .frame(width: 150, height: 70)
                                    .background(Color.yellow.cornerRadius(20))
                                    .foregroundColor(.black)
                                .font(.headline)})
                        }
                    }.frame(width: 400)
                }
            }
        }.navigationBarHidden(true)
    }
    
    func randomChange(){
        userInput = ""
        answer = ""
        
        let Rand1 = Int.random(in: 1...13)
        let Rand2 = Int.random(in: 1...13)
        let Rand3 = Int.random(in: 1...13)
        let Rand4 = Int.random(in: 1...13)
        
        Card1 = String(Rand1)
        Card2 = String(Rand2)
        Card3 = String(Rand3)
        Card4 = String(Rand4)
        
        TCard1 = Card1
        TCard2 = Card2
        TCard3 = Card3
        TCard4 = Card4
        
        @State var c1:Int = (Int(TCard1) ?? 1)
        @State var c2:Int = (Int(TCard2) ?? 1)
        @State var c3:Int = (Int(TCard3) ?? 1)
        @State var c4:Int = (Int(TCard4) ?? 1)
        
        if (Calculate(a: c1, b: c2, c: c3, d: c4) != 1 || difficulty != chosenDifficulty){
            randomChange()
        }
        else{
            answer = ""
        }
    }
    
    func cal(cell: String){
        switch cell {
        case "minus":
            addMinus()
        case "add":
            addAdd()
        case "multiplication":
            addMul()
        case "division":
            addDivision()
        case "leftBracket":
            addLeft()
        case "rightBracket":
            addRight()
        case "equal":
            userInput = calculateResults()
            if(userInput == "Success!"){
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5){
                    randomChange()
                    countTimer = 0
                    timeRunning = true
                }
            }
        case "1":
            userInput += "1"
        case "2":
            userInput += "2"
        case "3":
            userInput += "3"
        case "4":
            userInput += "4"
        case "5":
            userInput += "5"
        case "6":
            userInput += "6"
        case "7":
            userInput += "7"
        case "8":
            userInput += "8"
        case "9":
            userInput += "9"
        case "10":
            userInput += "10"
        case "11":
            userInput += "11"
        case "12":
            userInput += "12"
        case "13":
            userInput += "13"
        default:
            break
        }
    }
    
    func addAdd() {
        if !userInput.isEmpty {
            userInput += "+"
        }
    }
    
    func addMul() {
        if !userInput.isEmpty {
            userInput += "x"
        }
    }
    
    func addDivision() {
        if !userInput.isEmpty {
            userInput += "/"
        }
    }
    
    func addMinus() {
        if !userInput.isEmpty {
            userInput += "-"
        }
    }
    
    func addLeft(){
        userInput += "("
    }
    
    func addRight(){
        userInput += ")"
    }
    
    func calculateResults() -> String {
        if validInput() {
            let input = userInput.replacingOccurrences(of: "x", with: "*")
            let expression = NSExpression(format: input)
            let result = expression.expressionValue(with: nil, context: nil) as! Double
            if(result == 24){
                return "Success!"
            }
            else{
                return "Failed!"
            }
        }
        return  "Invalid!"
    }
    
    func validInput() -> Bool {
        if let number = Int(userInput.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) {
            if (number/1000 < 1) {
                return false
            }
        }
        if (userInput.isEmpty) {
            return false
        }
        else {
            return true
        }
    }
    
    func Account(){
        if(userInput == "Success!" && answer == ""){
            if(countTimer * difficulty <= 30){
                account += 8
                totalCount += 8
            }
            if(countTimer * difficulty > 30 && countTimer * difficulty <= 60){
                account += 5
                totalCount += 5
            }
            if(countTimer * difficulty > 60 && countTimer * difficulty <= 90){
                account += 3
                totalCount += 3
            }
            if(countTimer * difficulty > 90){
                account += 1
                totalCount += 1
            }
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5){
                randomChange()
                countTimer = 0
                timeRunning = true
            }
        }
        else if(account < 8){
            account = account
            totalCount = totalCount
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1){
                timeRunning = true
                Refresh()
                userInput = ""
            }
        }
        else{
            account -= 5
            totalCount -= 5
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1){
                timeRunning = true
                Refresh()
                userInput = ""
            }
        }
    }
    
    func Refresh(){
        Card1 = TCard1
        Card2 = TCard2
        Card3 = TCard3
        Card4 = TCard4
    }
    
    func Question(a:Int){
            if(account < 8){
                account = account
                totalCount = totalCount
            }
            else{
                account -= 5
                totalCount -= 5
            }
    }
    
    func Calculate(a:Int, b:Int, c:Int, d:Int) -> Int{
        if(Answer(x: a, y: b, z: c, w: d) == 1){
            return 1
        }
        if(Answer(x: a, y: b, z: d, w: c) == 1){
            return 1
        }
        if(Answer(x: a, y: c, z: b, w: d) == 1){
            return 1
        }
        if(Answer(x: a, y: c, z: d, w: b) == 1){
            return 1
        }
        if(Answer(x: a, y: d, z: b, w: c) == 1){
            return 1
        }
        if(Answer(x: a, y: d, z: c, w: b) == 1){
            return 1
        }
        if(Answer(x: b, y: a, z: c, w: d) == 1){
            return 1
        }
        if(Answer(x: b, y: a, z: d, w: c) == 1){
            return 1
        }
        if(Answer(x: b, y: c, z: d, w: a) == 1){
            return 1
        }
        if(Answer(x: b, y: c, z: a, w: d) == 1){
            return 1
        }
        if(Answer(x: b, y: d, z: a, w: c) == 1){
            return 1
        }
        if(Answer(x: b, y: d, z: c, w: a) == 1){
            return 1
        }
        if(Answer(x: c, y: d, z: b, w: a) == 1){
            return 1
        }
        if(Answer(x: c, y: d, z: a, w: b) == 1){
            return 1
        }
        if(Answer(x: c, y: a, z: b, w: d) == 1){
            return 1
        }
        if(Answer(x: c, y: a, z: d, w: b) == 1){
            return 1
        }
        if(Answer(x: c, y: b, z: d, w: a) == 1){
            return 1
        }
        if(Answer(x: c, y: b, z: a, w: d) == 1){
            return 1
        }
        if(Answer(x: d, y: b, z: a, w: c) == 1){
            return 1
        }
        if(Answer(x: d, y: b, z: c, w: a) == 1){
            return 1
        }
        if(Answer(x: d, y: c, z: a, w: b) == 1){
            return 1
        }
        if(Answer(x: d, y: c, z: b, w: a) == 1){
            return 1
        }
        if(Answer(x: d, y: a, z: c, w: b) == 1){
            return 1
        }
        if(Answer(x: d, y: a, z: b, w: c) == 1){
            return 1
        }
        return 0
    }
    
    func Answer(x:Int, y:Int, z:Int, w:Int) -> Int{
        if(x+y+z+w == 24){
            answer = "\(x)+\(y)+\(z)+\(w)"
            difficulty = 3
            return 1
        }
        else if(x+y+z-w == 24){
            answer = "\(x)+\(y)+\(z)-\(w)"
            difficulty = 3
            return 1
        }
        else if((x+y)*(z+w) == 24){
            answer = "(\(x)+\(y))*(\(z)+\(w))"
            difficulty = 2
            return 1
        }
        else if((x-y)*(z+w) == 24){
            answer = "(\(x)-\(y))*(\(z)+\(w))"
            difficulty = 1
            return 1
        }
        else if((x-y)*(z-w) == 24){
            answer = "(\(x)-\(y))*(\(z)-\(w))"
            difficulty = 1
            return 1
        }
        else if((x+y+z)*w == 24){
            answer = "(\(x)+\(y)+\(z))*\(w)"
            difficulty = 2
            return 1
        }
        else if((x-y-z)*w == 24){
            answer = "(\(x)-\(y)-\(z))*\(w)"
            difficulty = 2
            return 1
        }
        else if((x+y-z)*w == 24){
            answer = "(\(x)+\(y)-\(z))*\(w)"
            difficulty = 1
            return 1
        }
        else if((x-y+z)*w == 24){
            answer = "(\(x)-\(y)+\(z))*\(w)"
            difficulty = 1
            return 1
        }
        else if(Double((x*y*z))/Double(w) == 24.00){
            answer = "(\(x)*\(y)*\(z))/\(w)"
            difficulty = 1
            return 1
        }
        else if((x*y)*(z+w) == 24){
            answer = "(\(x)*\(y))*(\(z)+\(w))"
            difficulty = 2
            return 1
        }
        else if((x*y)*(z-w) == 24){
            answer = "(\(x)*\(y))*(\(z)-\(w))"
            difficulty = 2
            return 1
        }
        else if((x*y)*z-w == 24){
            answer = "(\(x)*\(y))*\(z)-\(w)"
            difficulty = 1
            return 1
        }
        else if((x*y)*z+w == 24){
            answer = "(\(x)*\(y))*\(z)+\(w)"
            difficulty = 2
            return 1
        }
        else if(x*y*z*w == 24){
            answer = "\(x)*\(y)*\(z)*\(w)"
            difficulty = 1
            return 1
        }
        else if(Double(x*y)+Double(z)/Double(w) == 24.00){
            answer = "(\(x)*\(y))+(\(z)/\(w))"
            difficulty = 2
            return 1
        }
        else if(Double(x*y)*(Double(z)/Double(w)) == 24.00){
            answer = "(\(x)*\(y))*(\(z)/\(w))"
            difficulty = 1
            return 1
        }
        else if((x*y)+(z+w) == 24){
            answer = "(\(x)*\(y))+\(z)+\(w)"
            difficulty = 2
            return 1
        }
        else if((x*y)+(z-w) == 24){
            answer = "(\(x)*\(y))+\(z)-\(w)"
            difficulty = 2
            return 1
        }
        else if(Double(x*y)-Double(z)/Double(w) == 24.00){
            answer = "(\(x)*\(y))-(\(z)/\(w))"
            difficulty = 1
            return 1
        }
        else if((x*y)-z-w == 24){
            answer = "(\(x)*\(y))-\(z)-\(w)"
            difficulty = 1
            return 1
        }
        else if((x*y)+(z*w) == 24){
            answer = "(\(x)*\(y))+(\(z)*\(w))"
            difficulty = 2
            return 1
        }
        else if((x*y)-(z*w) == 24){
            answer = "(\(x)*\(y))-(\(z)*\(w))"
            difficulty = 1
            return 1
        }
        else if(Double((x*y))/Double(z*w) == 24.00){
            answer = "(\(x)*\(y))+(\(z)*\(w))"
            difficulty = 2
            return 1
        }
        else if(z-w != 0 && Double(x*y)/Double(z-w) == 24){
                answer = "(\(x)*\(y))+(\(z)-\(w))"
                difficulty = 1
                return 1
        }
        else if(Double((x*y))/Double(z+w) == 24.00){
            answer = "(\(x)*\(y))/(\(z)+\(w))"
            difficulty = 1
            return 1
        }
        else{
            return 0
        }
    }
    }

