//
//  ContentView.swift
//  计算器
//
//  Created by 梁大可 on 2023/7/19.

import SwiftUI

struct MainView: View {
    @AppStorage("All Count") var totalCount: Int = 0
    @AppStorage("userName") var userName: String = "LiangDuck"
    
    var body: some View {
        TabView {
            EntryView()
                .tabItem {
                    Label("Game", systemImage: "gamecontroller")
                }
            ListView(totalCount: totalCount, userName: userName)
                .tabItem {
                    Label("Ranking", systemImage: "list.star")
                }
            StartView()
                .tabItem {
                    Label("Me", systemImage: "house")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
