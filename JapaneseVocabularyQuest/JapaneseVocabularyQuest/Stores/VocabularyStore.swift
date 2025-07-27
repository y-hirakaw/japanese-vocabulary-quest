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
    
    /// Store初期化（Singleton用）
    private init() {
        self.repository = nil
    }
    
    /// Store初期化（Repositoryインジェクション用）
    /// - Parameters:
    ///   - repository: 語彙リポジトリ
    ///   - useMockRepository: モックリポジトリ使用フラグ（デフォルト: true）
    init(repository: VocabularyRepositoryProtocol, useMockRepository: Bool = true) {
        self.repository = useMockRepository ? nil : repository
    }
    
    /// 指定した学習場面の語彙を取得する
    /// - Parameter scene: 対象の学習場面
    func fetchVocabularies(for scene: LearningScene) async {
        isLoading = true
        error = nil
        
        if let repository = repository {
            do {
                let fetchedVocabularies = try await repository.fetchByScene(scene)
                vocabularies = fetchedVocabularies
            } catch {
                self.error = error
                vocabularies = []
            }
        } else {
            // Repositoryが未設定の場合はサンプルデータから取得
            let allSampleVocabularies = VocabularyData.allVocabularies
            // 場面に対応するカテゴリー名を取得
            let categoryForScene = getCategoryName(for: scene.category)
            let sceneVocabularies = allSampleVocabularies.filter { $0.category == categoryForScene }
            
            // 場面に関連する語彙を取得、見つからない場合はランダムに5つ選択
            if !sceneVocabularies.isEmpty {
                vocabularies = sceneVocabularies
            } else {
                // フォールバック: ランダムに5つ選択
                vocabularies = Array(allSampleVocabularies.shuffled().prefix(5))
            }
        }
        
        isLoading = false
    }
    
    /// 指定したカテゴリーの語彙を取得する
    /// - Parameter category: カテゴリー名
    func fetchVocabulariesByCategory(_ category: String) async {
        isLoading = true
        error = nil
        
        if let repository = repository {
            do {
                let fetchedVocabularies = try await repository.fetchByCategory(category)
                vocabularies = fetchedVocabularies
            } catch {
                self.error = error
                vocabularies = []
            }
        } else {
            // Repositoryが未設定の場合はサンプルデータから取得
            vocabularies = VocabularyData.vocabularies(for: category)
        }
        
        isLoading = false
    }
    
    /// 全ての語彙を取得する
    func fetchAllVocabularies() async {
        isLoading = true
        error = nil
        
        if let repository = repository {
            do {
                let fetchedVocabularies = try await repository.fetchAll()
                vocabularies = fetchedVocabularies
            } catch {
                self.error = error
                vocabularies = []
            }
        } else {
            // Repositoryが未設定の場合はサンプルデータから取得
            vocabularies = VocabularyData.allVocabularies
        }
        
        isLoading = false
    }
    
    /// 学習場面カテゴリーを語彙カテゴリー名に変換する
    /// - Parameter sceneCategory: 学習場面カテゴリー
    /// - Returns: 対応する語彙カテゴリー名
    private func getCategoryName(for sceneCategory: SceneCategory) -> String {
        switch sceneCategory {
        case .morningAssembly:
            return "朝の会・帰りの会"
        case .classTime:
            return "教室"
        case .lunchTime:
            return "給食"
        case .cleaningTime:
            return "掃除の時間"
        case .breakTime:
            return "休み時間"
        case .homeLife:
            return "家での生活"
        case .shopping:
            return "買い物"
        case .park:
            return "公園・遊び場"
        case .lessons:
            return "習い事"
        }
    }
}
