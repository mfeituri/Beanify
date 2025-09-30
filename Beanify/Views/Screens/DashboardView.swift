import SwiftUI

struct DashboardView: View {
    @StateObject private var viewModel = DashboardViewModel()
    @State private var showingArtists = true
    
    
    var body: some View {
        ZStack {
            // background gradient
            LinearGradient(
                colors: [.purple.opacity(0.9), .green.opacity(0.8)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 28) {
                    
                    //header
                    VStack(spacing: 8) {
                    
                        Text("Discover your top artists & tracks")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white.opacity(0.8))
                    }
                    .padding(.top, 20)
                    
                    // this is for the time range picker
                    VStack(spacing: 12) {
                        Text("Show results for the last:")
                            .font(.headline)
                            .foregroundColor(.white.opacity(0.9))
                        
                        Picker("Time Frame", selection: $viewModel.selectedTerm) {
                            Text("4 Weeks").tag(TimeRange.shortTerm)
                            Text("6 Months").tag(TimeRange.mediumTerm)
                            Text("Year").tag(TimeRange.longTerm)
                        }
                        .pickerStyle(.segmented)
                        .padding(.horizontal)
                        .onChange(of: viewModel.selectedTerm) { _ in
                            Task {
                                await viewModel.fetchArtistData()
                                await viewModel.fetchTrackData()
                            }
                        }
                    }
                    .padding()
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .padding(.horizontal)
                    
                    // toggles which one shows
                    Button(action: {
                        withAnimation(.spring()) {
                            showingArtists.toggle()
                        }
                    }) {
                        Text(showingArtists ? "Switch to Top Tracks" : "Switch to Top Artists")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.ultraThinMaterial)
                            .clipShape(Capsule())
                            .foregroundColor(.white)
                            .shadow(radius: 3)
                    }
                    .padding(.horizontal)
                    
                    
                    if showingArtists {
                        GroupBox {
                            VStack(alignment: .leading, spacing: 16) {
                                Text("🎤 Top Artists")
                                    .font(.title2.bold())
                                    .foregroundColor(.primary)
                                
                                TopArtistsWidget(artists: viewModel.topArtists)
                            }
                            .padding()
                        }
                        .groupBoxStyle(GlassGroupBoxStyle())
                    } else {
                        GroupBox {
                            VStack(alignment: .leading, spacing: 16) {
                                Text("🎵 Top Tracks")
                                    .font(.title2.bold())
                                    .foregroundColor(.primary)
                                
                                TopTracksWidget(tracks: viewModel.topTracks)
                            }
                            .padding()
                        }
                        .groupBoxStyle(GlassGroupBoxStyle())
                    }
                    
                }
                .padding(.bottom, 40)
            }
            .task {
                await viewModel.fetchArtistData()
                await viewModel.fetchTrackData()
            }
        } 
    }
}

// Custom GroupBox Style Glassmorphism
struct GlassGroupBoxStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.content
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .strokeBorder(Color.white.opacity(0.2), lineWidth: 1)
            )
    }
}

#Preview {
    DashboardView()
}
