//
//  TodayCondition.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/02/03.
//

import SwiftUI

struct TodayCondition: View {
    @State private var isExpanded = false
    @State private var selectedDestination: NavigationDestination.Activity?

    var body: some View {
        ZStack {
            VStack {
                Spacer()

                if isExpanded {
                    HStack(spacing: 3) {
                        NavigationLink(value: NavigationDestination.Activity.physicalConditionEntryForm) {
                            Image(systemName: "medical.thermometer.fill")
                                .padding()
                                .background(.black)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                        }
                        .transition(.opacity)
                        NavigationLink(value: NavigationDestination.Activity.reviewEnrtyForm) {
                            Image(systemName: "book.fill")
                                .padding()
                                .background(.black)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                        }
                        .transition(.opacity)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }

                HStack {
                    Spacer()

                    if isExpanded {
                        VStack {
                            NavigationLink(value: NavigationDestination.Activity.stepEntryForm) {
                                Image(systemName: "shoeprints.fill")
                                    .padding()
                                    .background(.black)
                                    .foregroundColor(.white)
                                    .clipShape(Circle())
                            }
                            .transition(.opacity)
                            NavigationLink(value: NavigationDestination.Activity.hydrationEntryForm) {
                                Image(systemName: "takeoutbag.and.cup.and.straw.fill")
                                    .padding()
                                    .background(.black)
                                    .foregroundColor(.white)
                                    .clipShape(Circle())
                            }
                            .transition(.opacity)
                        }
                    }

                    Button(
                        action: {
                            withAnimation(Animation.linear(duration: 0.5)) {
                                isExpanded.toggle()
                            }
                        },
                        label: {
                            Image(systemName: "plus.square.fill")
                                .resizable()
                                .frame(width: 60, height: 60)
                                .foregroundColor(.gray)
                        }
                    )
                    .padding()
                }
            }
            .navigationDestination(for: NavigationDestination.Activity.self) { destination in
                switch destination {
                case .physicalConditionEntryForm:
                    PhysicalConditionEntryForm()
                case .reviewEnrtyForm:
                    ReviewEntryForm()
                case .stepEntryForm:
                    StepEntryForm()
                case .hydrationEntryForm:
                    HydrationEntryForm()
                }
            }
        }
    }
}

#Preview {
    TodayCondition()
}
