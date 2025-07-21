import Foundation
import SwiftData

/// 語彙データアクセスのためのリポジトリプロトコル
/// SwiftDataを使用した語彙の永続化層を定義する
@MainActor
protocol VocabularyRepositoryProtocol {
    /// すべての語彙を取得
    /// - Returns: 語彙の配列（語彙順でソート済み）
    func fetchAll() async throws -> [Vocabulary]
    
    /// 指定した学習場面の語彙を取得
    /// - Parameter scene: 対象の学習場面
    /// - Returns: 場面に関連付けられた語彙の配列（難易度順でソート済み）
    func fetchByScene(_ scene: LearningScene) async throws -> [Vocabulary]
    
    /// 指定したカテゴリーの語彙を取得
    /// - Parameter category: カテゴリー名
    /// - Returns: カテゴリーに該当する語彙の配列
    func fetchByCategory(_ category: String) async throws -> [Vocabulary]
    
    /// 指定した難易度の語彙を取得
    /// - Parameter difficulty: 難易度レベル
    /// - Returns: 指定難易度の語彙の配列
    func fetchByDifficulty(_ difficulty: Int) async throws -> [Vocabulary]
    
    /// 語彙を保存
    /// - Parameter vocabulary: 保存する語彙データ
    func save(_ vocabulary: Vocabulary) async throws
    
    /// 語彙を削除
    /// - Parameter vocabulary: 削除する語彙データ
    func delete(_ vocabulary: Vocabulary) async throws
}

/// 語彙データアクセスのためのリポジトリ実装クラス
/// SwiftDataを使用してVocabularyモデルのCRUD操作を提供する
@MainActor
final class VocabularyRepository: VocabularyRepositoryProtocol {
    /// SwiftDataのモデルコンテキスト
    private let modelContext: ModelContext
    
    /// リポジトリを初期化
    /// - Parameter modelContext: SwiftDataのモデルコンテキスト
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    /// すべての語彙を取得
    /// - Returns: 語彙の配列（語彙順でソート済み）
    func fetchAll() async throws -> [Vocabulary] {
        let descriptor = FetchDescriptor<Vocabulary>(
            sortBy: [SortDescriptor(\.word, order: .forward)]
        )
        return try modelContext.fetch(descriptor)
    }
    
    /// 指定した学習場面の語彙を取得
    /// - Parameter scene: 対象の学習場面
    /// - Returns: 場面に関連付けられた語彙の配列（難易度順でソート済み）
    func fetchByScene(_ scene: LearningScene) async throws -> [Vocabulary] {
        let vocabularyIds = scene.vocabularyIds
        let descriptor = FetchDescriptor<Vocabulary>(
            predicate: #Predicate<Vocabulary> { vocabulary in
                vocabularyIds.contains(vocabulary.id)
            },
            sortBy: [SortDescriptor(\.difficulty, order: .forward)]
        )
        return try modelContext.fetch(descriptor)
    }
    
    /// 指定したカテゴリーの語彙を取得
    /// - Parameter category: カテゴリー名
    /// - Returns: カテゴリーに該当する語彙の配列
    func fetchByCategory(_ category: String) async throws -> [Vocabulary] {
        let descriptor = FetchDescriptor<Vocabulary>(
            predicate: #Predicate<Vocabulary> { vocabulary in
                vocabulary.category == category
            },
            sortBy: [SortDescriptor(\.word, order: .forward)]
        )
        return try modelContext.fetch(descriptor)
    }
    
    /// 指定した難易度の語彙を取得
    /// - Parameter difficulty: 難易度レベル
    /// - Returns: 指定難易度の語彙の配列
    func fetchByDifficulty(_ difficulty: Int) async throws -> [Vocabulary] {
        let descriptor = FetchDescriptor<Vocabulary>(
            predicate: #Predicate<Vocabulary> { vocabulary in
                vocabulary.difficulty == difficulty
            },
            sortBy: [SortDescriptor(\.word, order: .forward)]
        )
        return try modelContext.fetch(descriptor)
    }
    
    /// 語彙を保存
    /// - Parameter vocabulary: 保存する語彙データ
    func save(_ vocabulary: Vocabulary) async throws {
        modelContext.insert(vocabulary)
        try modelContext.save()
    }
    
    /// 語彙を削除
    /// - Parameter vocabulary: 削除する語彙データ
    func delete(_ vocabulary: Vocabulary) async throws {
        modelContext.delete(vocabulary)
        try modelContext.save()
    }
}