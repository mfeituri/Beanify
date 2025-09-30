//
//  PieChartView.swift
//  Beanify
//
//  Created by Mohamed Feituri on 9/29/25.
//

import SwiftUI

struct PieChartView: View {
    let slices: [PieSlice]

    var body: some View {
        GeometryReader { geo in
            ZStack {
                let radius = min(geo.size.width, geo.size.height) / 2
                let center = CGPoint(x: geo.size.width/2, y: geo.size.height/2)

                ForEach(slices.indices) { i in
                    let startAngle = angle(at: i)
                    let endAngle = angle(at: i + 1)
                    let midAngle = Angle(degrees: (startAngle.degrees + endAngle.degrees) / 2)

                    // Slice
                    Path { path in
                        path.move(to: center)
                        path.addArc(center: center,
                                    radius: radius,
                                    startAngle: startAngle,
                                    endAngle: endAngle,
                                    clockwise: false)
                    }
                    .fill(slices[i].color)

                    // Label inside slice
                    let labelRadius = radius * 0.6
                    let x = center.x + CGFloat(cos(midAngle.radians)) * labelRadius
                    let y = center.y + CGFloat(sin(midAngle.radians)) * labelRadius

                    Text("\(slices[i].label)\n\(Int(slices[i].value * 100))%")
                        .font(.caption2)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .position(x: x, y: y)
                }
            }
        }
    }

    private func angle(at index: Int) -> Angle {
        let total = slices.map { $0.value }.reduce(0, +)
        let cumulative = slices.prefix(index).map { $0.value }.reduce(0, +)
        return .degrees(360 * cumulative / total - 90)
    }
}
