import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var selectedTab: Int = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("ホーム")
                }
                .tag(0)
            
            SceneSelectionView()
                .tabItem {
                    Image(systemName: "book.fill")
                    Text("学習")
                }
                .tag(1)
            
            DictionaryView()
                .tabItem {
                    Image(systemName: "books.vertical.fill")
                    Text("図鑑")
                }
                .tag(2)
            
            ProgressTrackingView()
                .tabItem {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                    Text("記録")
                }
                .tag(3)
        }
        .accentColor(.blue)
    }
}

struct DictionaryView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image(systemName: "books.vertical")
                    .font(.system(size: 60))
                    .foregroundColor(.gray)
                
                VStack(spacing: 8) {
                    RubyText("図鑑", ruby: "ずかん", fontSize: 24)
                    
                    Text("覚えた語彙を確認できます")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                
                Text("準備中です")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .navigationTitle("図鑑")
        }
    }
}

struct ProgressTrackingView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image(systemName: "chart.line.uptrend.xyaxis")
                    .font(.system(size: 60))
                    .foregroundColor(.gray)
                
                VStack(spacing: 8) {
                    RubyText("学習記録", ruby: "がくしゅうきろく", fontSize: 24)
                    
                    Text("あなたの学習の記録を見ることができます")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                
                Text("準備中です")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .navigationTitle("記録")
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: User.self, inMemory: true)
}
