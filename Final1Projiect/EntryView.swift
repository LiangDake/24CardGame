//  EntryView.swift
//  Final1Projiect
//
//  Created by 梁大可 on 2023/8/15.
//

import SwiftUI

struct EntryView: View {
    @State var chosenDifficulty = 1
    @State var isNavPush = false
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(isActive: $isNavPush) {
                    ContentView( chosenDifficulty: $chosenDifficulty)
                } label: {
                }
                Spacer()
                Button(action: {
                    chosenDifficulty = 1
                    isNavPush = true
                }, label:{ Text("高级场")
                        .padding()
                        .frame(width: 150, height: 70)
                        .background(Color.yellow.cornerRadius(20))
                        .foregroundColor(.black)
                    .font(.headline)})
                Spacer()
                Button(action: {
                    chosenDifficulty = 2
                    isNavPush = true
                }, label:{ Text("中级场")
                        .padding()
                        .frame(width: 150, height: 70)
                        .background(Color.yellow.cornerRadius(20))
                        .foregroundColor(.black)
                    .font(.headline)})
                Spacer()
                Button(action: {
                    chosenDifficulty = 3
                    isNavPush = true
                }, label:{ Text("普通场")
                        .padding()
                        .frame(width: 150, height: 70)
                        .background(Color.yellow.cornerRadius(20))
                        .foregroundColor(.black)
                    .font(.headline)})
                Spacer()
            }
            .navigationTitle("主页面")
            .padding()
        }
    }
}
// 用户左滑返回
extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

struct EntryView_Previews: PreviewProvider {
    static var previews: some View {
        EntryView()
    }
}
