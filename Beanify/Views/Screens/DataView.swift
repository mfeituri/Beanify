//
//  DataView.swift
//  Beanify
//
//  Created by Mohamed Feituri on 9/20/25.
//


//
//  DataView.swift
//  Beanify
//
//  Created by Mohamed Feituri on 9/29/25.
//

import SwiftUI

struct DataView: View {
    @StateObject var vm: DataViewModel

    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [.purple.opacity(0.6), .green.opacity(0.6)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 24) {
                    Text("Your Top Genres")
                        .font(.title2.bold())
                        .padding(.top)

                    PieChartView(slices: vm.makeSlices())
                        .frame(height: 300)
                        .padding()

                    VStack(spacing: 12) {
                        ForEach(vm.makeSlices()) { slice in
                            HStack {
                                Circle()
                                    .fill(slice.color)
                                    .frame(width: 20, height: 20)
                                Text(slice.label)
                                    .font(.headline)
                                Spacer()
                                Text(String(format: "%.0f%%", slice.value * 100))
                                    .foregroundColor(.gray)
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.bottom, 40)
                }
            }
        }
    }
}
