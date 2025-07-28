import Foundation
import Combine

/// ホーム画面の状態管理を行うViewStateクラス
/// ユーザー情報とゲーム状態の表示に必要な状態とロジックを管理する
@MainActor
@Observable
final class HomeViewState {
    /// 現在ログイン中のユーザー
    var currentUser: User?
    /// データ読み込み中フラグ
    var isLoading: Bool = false
    /// エラー情報
    var error: Error?
    /// ユーザー作成画面の表示フラグ
    var showUserCreation: Bool = false
    
    /// ユーザーデータ管理Store
    private let userStore: any UserStoreProtocol
    /// 学習場面データ管理Store
    private let sceneStore: any SceneStoreProtocol
    /// Combine購読管理用のCancellableセット
    private var cancellables = Set<AnyCancellable>()
    
    /// ViewState初期化
    /// - Parameters:
    ///   - userStore: ユーザーStore
    ///   - sceneStore: 学習場面Store（オプショナル、必要な場合のみ）
    init(userStore: any UserStoreProtocol,
         sceneStore: (any SceneStoreProtocol)? = nil) {
        self.userStore = userStore
        self.sceneStore = sceneStore ?? SceneStore.shared
        setupStoreBindings()
    }
    
    /// Storeの状態変更を購読してViewの状態を更新するバインディング設定
    private func setupStoreBindings() {
        userStore.currentUserPublisher
            .sink { [weak self] user in
                self?.currentUser = user
                self?.showUserCreation = user == nil
            }
            .store(in: &cancellables)
        
        userStore.isLoadingPublisher
            .sink { [weak self] isLoading in
                self?.isLoading = isLoading
            }
            .store(in: &cancellables)
        
        userStore.errorPublisher
            .sink { [weak self] error in
                self?.error = error
            }
            .store(in: &cancellables)
    }
    
    /// 画面表示時の初期化処理
    /// ユーザー情報と学習場面データを取得し、必要に応じてユーザー作成画面を表示する
    func onAppear() async {
        await userStore.fetchCurrentUser()
        if currentUser == nil {
            showUserCreation = true
        }
        await sceneStore.fetchAllScenes()
    }
    
    /// 新しいユーザーを作成し、ユーザー作成画面を閉じる
    /// - Parameter name: ユーザー名
    func createUser(name: String) async {
        await userStore.createUser(name: name)
        showUserCreation = false
    }
    
    /// 現在のレベルでの進捗率（0.0-1.0）を計算
    /// レベル上昇に必要なポイントに対する現在のポイントの割合
    var userLevelProgress: Double {
        guard let user = currentUser else { return 0.0 }
        let pointsForCurrentLevel = user.level * 100
        let pointsForNextLevel = (user.level + 1) * 100
        let progressPoints = max(0, user.totalPoints - pointsForCurrentLevel)
        let totalLevelPoints = pointsForNextLevel - pointsForCurrentLevel
        return Double(progressPoints) / Double(totalLevelPoints)
    }
    
    /// 次のレベルに到達するために必要な残りポイント数
    var nextLevelPoints: Int {
        guard let user = currentUser else { return 100 }
        return (user.level + 1) * 100 - user.totalPoints
    }
}