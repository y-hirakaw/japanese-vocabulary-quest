import Foundation
import Combine
import SwiftData

/// 学習場面データ管理のためのStoreプロトコル
/// 学校生活と日常生活の場面データの状態管理を定義する
@MainActor
protocol SceneStoreProtocol: AnyObject {
    /// 学習場面配列の変更を通知するPublisher
    var scenesPublisher: Published<[LearningScene]>.Publisher { get }
    /// エラー状態の変更を通知するPublisher
    var errorPublisher: Published<Error?>.Publisher { get }
    /// ローディング状態の変更を通知するPublisher
    var isLoadingPublisher: Published<Bool>.Publisher { get }
    
    /// 全ての学習場面を取得
    func fetchAllScenes() async
    
    /// 指定したカテゴリーの学習場面を取得
    /// - Parameter category: 場面カテゴリー
    func fetchScenesByCategory(_ category: SceneCategory) async
    
    /// デフォルトの学習場面データを初期化
    func initializeDefaultScenes() async
}

/// 学習場面データ管理のためのStore実装クラス
/// SVVS アーキテクチャにおいて場面選択とコンテンツ管理を担当する
@MainActor
final class SceneStore: ObservableObject, SceneStoreProtocol {
    /// 共有インスタンス（Singletonパターン）
    static let shared = SceneStore()
    
    /// 現在取得済みの学習場面配列
    @Published private(set) var scenes: [LearningScene] = []
    /// エラー情報（存在する場合）
    @Published private(set) var error: Error?
    /// データ取得中の状態フラグ
    @Published private(set) var isLoading: Bool = false
    
    /// 学習場面配列の変更を通知するPublisher
    var scenesPublisher: Published<[LearningScene]>.Publisher { $scenes }
    /// エラー状態の変更を通知するPublisher
    var errorPublisher: Published<Error?>.Publisher { $error }
    /// ローディング状態の変更を通知するPublisher
    var isLoadingPublisher: Published<Bool>.Publisher { $isLoading }
    
    /// 学習場面データアクセス用のリポジトリ
    private let repository: SceneRepositoryProtocol?
    
    /// Store初期化（privateでSingleton強制）
    /// - Parameters:
    ///   - repository: 場面リポジトリ（テスト用）
    ///   - useMockRepository: モックリポジトリ使用フラグ（デフォルト: true）
    private init(repository: SceneRepositoryProtocol? = nil, useMockRepository: Bool = true) {
        self.repository = useMockRepository ? nil : repository
    }
    
    /// 全ての学習場面を非同期で取得する
    /// リポジトリが利用不可な場合、デフォルトデータを使用する
    func fetchAllScenes() async {
        isLoading = true
        error = nil
        
        guard let repository = repository else {
            if scenes.isEmpty {
                scenes = SceneStore.createDefaultScenes()
            }
            isLoading = false
            return
        }
        
        do {
            let fetchedScenes = try await repository.fetchAll()
            
            if fetchedScenes.isEmpty {
                await initializeDefaultScenes()
            } else {
                scenes = fetchedScenes
            }
        } catch {
            self.error = error
            scenes = SceneStore.createDefaultScenes()
        }
        
        isLoading = false
    }
    
    /// 指定したカテゴリーの学習場面を非同期で取得する
    /// - Parameter category: 場面カテゴリー（朝の会、授業時間等）
    func fetchScenesByCategory(_ category: SceneCategory) async {
        isLoading = true
        error = nil
        
        guard let repository = repository else {
            scenes = SceneStore.createDefaultScenes().filter { $0.category == category }
            isLoading = false
            return
        }
        
        do {
            let fetchedScenes = try await repository.fetchByCategory(category)
            scenes = fetchedScenes
        } catch {
            self.error = error
            scenes = []
        }
        
        isLoading = false
    }
    
    /// デフォルトの学習場面データを初期化し、リポジトリに保存する
    /// リポジトリが利用不可な場合、メモリ上のみに設定する
    func initializeDefaultScenes() async {
        let defaultScenes = SceneStore.createDefaultScenes()
        
        guard let repository = repository else {
            scenes = defaultScenes
            return
        }
        
        do {
            for scene in defaultScenes {
                try await repository.save(scene)
            }
            scenes = defaultScenes
        } catch {
            self.error = error
        }
    }
    
    /// デフォルト学習場面データを生成
    /// 学校生活5場面の基本データを提供
    static nonisolated private func createDefaultScenes() -> [LearningScene] {
        return [
            LearningScene(
                title: "朝の会",
                rubyTitle: "あさのかい",
                description: "みんなで朝のあいさつをして、一日の始まりです",
                storyContent: "みんなで朝のあいさつをして、健康観察や今日の予定を確認します。",
                order: 1,
                category: .morningAssembly
            ),
            LearningScene(
                title: "授業時間",
                rubyTitle: "じゅぎょうじかん",
                description: "みんなで勉強する楽しい時間です",
                storyContent: "先生と一緒に楽しく勉強しましょう。",
                order: 2,
                category: .classTime
            ),
            LearningScene(
                title: "給食時間",
                rubyTitle: "きゅうしょくじかん",
                description: "みんなで美味しい給食を食べる時間です",
                storyContent: "栄養満点の給食をみんなで楽しく食べましょう。",
                order: 3,
                category: .lunchTime
            ),
            LearningScene(
                title: "掃除時間",
                rubyTitle: "そうじじかん",
                description: "みんなで教室をきれいにする時間です",
                storyContent: "使った教室をみんなで協力してきれいにしましょう。",
                order: 4,
                category: .cleaningTime
            ),
            LearningScene(
                title: "休み時間",
                rubyTitle: "やすみじかん",
                description: "友達と楽しく遊ぶ時間です",
                storyContent: "校庭や教室で友達と楽しく遊びましょう。",
                order: 5,
                category: .breakTime
            )
        ]
    }
}