//
//  TabView.swift
//  Beanify
//
//  Created by Mohamed Feituri on 8/29/25.
//
import SwiftUI


struct TabNavigationView: View{
    var body: some View{
        TabView{
            NavigationStack{
                DashboardView()
                    .navigationTitle("Dashboard")
            }
            .tabItem{
                Label("Dashboard", systemImage: "chart.bar.horizontal.page.fill")
            }
            FavoritesView()
                .tabItem{
                    Label("Favorites", systemImage: "star")
                }
            SettingsView()
                .tabItem{
                    Label("Settings", systemImage: "gear")
                }
            ProfileView()
                .tabItem{
                    Label("Profile", systemImage: "person")
                }
            AiView()
                .tabItem{
                    Label("Ai?", systemImage: "face.smiling")
                }
        }
//        .tabViewStyle(.page(indexDisplayMode: .always))
    }
}

#Preview {
    TabNavigationView()
}
