//
//  TabView.swift
//  Beanify
//
//  Created by Mohamed Feituri on 8/29/25.
//
import SwiftUI

struct TabNavigationView: View {
    @StateObject private var dashboardVM = DashboardViewModel()

    init() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithTransparentBackground()
        tabBarAppearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        tabBarAppearance.stackedLayoutAppearance.selected.iconColor = UIColor.systemGreen
        tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.systemGreen]

        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }

    var body: some View {
        TabView {
            NavigationStack {
                DashboardView()
                    .navigationTitle("Your Spotify Dashboard")
            }
            .tabItem {
                Label("Dashboard", systemImage: "chart.bar.doc.horizontal")
            }

            // Data Tab
            DataView(vm: DataViewModel(tracks: dashboardVM.topTracks))
                .tabItem {
                    Label("Data", systemImage: "chart.pie.fill")
                }

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle.fill")
                }
        }
        .accentColor(.green)
        .task {
            await dashboardVM.fetchArtistData()
            await dashboardVM.fetchTrackData()
        }
    }
}
