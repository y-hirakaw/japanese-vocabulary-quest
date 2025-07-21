import Foundation
import SwiftData

/// 学習場面データアクセスのためのリポジトリプロトコル
/// SwiftDataを使用した場面データの永続化層を定義する
@MainActor
protocol SceneRepositoryProtocol {
    /// すべての学習場面を取得
    /// - Returns: 学習場面の配列（順序でソート済み）
    func fetchAll() async throws -> [LearningScene]
    
    /// 指定したカテゴリーの学習場面を取得
    /// - Parameter category: 場面のカテゴリー
    /// - Returns: カテゴリーに該当する学習場面の配列
    func fetchByCategory(_ category: SceneCategory) async throws -> [LearningScene]
    
    /// 指定したIDの学習場面を取得
    /// - Parameter id: 場面ID
    /// - Returns: 該当する学習場面、存在しない場合はnil
    func fetchById(_ id: UUID) async throws -> LearningScene?
    
    /// 学習場面を保存
    /// - Parameter scene: 保存する学習場面データ
    func save(_ scene: LearningScene) async throws
    
    /// 学習場面を削除
    /// - Parameter scene: 削除する学習場面データ
    func delete(_ scene: LearningScene) async throws
}

/// 学習場面データアクセスのためのリポジトリ実装クラス
/// SwiftDataを使用してLearningSceneモデルのCRUD操作を提供する
@MainActor
final class SceneRepository: SceneRepositoryProtocol {
    /// SwiftDataのモデルコンテキスト
    private let modelContext: ModelContext
    
    /// リポジトリを初期化
    /// - Parameter modelContext: SwiftDataのモデルコンテキスト
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    /// すべての学習場面を取得
    /// - Returns: 学習場面の配列（順序でソート済み）
    func fetchAll() async throws -> [LearningScene] {
        let descriptor = FetchDescriptor<LearningScene>(
            sortBy: [SortDescriptor(\.order, order: .forward)]
        )
        return try modelContext.fetch(descriptor)
    }
    
    /// 指定したカテゴリーの学習場面を取得
    /// - Parameter category: 場面のカテゴリー
    /// - Returns: カテゴリーに該当する学習場面の配列
    func fetchByCategory(_ category: SceneCategory) async throws -> [LearningScene] {
        let descriptor = FetchDescriptor<LearningScene>(
            predicate: #Predicate<LearningScene> { scene in
                scene.category == category
            },
            sortBy: [SortDescriptor(\.order, order: .forward)]
        )
        return try modelContext.fetch(descriptor)
    }
    
    /// 指定したIDの学習場面を取得
    /// - Parameter id: 場面ID
    /// - Returns: 該当する学習場面、存在しない場合はnil
    func fetchById(_ id: UUID) async throws -> LearningScene? {
        let descriptor = FetchDescriptor<LearningScene>(
            predicate: #Predicate<LearningScene> { scene in
                scene.id == id
            }
        )
        return try modelContext.fetch(descriptor).first
    }
    
    /// 学習場面を保存
    /// - Parameter scene: 保存する学習場面データ
    func save(_ scene: LearningScene) async throws {
        modelContext.insert(scene)
        try modelContext.save()
    }
    
    /// 学習場面を削除
    /// - Parameter scene: 削除する学習場面データ
    func delete(_ scene: LearningScene) async throws {
        modelContext.delete(scene)
        try modelContext.save()
    }
}