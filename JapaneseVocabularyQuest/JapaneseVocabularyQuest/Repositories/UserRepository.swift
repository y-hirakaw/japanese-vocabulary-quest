import Foundation
import SwiftData

/// ユーザーデータアクセスのためのリポジトリプロトコル
/// SwiftDataを使用したユーザー管理と学習進捗の永続化層を定義する
@MainActor
protocol UserRepositoryProtocol {
    /// すべてのユーザーを取得
    /// - Returns: ユーザーの配列（作成日順でソート済み）
    func fetchAll() async throws -> [User]
    
    /// 指定したIDのユーザーを取得
    /// - Parameter id: ユーザーID
    /// - Returns: 該当するユーザー、存在しない場合はnil
    func fetchById(_ id: UUID) async throws -> User?
    
    /// 現在のユーザーを取得（最後に作成されたユーザー）
    /// - Returns: 現在のユーザー、存在しない場合はnil
    func fetchCurrentUser() async throws -> User?
    
    /// ユーザーを保存
    /// - Parameter user: 保存するユーザーデータ
    func save(_ user: User) async throws
    
    /// ユーザーを削除
    /// - Parameter user: 削除するユーザーデータ
    func delete(_ user: User) async throws
    
    /// 学習進捗を更新
    /// - Parameter progress: 更新する学習進捗データ
    func updateProgress(_ progress: LearningProgress) async throws
}

/// ユーザーデータアクセスのためのリポジトリ実装クラス
/// SwiftDataを使用してUserモデルと学習進捗のCRUD操作を提供する
@MainActor
final class UserRepository: UserRepositoryProtocol {
    /// SwiftDataのモデルコンテキスト
    private let modelContext: ModelContext
    
    /// リポジトリを初期化
    /// - Parameter modelContext: SwiftDataのモデルコンテキスト
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    /// すべてのユーザーを取得
    /// - Returns: ユーザーの配列（作成日順でソート済み）
    func fetchAll() async throws -> [User] {
        let descriptor = FetchDescriptor<User>(
            sortBy: [SortDescriptor(\.createdAt, order: .forward)]
        )
        return try modelContext.fetch(descriptor)
    }
    
    /// 指定したIDのユーザーを取得
    /// - Parameter id: ユーザーID
    /// - Returns: 該当するユーザー、存在しない場合はnil
    func fetchById(_ id: UUID) async throws -> User? {
        let descriptor = FetchDescriptor<User>(
            predicate: #Predicate<User> { user in
                user.id == id
            }
        )
        return try modelContext.fetch(descriptor).first
    }
    
    /// 現在のユーザーを取得（最後に作成されたユーザー）
    /// - Returns: 現在のユーザー、存在しない場合はnil
    func fetchCurrentUser() async throws -> User? {
        let descriptor = FetchDescriptor<User>(
            sortBy: [SortDescriptor(\.createdAt, order: .reverse)]
        )
        return try modelContext.fetch(descriptor).first
    }
    
    /// ユーザーを保存
    /// - Parameter user: 保存するユーザーデータ
    func save(_ user: User) async throws {
        modelContext.insert(user)
        try modelContext.save()
    }
    
    /// ユーザーを削除
    /// - Parameter user: 削除するユーザーデータ
    func delete(_ user: User) async throws {
        modelContext.delete(user)
        try modelContext.save()
    }
    
    /// 学習進捗を更新
    /// - Parameter progress: 更新する学習進捗データ
    func updateProgress(_ progress: LearningProgress) async throws {
        modelContext.insert(progress)
        try modelContext.save()
    }
}