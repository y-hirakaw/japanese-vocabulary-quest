import Foundation
import Combine
import SwiftData

@MainActor
protocol VocabularyStoreProtocol: ObservableObject {
    var vocabulariesPublisher: Published<[Vocabulary]>.Publisher { get }
    var errorPublisher: Published<Error?>.Publisher { get }
    var isLoadingPublisher: Published<Bool>.Publisher { get }
    
    func fetchVocabularies(for scene: LearningScene) async
    func fetchVocabulariesByCategory(_ category: String) async
    func fetchAllVocabularies() async
}

@MainActor
final class VocabularyStore: ObservableObject, VocabularyStoreProtocol {
    nonisolated static let shared = VocabularyStore(useMockRepository: true)
    
    @Published var vocabularies: [Vocabulary] = []
    @Published var error: Error?
    @Published var isLoading: Bool = false
    
    var vocabulariesPublisher: Published<[Vocabulary]>.Publisher { $vocabularies }
    var errorPublisher: Published<Error?>.Publisher { $error }
    var isLoadingPublisher: Published<Bool>.Publisher { $isLoading }
    
    nonisolated private let repository: VocabularyRepositoryProtocol?
    
    /// Store初期化（nonisolated）
    /// useMockRepositoryの場合はnil設定（テスト・デモ用）
    nonisolated init(repository: VocabularyRepositoryProtocol? = nil, modelContext: ModelContext? = nil, useMockRepository: Bool = false) {
        if useMockRepository {
            self.repository = nil
        } else {
            self.repository = repository
        }
    }
    
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
