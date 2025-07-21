import Foundation
import Combine
import SwiftData

/// ユーザーデータ管理のためのStoreプロトコル
/// ユーザー認証、プロフィール、学習進捗の状態管理を定義する
@MainActor
protocol UserStoreProtocol: AnyObject {
    /// 現在のユーザー情報の変更を通知するPublisher
    var currentUserPublisher: Published<User?>.Publisher { get }
    /// エラー状態の変更を通知するPublisher
    var errorPublisher: Published<Error?>.Publisher { get }
    /// ローディング状態の変更を通知するPublisher
    var isLoadingPublisher: Published<Bool>.Publisher { get }
    
    /// 現在のユーザー情報を取得
    func fetchCurrentUser() async
    
    /// 新しいユーザーを作成
    /// - Parameter name: ユーザー名
    func createUser(name: String) async
    
    /// ユーザーの学習進捗を更新
    /// - Parameters:
    ///   - vocabularyId: 語彙ID
    ///   - isCorrect: 正答かどうか
    func updateUserProgress(vocabularyId: UUID, isCorrect: Bool) async
}

/// ユーザーデータ管理のためのStore実装クラス
/// SVVS アーキテクチャにおいてユーザー関連データの状態を管理する
@MainActor
final class UserStore: ObservableObject, UserStoreProtocol {
    /// 共有インスタンス（Singletonパターン）
    static let shared = UserStore()
    
    /// 現在ログイン中のユーザー
    @Published private(set) var currentUser: User?
    /// エラー情報（存在する場合）
    @Published private(set) var error: Error?
    /// データ処理中の状態フラグ
    @Published private(set) var isLoading: Bool = false
    
    /// 現在のユーザー情報の変更を通知するPublisher
    var currentUserPublisher: Published<User?>.Publisher { $currentUser }
    /// エラー状態の変更を通知するPublisher
    var errorPublisher: Published<Error?>.Publisher { $error }
    /// ローディング状態の変更を通知するPublisher
    var isLoadingPublisher: Published<Bool>.Publisher { $isLoading }
    
    /// ユーザーデータアクセス用のリポジトリ
    private let repository: UserRepositoryProtocol?
    
    /// Store初期化（privateでSingleton強制）
    /// - Parameters:
    ///   - repository: ユーザーリポジトリ（テスト用）
    ///   - useMockRepository: モックリポジトリ使用フラグ（デフォルト: true）
    private init(repository: UserRepositoryProtocol? = nil, useMockRepository: Bool = true) {
        self.repository = useMockRepository ? nil : repository
    }
    
    /// 現在のユーザー情報を取得する
    func fetchCurrentUser() async {
        isLoading = true
        error = nil
        
        guard let repository = repository else {
            currentUser = nil
            isLoading = false
            return
        }
        
        do {
            currentUser = try await repository.fetchCurrentUser()
        } catch {
            self.error = error
            currentUser = nil
        }
        
        isLoading = false
    }
    
    /// 新しいユーザーを作成する
    /// - Parameter name: ユーザー名
    func createUser(name: String) async {
        isLoading = true
        error = nil
        
        let newUser = User(name: name)
        currentUser = newUser
        
        guard let repository = repository else {
            isLoading = false
            return
        }
        
        do {
            try await repository.save(newUser)
        } catch {
            self.error = error
        }
        
        isLoading = false
    }
    
    /// ユーザーの学習進捗を更新し、ポイントとレベルを調整する
    /// - Parameters:
    ///   - vocabularyId: 語彙ID
    ///   - isCorrect: 正答かどうか
    func updateUserProgress(vocabularyId: UUID, isCorrect: Bool) async {
        guard let user = currentUser else { return }
        guard let repository = repository else { return }
        
        error = nil
        
        do {
            var progress = user.learningProgress.first { $0.vocabularyId == vocabularyId }
            
            if progress == nil {
                progress = LearningProgress(userId: user.id, vocabularyId: vocabularyId)
                user.learningProgress.append(progress!)
            }
            
            progress?.recordAnswer(isCorrect: isCorrect)
            
            if isCorrect {
                user.totalPoints += progress?.masteryLevel ?? 1
            }
            
            try await repository.updateProgress(progress!)
        } catch {
            self.error = error
        }
    }
}