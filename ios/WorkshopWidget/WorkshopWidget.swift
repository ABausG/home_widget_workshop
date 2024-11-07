//
//  WorkshopWidget.swift
//  WorkshopWidget
//
//  Created by Anton Borries on 03.11.24.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), counter: 3)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let userDefaults = UserDefaults(suiteName: "group.es.antonborri.homeWidgetWorkshop.workshopWidget")
        let counter = userDefaults?.integer(forKey: "counter") ?? 0
        let imagePath = userDefaults?.string(forKey: "dash")
        let entry = SimpleEntry(date: Date(), counter: counter, imagePath: imagePath)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        getSnapshot(in: context) { entry in
            let timeline = Timeline(entries: [entry], policy: .atEnd)
            completion(timeline)
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let counter: Int
    var imagePath: String? = nil
}

struct WorkshopWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text("You have pressed the button this many times:")

            Text(entry.counter.description)
            if let imagePath = entry.imagePath, 
                let uiImage = UIImage(contentsOfFile: imagePath) {
                Button(
                    intent: BackgroundIntent(
                        url: URL(string: "homeWidgetWorkshop://increment"),
                        appGroup: "group.es.antonborri.homeWidgetWorkshop.workshopWidget")) {
                            Image(uiImage: uiImage)
                }
            } else {
                EmptyView()
            }
        }
    }
}

struct WorkshopWidget: Widget {
    let kind: String = "WorkshopWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                WorkshopWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                WorkshopWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

#Preview(as: .systemSmall) {
    WorkshopWidget()
} timeline: {
    SimpleEntry(date: .now, counter: 2)
}
