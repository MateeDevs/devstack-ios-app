//
//  Created by Tomas Brand on 05.12.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import SwiftUI
import WidgetKit

@main
struct UserWidget: Widget {
    let kind: String = "SystemWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: UserWigetProvider()) { entry in
            UserWidgetView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}
