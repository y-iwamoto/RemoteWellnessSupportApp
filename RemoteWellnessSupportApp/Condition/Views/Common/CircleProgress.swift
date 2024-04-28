//
//  CircleProgress.swift
//  RemoteWellnessSupportApp
//
//  Created by 岩本雄貴 on 2024/04/15.
//

import SwiftUI

struct CircleProgress: Shape {
    private(set) var progress: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY),
                    radius: rect.width / 2,
                    startAngle: .degrees(-90),
                    endAngle: .degrees(-90 + 360 * Double(progress)),
                    clockwise: false)
        return path
    }

    var animatableData: CGFloat {
        get { progress }
        set { progress = newValue }
    }
}
