//
//  ActivityEntryNavigationLink.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/02/12.
//

import SwiftUI

struct ActivityEntryNavigationLink: View {
    let destination: ConditionNavigationLink.Destination
    let imageName: ConditionNavigationLink.ImageName

    var body: some View {
        NavigationLink(value: destination) {
            Image(systemName: imageName.rawValue)
                .padding()
                .background(.black)
                .foregroundColor(.white)
                .clipShape(Circle())
        }
        .transition(.opacity)
    }
}

// #Preview {
//    ActivityEntryNavigationLink()
// }
