import Foundation
import SwiftData

/// 学習場面データの初期化と管理を行うマネージャー
/// アプリ起動時に初期場面データをデータベースに投入する責任を持つ
@MainActor
final class SceneDataManager {
    private let modelContext: ModelContext
    
    /// 初期化
    /// - Parameter modelContext: SwiftDataのモデルコンテキスト
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    /// 初期場面データを設定
    /// データベースが空の場合のみ、初期データを投入する
    func setupInitialDataIfNeeded() async throws {
        // 既存データの確認
        let descriptor = FetchDescriptor<LearningScene>()
        let existingScenes = try modelContext.fetch(descriptor)
        
        // データが既に存在する場合はスキップ
        if !existingScenes.isEmpty {
            print("場面データは既に存在します。スキップします。")
            return
        }
        
        print("初期場面データを投入します...")
        
        // まず語彙データを取得してIDマッピングを作成
        let vocabularyDescriptor = FetchDescriptor<Vocabulary>()
        let allVocabularies = try modelContext.fetch(vocabularyDescriptor)
        
        // カテゴリー別に語彙IDをグループ化
        var vocabularyIdsByCategory: [String: [UUID]] = [:]
        for vocabulary in allVocabularies {
            if vocabularyIdsByCategory[vocabulary.category] == nil {
                vocabularyIdsByCategory[vocabulary.category] = []
            }
            vocabularyIdsByCategory[vocabulary.category]?.append(vocabulary.id)
        }
        
        // 初期データの投入
        let initialScenes = createInitialScenes(vocabularyIdsByCategory: vocabularyIdsByCategory)
        for scene in initialScenes {
            modelContext.insert(scene)
        }
        
        try modelContext.save()
        print("初期場面データを\(initialScenes.count)件投入しました。")
    }
    
    /// 初期場面データを生成
    /// - Parameter vocabularyIdsByCategory: カテゴリー別の語彙IDマッピング
    /// - Returns: 初期場面データの配列
    private func createInitialScenes(vocabularyIdsByCategory: [String: [UUID]]) -> [LearningScene] {
        return [
            // 教室
            LearningScene(
                title: "教室",
                rubyTitle: "｜教室《きょうしつ》",
                description: "授業中の教室の様子を学びます",
                storyContent: "朝、｜教室《きょうしつ》に入ると、｜先生《せんせい》が｜黒板《こくばん》に｜今日《きょう》の｜予定《よてい》を書いていました。みんな｜筆箱《ふでばこ》から｜鉛筆《えんぴつ》を出して、｜教科書《きょうかしょ》を｜開《ひら》きます。",
                order: 1,
                category: .classTime,
                vocabularyIds: vocabularyIdsByCategory["教室"] ?? [],
                titleEn: "Classroom",
                descriptionEn: "Learn about classroom activities",
                culturalNote: "日本の教室では、生徒が掃除をすることが一般的です。"
            ),
            
            // 給食
            LearningScene(
                title: "給食",
                rubyTitle: "｜給食《きゅうしょく》",
                description: "みんなで食べる給食の時間",
                storyContent: "｜給食《きゅうしょく》の｜時間《じかん》になりました。｜当番《とうばん》が｜配膳《はいぜん》をします。｜今日《きょう》の｜献立《こんだて》はカレーライスです。みんなで「いただきます」と言ってから食べ始めます。",
                order: 2,
                category: .lunchTime,
                vocabularyIds: vocabularyIdsByCategory["給食"] ?? [],
                titleEn: "School Lunch",
                descriptionEn: "Learn about school lunch time",
                culturalNote: "日本の学校では、生徒が配膳を手伝います。"
            ),
            
            // 休み時間
            LearningScene(
                title: "休み時間",
                rubyTitle: "｜休《やす》み｜時間《じかん》",
                description: "友達と遊ぶ楽しい時間",
                storyContent: "チャイムが鳴って、｜休《やす》み｜時間《じかん》になりました。｜校庭《こうてい》で｜鬼《おに》ごっこをする子、｜図書室《としょしつ》で｜本《ほん》を読む子、なわとびの｜練習《れんしゅう》をする子もいます。",
                order: 3,
                category: .breakTime,
                vocabularyIds: vocabularyIdsByCategory["休み時間"] ?? [],
                titleEn: "Break Time",
                descriptionEn: "Learn about break time activities",
                culturalNote: "日本の学校では、短い休み時間でも外で遊ぶことが推奨されています。"
            ),
            
            // 掃除の時間
            LearningScene(
                title: "掃除の時間",
                rubyTitle: "｜掃除《そうじ》の｜時間《じかん》",
                description: "みんなで学校をきれいにする時間",
                storyContent: "｜掃除《そうじ》の｜時間《じかん》です。｜当番《とうばん》を｜決《き》めて、ほうきで｜床《ゆか》を｜掃《は》いたり、｜雑巾《ぞうきん》で｜机《つくえ》を｜拭《ふ》いたりします。ちりとりでゴミを｜集《あつ》めます。",
                order: 4,
                category: .cleaningTime,
                vocabularyIds: vocabularyIdsByCategory["掃除の時間"] ?? [],
                titleEn: "Cleaning Time",
                descriptionEn: "Learn about cleaning activities",
                culturalNote: "日本の学校では、生徒自身が教室を掃除することで責任感を学びます。"
            ),
            
            // 朝の会・帰りの会
            LearningScene(
                title: "朝の会・帰りの会",
                rubyTitle: "｜朝《あさ》の｜会《かい》・｜帰《かえ》りの｜会《かい》",
                description: "一日の始まりと終わりの大切な時間",
                storyContent: "｜朝《あさ》の｜会《かい》で｜日直《にっちょく》が｜号令《ごうれい》をかけます。｜先生《せんせい》が｜出席《しゅっせき》を｜取《と》り、｜連絡帳《れんらくちょう》を｜確認《かくにん》します。｜帰《かえ》りの｜会《かい》では｜明日《あした》の｜予定《よてい》を｜聞《き》いてから｜下校《げこう》します。",
                order: 5,
                category: .morningAssembly,
                vocabularyIds: vocabularyIdsByCategory["朝の会・帰りの会"] ?? [],
                titleEn: "Morning and Closing Meeting",
                descriptionEn: "Learn about daily meetings",
                culturalNote: "日本の学校では、朝の会と帰りの会で一日の活動を共有します。"
            )
        ]
    }
}