import Foundation
import Combine
import SwiftData

@MainActor
protocol UserStoreProtocol: ObservableObject {
    var currentUserPublisher: Published<User?>.Publisher { get }
    var errorPublisher: Published<Error?>.Publisher { get }
    var isLoadingPublisher: Published<Bool>.Publisher { get }
    
    func fetchCurrentUser() async
    func createUser(name: String) async
    func updateUserProgress(vocabularyId: UUID, isCorrect: Bool) async
}

@MainActor
final class UserStore: ObservableObject, UserStoreProtocol {
    nonisolated static let shared = UserStore(useMockRepository: true)
    
    @Published var currentUser: User?
    @Published var error: Error?
    @Published var isLoading: Bool = false
    
    var currentUserPublisher: Published<User?>.Publisher { $currentUser }
    var errorPublisher: Published<Error?>.Publisher { $error }
    var isLoadingPublisher: Published<Bool>.Publisher { $isLoading }
    
    nonisolated private let repository: UserRepositoryProtocol?
    
    /// Store初期化（nonisolated）
    /// useMockRepositoryの場合はnil設定（テスト・デモ用）
    nonisolated init(repository: UserRepositoryProtocol? = nil, modelContext: ModelContext? = nil, useMockRepository: Bool = false) {
        if useMockRepository {
            self.repository = nil
        } else {
            self.repository = repository
        }
    }
    
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