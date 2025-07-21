import Foundation
import Combine

@MainActor
@Observable
final class LearningViewState {
    var currentScene: LearningScene?
    var vocabularies: [Vocabulary] = []
    var currentVocabularyIndex: Int = 0
    var isLoading: Bool = false
    var error: Error?
    var isCompleted: Bool = false
    var showAnswer: Bool = false
    var userAnswer: String = ""
    var correctAnswersCount: Int = 0
    var totalAnswersCount: Int = 0
    
    private let vocabularyStore: any VocabularyStoreProtocol
    private let userStore: any UserStoreProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(vocabularyStore: any VocabularyStoreProtocol = VocabularyStore.shared,
         userStore: any UserStoreProtocol = UserStore.shared) {
        self.vocabularyStore = vocabularyStore
        self.userStore = userStore
        setupStoreBindings()
    }
    
    private func setupStoreBindings() {
        vocabularyStore.vocabulariesPublisher
            .sink { [weak self] vocabularies in
                self?.vocabularies = vocabularies
                self?.resetLearningSession()
            }
            .store(in: &cancellables)
        
        vocabularyStore.isLoadingPublisher
            .sink { [weak self] isLoading in
                self?.isLoading = isLoading
            }
            .store(in: &cancellables)
        
        vocabularyStore.errorPublisher
            .sink { [weak self] error in
                self?.error = error
            }
            .store(in: &cancellables)
    }
    
    func startLearning(scene: LearningScene) async {
        currentScene = scene
        await vocabularyStore.fetchVocabularies(for: scene)
    }
    
    func submitAnswer(_ answer: String) async {
        guard let currentVocabulary = currentVocabulary else { return }
        
        userAnswer = answer
        let isCorrect = checkAnswer(answer, for: currentVocabulary)
        
        if isCorrect {
            correctAnswersCount += 1
        }
        totalAnswersCount += 1
        
        await userStore.updateUserProgress(vocabularyId: currentVocabulary.id, isCorrect: isCorrect)
        
        showAnswer = true
    }
    
    func nextVocabulary() {
        showAnswer = false
        userAnswer = ""
        
        if currentVocabularyIndex < vocabularies.count - 1 {
            currentVocabularyIndex += 1
        } else {
            isCompleted = true
        }
    }
    
    func resetLearningSession() {
        currentVocabularyIndex = 0
        isCompleted = false
        showAnswer = false
        userAnswer = ""
        correctAnswersCount = 0
        totalAnswersCount = 0
    }
    
    func restartLearning() async {
        resetLearningSession()
        if let scene = currentScene {
            await vocabularyStore.fetchVocabularies(for: scene)
        }
    }
    
    private func checkAnswer(_ answer: String, for vocabulary: Vocabulary) -> Bool {
        let cleanAnswer = answer.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let correctAnswers = [
            vocabulary.word.lowercased(),
            vocabulary.reading.lowercased(),
            vocabulary.meaning.lowercased()
        ]
        
        return correctAnswers.contains(cleanAnswer)
    }
    
    var currentVocabulary: Vocabulary? {
        guard currentVocabularyIndex < vocabularies.count else { return nil }
        return vocabularies[currentVocabularyIndex]
    }
    
    var progress: Double {
        guard vocabularies.count > 0 else { return 0.0 }
        return Double(currentVocabularyIndex + 1) / Double(vocabularies.count)
    }
    
    var accuracyRate: Double {
        guard totalAnswersCount > 0 else { return 0.0 }
        return Double(correctAnswersCount) / Double(totalAnswersCount)
    }
    
    var remainingVocabularies: Int {
        return max(0, vocabularies.count - currentVocabularyIndex - 1)
    }
}