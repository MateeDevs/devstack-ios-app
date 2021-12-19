//
//  Created by Tomas Brand on 05.12.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import SwiftUI
import WidgetKit

struct UserWidgetView: View {
    
    @SwiftUI.Environment(\.widgetFamily) var family
    @StateObject private var viewModel = UserWidgetViewModel()
    let entry: UserWigetProvider.Entry
    
    var enforcedFamily: WidgetFamily?

    var size: WidgetFamily {
        enforcedFamily ?? family
    }
    
    var body: some View {
        Text(viewModel.user?.fullName ?? "")
    }
    
    private var smallWidget: some View {
        if case let .user(userData) = viewModel.viewData {
            return VStack(alignment: .leading, spacing: 12) {
                AsyncImage(url: URL(string: userData.pictureUrl))
                Text(userData.name)
            }
            .padding(.all, 16)
            .background(Color.white)
            .toAnyView()
        } else {
            return errorView
                .foregroundColor(.black)
                .toAnyView()
        }
    }
    
    private var errorView: some View {
        HStack {
            Spacer()
            VStack(alignment: .center) {
                Spacer()
                Image("")
                Text("No data to display")
                    .font(.system(size: 16))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                Spacer()
            }
            Spacer()
        }
        .background(Color.white)
    }
}

struct UserWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        UserWidgetView(
            entry: UserWigetProvider.Entry(date: Date(), user: nil)
        )
    }
}
