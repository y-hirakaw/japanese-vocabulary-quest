import Foundation
import Combine
import SwiftData

/// 語彙データ管理のためのStoreプロトコル
/// UIとRepository間の状態管理とデータフローを定義する
@MainActor
protocol VocabularyStoreProtocol: AnyObject {
    /// 語彙配列の変更を通知するPublisher
    var vocabulariesPublisher: Published<[Vocabulary]>.Publisher { get }
    /// エラー状態の変更を通知するPublisher
    var errorPublisher: Published<Error?>.Publisher { get }
    /// ローディング状態の変更を通知するPublisher
    var isLoadingPublisher: Published<Bool>.Publisher { get }
    
    /// 指定した学習場面の語彙を取得
    /// - Parameter scene: 対象の学習場面
    func fetchVocabularies(for scene: LearningScene) async
    
    /// 指定したカテゴリーの語彙を取得
    /// - Parameter category: カテゴリー名
    func fetchVocabulariesByCategory(_ category: String) async
    
    /// 全ての語彙を取得
    func fetchAllVocabularies() async
}

/// 語彙データ管理のためのStore実装クラス
/// SVVS アーキテクチャにおいてViewStateとRepository間のデータフローを管理する
@MainActor
final class VocabularyStore: ObservableObject, VocabularyStoreProtocol {
    /// 共有インスタンス（Singletonパターン）
    static let shared = VocabularyStore()
    
    /// 現在取得済みの語彙配列
    @Published private(set) var vocabularies: [Vocabulary] = []
    /// エラー情報（存在する場合）
    @Published private(set) var error: Error?
    /// データ取得中の状態フラグ
    @Published private(set) var isLoading: Bool = false
    
    /// 語彙配列の変更を通知するPublisher
    var vocabulariesPublisher: Published<[Vocabulary]>.Publisher { $vocabularies }
    /// エラー状態の変更を通知するPublisher
    var errorPublisher: Published<Error?>.Publisher { $error }
    /// ローディング状態の変更を通知するPublisher
    var isLoadingPublisher: Published<Bool>.Publisher { $isLoading }
    
    /// 語彙データアクセス用のリポジトリ
    private let repository: VocabularyRepositoryProtocol?
    
    /// Store初期化（privateでSingleton強制）
    /// - Parameters:
    ///   - repository: 語彙リポジトリ（テスト用）
    ///   - useMockRepository: モックリポジトリ使用フラグ（デフォルト: true）
    private init(repository: VocabularyRepositoryProtocol? = nil, useMockRepository: Bool = true) {
        self.repository = useMockRepository ? nil : repository
    }
    
    /// 指定した学習場面の語彙を取得する
    /// - Parameter scene: 対象の学習場面
    func fetchVocabularies(for scene: LearningScene) async {
        isLoading = true
        error = nil
        
        guard let repository = repository else {
            vocabularies = []
            isLoading = false
            return
        }
        
        do {
            let fetchedVocabularies = try await repository.fetchByScene(scene)
            vocabularies = fetchedVocabularies
        } catch {
            self.error = error
            vocabularies = []
        }
        
        isLoading = false
    }
    
    /// 指定したカテゴリーの語彙を取得する
    /// - Parameter category: カテゴリー名
    func fetchVocabulariesByCategory(_ category: String) async {
        isLoading = true
        error = nil
        
        guard let repository = repository else {
            vocabularies = []
            isLoading = false
            return
        }
        
        do {
            let fetchedVocabularies = try await repository.fetchByCategory(category)
            vocabularies = fetchedVocabularies
        } catch {
            self.error = error
            vocabularies = []
        }
        
        isLoading = false
    }
    
    /// 全ての語彙を取得する
    func fetchAllVocabularies() async {
        isLoading = true
        error = nil
        
        guard let repository = repository else {
            vocabularies = []
            isLoading = false
            return
        }
        
        do {
            let fetchedVocabularies = try await repository.fetchAll()
            vocabularies = fetchedVocabularies
        } catch {
            self.error = error
            vocabularies = []
        }
        
        isLoading = false
    }
}
