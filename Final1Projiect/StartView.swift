import SwiftUI
import WidgetKit
struct StartView: View {
    var Card = ["黑桃A": "1", "黑桃J": "11", "红桃Q": "12", "黑桃K": "13"]
    var Photo = ["黑桃A", "红桃Q", "黑桃J", "黑桃K"]
    @AppStorage("userPhoto") var selectedPhoto = "黑桃K"
    @State private var inputValue = ""
    @AppStorage("userName") var userName = "LiangDuck"
    var body: some View {
        NavigationView {
            ZStack{
                LinearGradient(gradient: Gradient(colors: [.yellow, .white]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
                Form{
                    HStack{
                        Image(Card[selectedPhoto]!)
                            .resizable()
                            .cornerRadius(10)
                            .frame(width: 70, height: 70)
                        Text(userName).font(.system(size:20))
                    }
                    HStack{
                        Text("修改昵称:")
                        TextField("请输入昵称", text: $inputValue)
                            .padding()
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Button("确认"){
                            userName = inputValue
                            inputValue = ""
                            WidgetCenter.shared.reloadAllTimelines()
                        }
                    }
                    Picker("更换头像:", selection: $selectedPhoto) {
                        ForEach(Photo, id: \.self) {item in
                            Text(item)
                        }
                        .onTapGesture {
                            WidgetCenter.shared.reloadAllTimelines()
                        }
                    }
                }
                .scrollContentBackground(.hidden)
            } .navigationTitle("用户信息")
        }
    }
}
