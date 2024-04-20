//
//  Test1Widget.swift
//  Test1Widget
//
//  Created by 梁大可 on 2023/8/11.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), totalCount: getData(), userName: getName(), selectedPhoto: getPhoto())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), totalCount: getData(), userName: getName(), selectedPhoto: getPhoto())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, totalCount: getData(), userName: getName(), selectedPhoto: getPhoto())
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
    private func getData() -> Int {
        let defaults = UserDefaults(suiteName: "group.LKmade.Final1Projiect")
        return defaults!.integer(forKey: "All Count")
    }
    private func getName() -> String {
        let defaults = UserDefaults(suiteName: "group.LKmade.Final1Projiect")
        return defaults!.string(forKey: "userName") ?? "LiangDuck"
    }
    private func getPhoto() -> String {
        let defaults = UserDefaults(suiteName: "group.LKmade.Final1Projiect")
        return defaults!.string(forKey: "selectedPhoto") ?? "黑桃K"
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let totalCount: Int
    let userName: String
    let selectedPhoto : String
}

struct PleaseEntryView : View {
    var Card = ["黑桃A": "1", "黑桃J": "11", "红桃Q": "12", "黑桃K": "13"]
    var Photo = ["黑桃A", "红桃Q", "黑桃J", "黑桃K"]
    var dict = ["Jason": 109, "Eric": 50, "Racheal": 62, "Frank": 96, "Kris": 153]
    @AppStorage("userPhoto") var selectedPhoto = "黑桃K"
    @AppStorage("All Count") var totalCount = 0
    @AppStorage("userName") var userName: String = "Duck"
    @Environment(\.widgetFamily) var family
    var entry: Provider.Entry

    var body: some View {
        switch family {
        case .systemSmall:
            ZStack{
                LinearGradient(gradient: Gradient(colors: [.yellow, .white]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
                    VStack(alignment:.leading){
                        Spacer(minLength: 30)
                        HStack{
                            Image(Card[selectedPhoto]!)
                                .resizable()
                                .cornerRadius(30)
                                .frame(width: 30, height: 30)
                            Text("\(entry.userName)")
                                .font(.system(size: 30))
                                .bold()
                                .italic()
                                .underline(color: .black)
                        }.frame(height: 0)
                        Spacer()
                        Text("\(entry.totalCount)")
                            .font(Font.system(size: 95))
                            .foregroundColor(.purple)
                            .bold()
                            .italic()
                        Spacer()
                    }.frame(width: 130)
            }
        case .systemMedium:
            ZStack{
                LinearGradient(gradient: Gradient(colors: [.yellow, .white]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
                HStack{
                    VStack(alignment:.leading){
                        Spacer(minLength: 30)
                        HStack{
                            Image(Card[selectedPhoto]!)
                                .resizable()
                                .cornerRadius(30)
                                .frame(width: 30, height: 30)
                            Text("\(entry.userName)")
                                .font(.system(size: 30))
                                .bold()
                                .italic()
                                .underline(color: .black)
                        }.frame(height: 0)
                        Spacer()
                        Text("\(entry.totalCount)")
                            .font(Font.system(size: 95))
                            .foregroundColor(.purple)
                            .bold()
                            .italic()
                        Spacer()
                    }.frame(width: 130)
                    VStack{
                        ForEach(dict.sorted(by: { $0.value > $1.value }), id: \.key){ key, value in
                            Text("\(key): \(value)")}
                            .bold()
                            .italic()
                    }.frame(width: 130)
                }
            }
        default:
            Text("Not implemented")
        }
    }
}

struct Please: Widget {
    let kind: String = "Test1Widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            PleaseEntryView(entry: entry)
        }
        .configurationDisplayName("总得分")
        .description("展示你所获得的总分数")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct Please_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PleaseEntryView(entry: SimpleEntry(date: Date(), totalCount: 30, userName: "Duck", selectedPhoto: "黑桃K"))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            
            PleaseEntryView(entry: SimpleEntry(date: Date(), totalCount: 30, userName: "Duck", selectedPhoto: "黑桃K"))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
        }
    }
}
