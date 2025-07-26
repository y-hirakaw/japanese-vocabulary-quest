import SwiftUI
import SwiftData

/// ことばクエストアプリのメインエントリーポイント
/// SwiftDataとSwiftUIの統合を管理
@main
struct JapaneseVocabularyQuestApp: App {
    var sharedModelContainer: ModelContainer = {
        // SwiftDataスキーマの定義
        let schema = Schema([
            User.self,
            Vocabulary.self,
            LearningScene.self,
            LearningProgress.self,
            Character.self,
            Achievement.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    @State private var isInitialized = false

    var body: some SwiftUI.Scene {  // 明示的にSwiftUI.Sceneを指定
        WindowGroup {
            ContentView()
                .task {
                    if !isInitialized {
                        await initializeData()
                        isInitialized = true
                    }
                }
        }
        .modelContainer(sharedModelContainer)
    }
    
    /// 初期データを設定
    @MainActor
    private func initializeData() async {
        let modelContext = sharedModelContainer.mainContext
        
        // 語彙データの初期化
        let vocabularyManager = VocabularyDataManager(modelContext: modelContext)
        do {
            try await vocabularyManager.setupInitialDataIfNeeded()
        } catch {
            print("語彙データの初期化に失敗しました: \(error)")
        }
        
        // 場面データの初期化
        let sceneManager = SceneDataManager(modelContext: modelContext)
        do {
            try await sceneManager.setupInitialDataIfNeeded()
        } catch {
            print("場面データの初期化に失敗しました: \(error)")
        }
    }
}
