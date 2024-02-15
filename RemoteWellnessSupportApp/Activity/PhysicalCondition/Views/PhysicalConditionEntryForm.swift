//
//  PhysicalConditionEntryForm.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/02/10.
//

import SwiftUI

struct PhysicalConditionEntryForm: View {
    @State private var selectedDateTime = Date()
    @State private var memo = ""
    @State private var selectedRating: PhysicalConditionRating?

    var body: some View {
        Text("体調登録")
            .font(.title)
        Form {
            DatePicker("日付", selection: $selectedDateTime, displayedComponents: [.date, .hourAndMinute])

            HStack {
                ForEach(PhysicalConditionRating.allCases, id: \.self) { rating in
                    VStack {
                        Image(systemName: rating.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .foregroundColor(selectedRating == rating ? .blue : .gray)
                        Text(rating.label)
                    }
                    .onTapGesture {
                        selectedRating = rating
                    }
                }
            }
            .padding(.vertical)
            Text("\(selectedRating?.label ?? "選択なし")")
                .foregroundColor(.gray)

            ZStack(alignment: .topLeading) {
                if memo.isEmpty {
                    Text("自由に気持ちを吐き出しましょう")
                        .font(.system(size: 18))
                        .foregroundColor(Color.gray)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 12)
                }
                TextEditor(text: $memo)
                    .font(.system(size: 18))
                    .frame(minHeight: 72)
                    .padding(.horizontal)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
            }
            .padding(.all)

            CommonButtonView(title: "保存する", action: {
                print("登録しました")
            })
        }
        .environment(\.locale, .init(identifier: "ja_JP"))
    }
}

#Preview {
    PhysicalConditionEntryForm()
}
