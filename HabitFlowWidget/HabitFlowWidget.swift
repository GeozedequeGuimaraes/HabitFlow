import WidgetKit
import SwiftUI

struct HabitFlowWidget: Widget {
    let kind: String = "HabitFlowWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: WidgetProvider()) { entry in
            WidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("HabitFlow")
        .description("Acompanhe seus hábitos do dia.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}
