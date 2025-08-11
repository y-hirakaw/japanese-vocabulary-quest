import Testing
import SwiftData
import Foundation
@testable import JapaneseVocabularyQuest

/// 基本的なテストスイート
/// プロジェクトの基本機能を素早く検証する
struct BasicTests {
    
    @Test("基本的なモデル作成テスト")
    func testBasicModelCreation() throws {
        let user = User(name: "テストユーザー")
        #expect(user.name == "テストユーザー")
        #expect(user.level == 1)
        #expect(user.avatar == "default")
    }
    
    @Test("語彙モデルの作成テスト")
    func testVocabularyCreation() throws {
        let vocabulary = Vocabulary(
            word: "机",
            reading: "つくえ",
            rubyText: "｜机《つくえ》",
            meaning: "勉強するときに使う台",
            category: "教室",
            difficulty: 1,
            exampleSentences: ["机の上にノートを置きます。"]
        )
        
        #expect(vocabulary.word == "机")
        #expect(vocabulary.reading == "つくえ")
        #expect(vocabulary.difficulty == 1)
    }
    
    @Test("学習場面モデルの作成テスト")
    func testLearningSceneCreation() throws {
        let scene = LearningScene(
            title: "教室での学習",
            rubyTitle: "きょうしつでのがくしゅう",
            description: "教室で使われる語彙を学習します",
            storyContent: "みんなで一緒に勉強します。",
            order: 1,
            category: .classTime
        )
        
        #expect(scene.title == "教室での学習")
        #expect(scene.rubyTitle == "きょうしつでのがくしゅう")
        #expect(scene.sceneDescription == "教室で使われる語彙を学習します")
        #expect(scene.storyContent == "みんなで一緒に勉強します。")
        #expect(scene.category == .classTime)
        #expect(scene.order == 1)
    }
    
    @Test("学習進捗モデルの作成テスト")  
    func testLearningProgressCreation() throws {
        let userId = UUID()
        let vocabularyId = UUID()
        
        let progress = LearningProgress(
            userId: userId,
            vocabularyId: vocabularyId,
            masteryLevel: 1,
            reviewCount: 2,
            correctAnswers: 3,
            totalAnswers: 4
        )
        
        #expect(progress.userId == userId)
        #expect(progress.vocabularyId == vocabularyId)
        #expect(progress.masteryLevel == 1)
        #expect(progress.correctAnswers == 3)
        #expect(progress.totalAnswers == 4)
        #expect(progress.reviewCount == 2)
    }
}
