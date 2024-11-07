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
        let entry = SimpleEntry(date: Date(), counter: counter)
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
}

struct WorkshopWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text("You have pressed the button this many times:")

            Text(entry.counter.description)
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