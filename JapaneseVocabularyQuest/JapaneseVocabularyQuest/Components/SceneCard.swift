import SwiftUI

struct SceneCard: View {
    let scene: LearningScene
    let progress: Double
    let onTap: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    RubyText(scene.title, ruby: scene.rubyTitle, fontSize: 20, alignment: .leading)
                    
                    Text(scene.sceneDescription)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                Spacer()
                
                if !scene.illustrationUrls.isEmpty, let imageUrl = URL(string: scene.illustrationUrls.first!) {
                    AsyncImage(url: imageUrl) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(categoryColor.opacity(0.3))
                            .overlay(
                                Image(systemName: categoryIcon)
                                    .font(.title2)
                                    .foregroundColor(categoryColor)
                            )
                    }
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                } else {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(categoryColor.opacity(0.3))
                        .overlay(
                            Image(systemName: categoryIcon)
                                .font(.title2)
                                .foregroundColor(categoryColor)
                        )
                        .frame(width: 60, height: 60)
                }
            }
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("進捗")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Text("\(Int(progress * 100))%")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                ProgressView(value: progress)
                    .progressViewStyle(LinearProgressViewStyle())
                    .accentColor(categoryColor)
                    .scaleEffect(y: 1.5)
                
                HStack {
                    categoryBadge
                    
                    Spacer()
                    
                    if scene.vocabularyIds.count > 0 {
                        Text("\(scene.vocabularyIds.count)語")
                            .font(.caption2)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(4)
                    }
                }
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(UIColor.systemBackground))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(categoryColor.opacity(0.3), lineWidth: 1)
                )
        )
        .onTapGesture {
            onTap()
        }
        .accessibilityElement(children: .combine)
        .accessibilityAddTraits(.isButton)
        .accessibilityLabel("\(scene.title), \(scene.sceneDescription), 進捗\(Int(progress * 100))パーセント")
        .accessibilityHint("タップして学習を開始")
    }
    
    private var categoryBadge: some View {
        Text(scene.category.displayName)
            .font(.caption2)
            .foregroundColor(.white)
            .padding(.horizontal, 6)
            .padding(.vertical, 2)
            .background(categoryColor)
            .cornerRadius(4)
    }
    
    private var categoryColor: Color {
        switch scene.category {
        case .morningAssembly: return .orange
        case .classTime: return .blue
        case .lunchTime: return .green
        case .cleaningTime: return .purple
        case .breakTime: return .pink
        case .homeLife: return .brown
        case .shopping: return .cyan
        case .park: return .mint
        case .lessons: return .indigo
        }
    }
    
    private var categoryIcon: String {
        switch scene.category {
        case .morningAssembly: return "sun.rise"
        case .classTime: return "book"
        case .lunchTime: return "fork.knife"
        case .cleaningTime: return "sparkles"
        case .breakTime: return "figure.run"
        case .homeLife: return "house"
        case .shopping: return "cart"
        case .park: return "tree"
        case .lessons: return "music.note"
        }
    }
}

struct SceneMiniCard: View {
    let scene: LearningScene
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: categoryIcon)
                .font(.title2)
                .foregroundColor(isSelected ? .white : categoryColor)
                .frame(width: 40, height: 40)
                .background(
                    Circle()
                        .fill(isSelected ? categoryColor : categoryColor.opacity(0.2))
                )
            
            RubyText(scene.title, ruby: scene.rubyTitle, fontSize: 12, rubyFontSize: 8, alignment: .center)
                .fontWeight(isSelected ? .semibold : .regular)
                .lineLimit(nil)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 4)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(isSelected ? categoryColor.opacity(0.1) : Color.clear)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(isSelected ? categoryColor : Color.clear, lineWidth: 1)
                )
        )
        .onTapGesture {
            onTap()
        }
        .accessibilityElement(children: .combine)
        .accessibilityAddTraits(.isButton)
        .accessibilityLabel(scene.title)
        .accessibilityValue(isSelected ? "選択中" : "")
    }
    
    private var categoryColor: Color {
        switch scene.category {
        case .morningAssembly: return .orange
        case .classTime: return .blue
        case .lunchTime: return .green
        case .cleaningTime: return .purple
        case .breakTime: return .pink
        case .homeLife: return .brown
        case .shopping: return .cyan
        case .park: return .mint
        case .lessons: return .indigo
        }
    }
    
    private var categoryIcon: String {
        switch scene.category {
        case .morningAssembly: return "sun.rise"
        case .classTime: return "book"
        case .lunchTime: return "fork.knife"
        case .cleaningTime: return "sparkles"
        case .breakTime: return "figure.run"
        case .homeLife: return "house"
        case .shopping: return "cart"
        case .park: return "tree"
        case .lessons: return "music.note"
        }
    }
}

#Preview {
    let scene = LearningScene(
        title: "朝の会",
        rubyTitle: "あさのかい",
        description: "みんなで朝のあいさつをして、一日の始まりです",
        storyContent: "みんなで朝のあいさつをして、健康観察や今日の予定を確認します。",
        order: 1,
        category: .morningAssembly,
        vocabularyIds: [UUID(), UUID(), UUID()]
    )
    
    VStack(spacing: 20) {
        SceneCard(scene: scene, progress: 0.7) {}
        
        HStack(spacing: 12) {
            SceneMiniCard(scene: scene, isSelected: true) {}
            SceneMiniCard(scene: scene, isSelected: false) {}
        }
    }
    .padding()
    .background(Color.gray.opacity(0.1))
}