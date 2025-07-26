import Foundation
import Combine

/// 学習画面の状態管理を行うViewStateクラス
/// 語彙学習セッション中の進捗や回答状況、学習成果を管理する
@MainActor
@Observable
final class LearningViewState {
    /// 現在学習中の場面
    var currentScene: LearningScene?
    /// 学習対象の語彙一覧
    var vocabularies: [Vocabulary] = []
    /// 現在の語彙インデックス
    var currentVocabularyIndex: Int = 0
    /// データ読み込み中フラグ
    var isLoading: Bool = false
    /// エラー情報
    var error: Error?
    /// 学習セッション完了フラグ
    var isCompleted: Bool = false
    /// 回答表示フラグ
    var showAnswer: Bool = false
    /// ユーザーの入力回答
    var userAnswer: String = ""
    /// 正答数
    var correctAnswersCount: Int = 0
    /// 総回答数
    var totalAnswersCount: Int = 0
    /// クイズモードが有効かどうか
    var isQuizMode: Bool = true
    /// 現在のクイズタイプ
    var currentQuizType: QuizModeView.QuizType = .imageToWord
    /// クイズの選択肢
    var quizChoices: [Vocabulary] = []
    /// 選択されたクイズ選択肢のインデックス
    var selectedChoiceIndex: Int?
    /// 回答が提出されたかどうか
    var isAnswerSubmitted: Bool = false
    
    /// 語彙データ管理Store
    private let vocabularyStore: any VocabularyStoreProtocol
    /// ユーザーデータ管理Store
    private let userStore: any UserStoreProtocol
    /// Combine購読管理用のCancellableセット
    private var cancellables = Set<AnyCancellable>()
    
    /// ViewState初期化
    /// - Parameters:
    ///   - vocabularyStore: 語彙Store（テスト用）
    ///   - userStore: ユーザーStore（テスト用）
    init(vocabularyStore: (any VocabularyStoreProtocol)? = nil,
         userStore: (any UserStoreProtocol)? = nil) {
        self.vocabularyStore = vocabularyStore ?? VocabularyStore.shared
        self.userStore = userStore ?? UserStore.shared
        setupStoreBindings()
    }
    
    /// Storeの状態変更を購読してViewの状態を更新するバインディング設定
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
    
    /// 指定した学習場面での語彙学習を開始
    /// - Parameter scene: 学習する場面
    func startLearning(scene: LearningScene) async {
        currentScene = scene
        await vocabularyStore.fetchVocabularies(for: scene)
        if isQuizMode && !vocabularies.isEmpty {
            generateQuizChoices()
        }
    }
    
    /// ユーザーの回答を処理し、正誤判定を行って進捗を更新
    /// - Parameter answer: ユーザーの回答
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
    
    /// クイズの選択肢を選択したときの処理
    /// - Parameter index: 選択肢のインデックス
    func selectQuizChoice(_ index: Int) async {
        guard isQuizMode, !isAnswerSubmitted else { return }
        guard index < quizChoices.count else { return }
        
        selectedChoiceIndex = index
        isAnswerSubmitted = true
        
        let selectedVocabulary = quizChoices[index]
        let isCorrect = selectedVocabulary.id == currentVocabulary?.id
        
        if isCorrect {
            correctAnswersCount += 1
        }
        totalAnswersCount += 1
        
        if let currentVocabulary = currentVocabulary {
            await userStore.updateUserProgress(vocabularyId: currentVocabulary.id, isCorrect: isCorrect)
        }
        
        showAnswer = true
    }
    
    /// 次の語彙に進む、または学習セッションを完了する
    func nextVocabulary() {
        showAnswer = false
        userAnswer = ""
        selectedChoiceIndex = nil
        isAnswerSubmitted = false
        
        if currentVocabularyIndex < vocabularies.count - 1 {
            currentVocabularyIndex += 1
            if isQuizMode {
                // クイズタイプをランダムに切り替え
                currentQuizType = Bool.random() ? .imageToWord : .wordToImage
                generateQuizChoices()
            }
        } else {
            isCompleted = true
        }
    }
    
    /// 学習セッションの状態をリセットして初期状態に戻す
    func resetLearningSession() {
        currentVocabularyIndex = 0
        isCompleted = false
        showAnswer = false
        userAnswer = ""
        correctAnswersCount = 0
        totalAnswersCount = 0
        selectedChoiceIndex = nil
        isAnswerSubmitted = false
        quizChoices = []
        if isQuizMode && !vocabularies.isEmpty {
            generateQuizChoices()
        }
    }
    
    /// 現在の場面で学習を再開始する
    func restartLearning() async {
        resetLearningSession()
        if let scene = currentScene {
            await vocabularyStore.fetchVocabularies(for: scene)
        }
    }
    
    /// 回答の正誤を判定する
    /// 漢字、読み、意味のいずれかが正解の場合、正答とする
    /// - Parameters:
    ///   - answer: ユーザーの回答
    ///   - vocabulary: 対象の語彙
    /// - Returns: 正答かどうか
    private func checkAnswer(_ answer: String, for vocabulary: Vocabulary) -> Bool {
        let cleanAnswer = answer.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let correctAnswers = [
            vocabulary.word.lowercased(),
            vocabulary.reading.lowercased(),
            vocabulary.meaning.lowercased()
        ]
        
        return correctAnswers.contains(cleanAnswer)
    }
    
    /// 現在表示中の語彙を取得
    var currentVocabulary: Vocabulary? {
        guard currentVocabularyIndex < vocabularies.count else { return nil }
        return vocabularies[currentVocabularyIndex]
    }
    
    /// 学習セッションの進捗率（0.0-1.0）
    var progress: Double {
        guard vocabularies.count > 0 else { return 0.0 }
        return Double(currentVocabularyIndex + 1) / Double(vocabularies.count)
    }
    
    /// 回答正答率（0.0-1.0）
    var accuracyRate: Double {
        guard totalAnswersCount > 0 else { return 0.0 }
        return Double(correctAnswersCount) / Double(totalAnswersCount)
    }
    
    /// 残りの語彙数
    var remainingVocabularies: Int {
        return max(0, vocabularies.count - currentVocabularyIndex - 1)
    }
    
    /// クイズの選択肢を生成する
    private func generateQuizChoices() {
        guard let currentVocabulary = currentVocabulary else { return }
        
        // 現在の語彙と同じカテゴリーから選択肢を選ぶ
        let sameCategories = vocabularies.filter { $0.category == currentVocabulary.category && $0.id != currentVocabulary.id }
        
        // ダミー選択肢を3つ選ぶ
        var dummies: [Vocabulary] = []
        if sameCategories.count >= 3 {
            // 同じカテゴリーから3つランダムに選ぶ
            dummies = Array(sameCategories.shuffled().prefix(3))
        } else {
            // 足りない場合は全語彙から選ぶ
            dummies = Array(sameCategories)
            let otherVocabularies = vocabularies.filter { $0.id != currentVocabulary.id && !sameCategories.contains($0) }
            let needed = 3 - dummies.count
            dummies += Array(otherVocabularies.shuffled().prefix(needed))
        }
        
        // 正解を含めてシャッフル
        quizChoices = ([currentVocabulary] + dummies).shuffled()
    }
}