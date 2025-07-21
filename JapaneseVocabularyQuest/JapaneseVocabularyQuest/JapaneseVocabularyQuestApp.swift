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

    var body: some SwiftUI.Scene {  // 明示的にSwiftUI.Sceneを指定
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
