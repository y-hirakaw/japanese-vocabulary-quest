import Foundation
import Combine

/// 場面選択画面の状態管理を行うViewStateクラス
/// 学習場面の表示とカテゴリー選択、進捗状況の管理を担当する
@MainActor
@Observable
final class SceneSelectionViewState {
    /// 表示する学習場面一覧
    var scenes: [LearningScene] = []
    /// データ読み込み中フラグ
    var isLoading: Bool = false
    /// エラー情報
    var error: Error?
    /// 現在選択中のカテゴリー
    var selectedCategory: SceneCategory = .morningAssembly
    
    /// 学習場面データ管理Store
    private let sceneStore: any SceneStoreProtocol
    /// ユーザーデータ管理Store
    private let userStore: any UserStoreProtocol
    /// Combine購読管理用のCancellableセット
    private var cancellables = Set<AnyCancellable>()
    
    /// ViewState初期化
    /// - Parameters:
    ///   - sceneStore: 学習場面Store（テスト用）
    ///   - userStore: ユーザーStore（テスト用）
    init(sceneStore: (any SceneStoreProtocol)? = nil,
         userStore: (any UserStoreProtocol)? = nil) {
        self.sceneStore = sceneStore ?? SceneStore.shared
        self.userStore = userStore ?? UserStore.shared
        setupStoreBindings()
    }
    
    /// Storeの状態変更を購読してViewの状態を更新するバインディング設定
    private func setupStoreBindings() {
        sceneStore.scenesPublisher
            .sink { [weak self] scenes in
                self?.scenes = scenes
            }
            .store(in: &cancellables)
        
        sceneStore.isLoadingPublisher
            .sink { [weak self] isLoading in
                self?.isLoading = isLoading
            }
            .store(in: &cancellables)
        
        sceneStore.errorPublisher
            .sink { [weak self] error in
                self?.error = error
            }
            .store(in: &cancellables)
    }
    
    /// 画面表示時の初期化処理
    /// 全ての学習場面データを取得する
    func onAppear() async {
        await sceneStore.fetchAllScenes()
    }
    
    /// 指定したカテゴリーを選択し、そのカテゴリーの場面を取得
    /// - Parameter category: 選択するカテゴリー
    func selectCategory(_ category: SceneCategory) async {
        selectedCategory = category
        await sceneStore.fetchScenesByCategory(category)
    }
    
    /// 学習場面データを再読み込みして更新する
    func refreshScenes() async {
        await sceneStore.fetchAllScenes()
    }
    
    /// 学校生活カテゴリーの学習場面一覧をフィルタリングして取得
    var schoolLifeScenes: [LearningScene] {
        scenes.filter { scene in
            [SceneCategory.morningAssembly, .classTime, .lunchTime, .cleaningTime, .breakTime].contains(scene.category)
        }
    }
    
    /// 日常生活カテゴリーの学習場面一覧をフィルタリングして取得
    var dailyLifeScenes: [LearningScene] {
        scenes.filter { scene in
            [SceneCategory.homeLife, .shopping, .park, .lessons].contains(scene.category)
        }
    }
    
    /// 指定した学習場面の進捗率を取得
    /// 現在は仮実装で、0.0を返す
    /// - Parameter scene: 対象の学習場面
    /// - Returns: 進捗率（0.0-1.0）
    func getProgress(for scene: LearningScene) -> Double {
        return 0.0
    }
}