import SwiftUI

struct SceneSelectionView: View {
    @State private var viewState = SceneSelectionViewState()
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationView {
            ZStack {
                backgroundColor
                
                if viewState.isLoading {
                    loadingView
                } else {
                    contentView
                }
            }
            .navigationTitle("場面別学習")
            .navigationBarTitleDisplayMode(.large)
            .refreshable {
                await viewState.refreshScenes()
            }
            .task {
                await viewState.onAppear()
            }
        }
    }
    
    private var backgroundColor: some View {
        LinearGradient(
            colors: [Color.green.opacity(0.1), Color.blue.opacity(0.1)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
    
    private var loadingView: some View {
        VStack(spacing: 20) {
            ProgressView()
                .scaleEffect(2.0)
            
            Text("場面を読み込み中...")
                .font(.title3)
                .foregroundColor(.secondary)
        }
    }
    
    private var contentView: some View {
        ScrollView {
            VStack(spacing: 24) {
                headerView
                categorySelectionView
                scenesListView
                Spacer(minLength: 100)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
        }
    }
    
    private var headerView: some View {
        VStack(alignment: .leading, spacing: 12) {
            RubyText("学習する場面を選んでください", ruby: "がくしゅうするばめんをえらんでください", fontSize: 18, alignment: .leading)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("それぞれの場面で使われる語彙を楽しく学習できます")
                .font(.body)
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.vertical, 8)
    }
    
    private var categorySelectionView: some View {
        VStack(alignment: .leading, spacing: 16) {
            RubyText("学校生活", ruby: "がっこうせいかつ", fontSize: 20, alignment: .leading)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(SceneCategory.allCases.filter { isSchoolLifeCategory($0) }, id: \.self) { category in
                        let scenesForCategory = viewState.scenes.filter { $0.category == category }
                        if !scenesForCategory.isEmpty {
                            ForEach(scenesForCategory, id: \.id) { scene in
                                SceneMiniCard(
                                    scene: scene,
                                    isSelected: viewState.selectedCategory == category
                                ) {
                                    Task {
                                        await viewState.selectCategory(category)
                                    }
                                }
                                .frame(width: 80)
                            }
                        }
                    }
                }
                .padding(.horizontal, 4)
            }
        }
    }
    
    private var scenesListView: some View {
        VStack(alignment: .leading, spacing: 16) {
            if !viewState.schoolLifeScenes.isEmpty {
                LazyVStack(spacing: 12) {
                    ForEach(viewState.schoolLifeScenes, id: \.id) { scene in
                        NavigationLink(destination: LearningView(scene: scene)) {
                            SceneCard(
                                scene: scene,
                                progress: viewState.getProgress(for: scene)
                            ) {}
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            } else {
                emptyStateView
            }
            
            if !viewState.dailyLifeScenes.isEmpty {
                VStack(alignment: .leading, spacing: 16) {
                    RubyText("日常生活", ruby: "にちじょうせいかつ", fontSize: 20, alignment: .leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 20)
                    
                    LazyVStack(spacing: 12) {
                        ForEach(viewState.dailyLifeScenes, id: \.id) { scene in
                            NavigationLink(destination: LearningView(scene: scene)) {
                                SceneCard(
                                    scene: scene,
                                    progress: viewState.getProgress(for: scene)
                                ) {}
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
            }
        }
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Image(systemName: "book.closed")
                .font(.system(size: 48))
                .foregroundColor(.gray)
            
            Text("まだ場面がありません")
                .font(.title3)
                .foregroundColor(.secondary)
            
            Text("下に引っ張って更新してください")
                .font(.body)
                .foregroundColor(.secondary)
        }
        .padding(40)
        .frame(maxWidth: .infinity)
    }
    
    private func isSchoolLifeCategory(_ category: SceneCategory) -> Bool {
        switch category {
        case .morningAssembly, .classTime, .lunchTime, .cleaningTime, .breakTime:
            return true
        default:
            return false
        }
    }
}

#Preview {
    SceneSelectionView()
}