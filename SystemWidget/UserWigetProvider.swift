//
//  Created by Tomas Brand on 05.12.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import DomainLayer
import SwiftUI
import WidgetKit

struct UserWigetProvider: TimelineProvider {
    func placeholder(in context: Context) -> UserWidgetEntry {
        UserWidgetEntry(date: Date(), user: nil)
    }

    func getSnapshot(in context: Context, completion: @escaping (UserWidgetEntry) -> Void) {
        let entry = UserWidgetEntry(date: Date(), user: nil)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<UserWidgetEntry>) -> Void) {
        let nowEntry = UserWidgetEntry(date: Date(), user: nil)
        let nextEntry = UserWidgetEntry(date: Date(), user: nil /* use usecase for getting data */)

        let timeline = Timeline(entries: [nowEntry, nextEntry], policy: .atEnd)
        
     //   usecase.getData {
            completion(timeline)
       // }
    }
}

struct UserWidgetEntry: TimelineEntry {
    let date: Date
    let user: User?
}

struct UserWidgetEntryView: View {
    var entry: UserWigetProvider.Entry

    var body: some View {
        Text(entry.date, style: .time)
    }
}
