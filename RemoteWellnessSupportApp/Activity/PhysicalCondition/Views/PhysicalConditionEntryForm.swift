//
//  PhysicalConditionEntryForm.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/02/10.
//

import SwiftUI

struct PhysicalConditionEntryForm: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = PhysicalConditionEntryFormViewModel()

    var body: some View {
        Text("体調登録")
            .font(.title)
        Form {
            DatePicker("日付", selection: $viewModel.selectedDateTime, displayedComponents: [.date, .hourAndMinute])

            HStack {
                ForEach(PhysicalConditionRating.allCases, id: \.self) { rating in
                    VStack {
                        Image(systemName: rating.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .foregroundColor(viewModel.selectedRating == rating ? .blue : .gray)
                        Text(rating.label)
                    }
                    .onTapGesture {
                        viewModel.selectedRating = rating
                    }
                }
            }
            .padding(.vertical)
            Text("\(viewModel.selectedRating?.label ?? "選択なし")")
                .foregroundColor(.gray)

            ZStack(alignment: .topLeading) {
                if viewModel.memo.isEmpty {
                    Text("自由に気持ちを吐き出しましょう")
                        .font(.system(size: 18))
                        .foregroundColor(Color.gray)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 12)
                }
                TextEditor(text: $viewModel.memo)
                    .font(.system(size: 18))
                    .frame(minHeight: 72)
                    .padding(.horizontal)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
            }
            .padding(.all)

            CommonButtonView(title: "保存する") {
                viewModel.insertPhysicalCondition(modelContext)
            }
            .onReceive(viewModel.successPublisher) { _ in
                dismiss()
            }
        }
        .environment(\.locale, .init(identifier: "ja_JP"))
        .alert("エラーです", isPresented: $viewModel.isErrorAlert) {
            Button("戻る", role: .cancel) {
                viewModel.isErrorAlert = false
            }
        } message: {
            Text(viewModel.errorMessage)
        }
    }
}

#Preview {
    PhysicalConditionEntryForm()
}
