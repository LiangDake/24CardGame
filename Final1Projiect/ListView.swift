import SwiftUI

struct ListView: View {
    var dict = ["Jason": 109, "Eric": 50, "Racheal": 62, "Frank": 96, "Kris": 153]
    @AppStorage("All Count") var totalCount: Int = 0
    @AppStorage("nextUser") var nextUser: String = "Eric"
    @AppStorage("userName") var userName: String = "LiangDuck"
    init(totalCount: Int, userName: String) {
            dict.updateValue(totalCount, forKey: userName)
            
        }
    
    var body: some View {
        NavigationView {
            ZStack{
                LinearGradient(gradient: Gradient(colors: [.yellow, .white]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
                Form{
                    ForEach(dict.sorted(by: { $0.value > $1.value }), id: \.key){ key, value in
                        Text("\(key): \(value)").frame(height: 60)
                    }
                }
                .scrollContentBackground(.hidden)
                .frame(width: 390)
                
            }.navigationTitle("总分排行榜")
        }
    }
}

