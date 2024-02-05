//
//  TodayCondition.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/02/03.
//

import SwiftUI

struct TodayCondition: View {
    @State private var isExpanded = false

    var body: some View {
        ZStack {
            VStack {
                Spacer()

                HStack {
                    Spacer()

                    if isExpanded {
                        VStack {
                            Button(
                                action: {
                                    // 新規登録画面1への遷移
                                },
                                label: {
                                    Text("登録1")
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .clipShape(Circle())
                                }
                            )

                            Button(
                                action: {
                                    // 新規登録画面2への遷移
                                },
                                label: {
                                    Text("登録2")
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .clipShape(Circle())
                                }
                            )
                        }
                        .transition(.move(edge: .trailing))
                    }

                    Button(
                        action: {
                            withAnimation {
                                isExpanded.toggle()
                            }
                        },
                        label: {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 60, height: 60)
                                .foregroundColor(.blue)
                        }
                    )
                    .padding()
                }
            }
        }
    }
}

#Preview {
    TodayCondition()
}
