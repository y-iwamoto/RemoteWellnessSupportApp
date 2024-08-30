//
//  WorkModeMessageView.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/08/30.
//

import SwiftUI

struct WorkModeMessageView: View {
    @StateObject var viewModel: WorkModeMessageViewModel

    init(viewModel: WorkModeMessageViewModel = WorkModeMessageViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(lineWidth: 20)
                    .opacity(0.8)
                    .foregroundColor(viewModel.workStatus.color)
                VStack {
                    Text(viewModel.workStatus.title)
                        .font(.largeTitle)
                        .padding()
                    Text(viewModel.workStatus.motivationalMessage)
                }
                .padding(20)
            }
            .padding(20)
        }
        .onAppear {
            viewModel.fetchWorkStatus()
        }
    }
}

#Preview {
    WorkModeMessageView()
}
