import Foundation
import SwiftData

/// 個別語彙の学習進捗を追跡するSwiftDataモデル
/// ユーザーごとの語彙習得レベルと学習履歴を管理する
@Model
final class LearningProgress {
    /// 学習者のユーザーID
    var userId: UUID
    /// 対象語彙のID
    var vocabularyId: UUID
    /// 習得レベル（0-3、3で完全習得）
    var masteryLevel: Int
    /// 最後に復習した日時
    var lastReviewDate: Date
    /// 復習回数
    var reviewCount: Int
    /// 正答数
    var correctAnswers: Int
    /// 総回答数
    var totalAnswers: Int
    /// 初回学習日時（オプショナル）
    var firstLearnedDate: Date?
    
    /// ユーザーとの逆リレーションシップ
    @Relationship(inverse: \User.learningProgress)
    var user: User?
    
    /// 学習進捗インスタンスを初期化
    /// - Parameters:
    ///   - userId: ユーザーID
    ///   - vocabularyId: 語彙ID
    ///   - masteryLevel: 習得レベル（デフォルト: 0）
    ///   - reviewCount: 復習回数（デフォルト: 0）
    ///   - correctAnswers: 正答数（デフォルト: 0）
    ///   - totalAnswers: 総回答数（デフォルト: 0）
    init(userId: UUID, vocabularyId: UUID, masteryLevel: Int = 0, reviewCount: Int = 0, correctAnswers: Int = 0, totalAnswers: Int = 0) {
        self.userId = userId
        self.vocabularyId = vocabularyId
        self.masteryLevel = masteryLevel
        self.lastReviewDate = Date()
        self.reviewCount = reviewCount
        self.correctAnswers = correctAnswers
        self.totalAnswers = totalAnswers
        self.firstLearnedDate = nil
    }
    
    /// 正答率を計算するプロパティ
    /// - Returns: 0.0から1.0の正答率
    var accuracyRate: Double {
        guard totalAnswers > 0 else { return 0.0 }
        return Double(correctAnswers) / Double(totalAnswers)
    }
    
    /// 語彙が習得済みかどうかを判定するプロパティ
    /// - Returns: 習得レベル3以上かつ正答率80%以上で習得済み
    var isMastered: Bool {
        return masteryLevel >= 3 && accuracyRate >= 0.8
    }
    
    /// 回答結果を記録し、習得レベルを更新する
    /// - Parameter isCorrect: 正答かどうか
    func recordAnswer(isCorrect: Bool) {
        totalAnswers += 1
        if isCorrect {
            correctAnswers += 1
        }
        
        if firstLearnedDate == nil {
            firstLearnedDate = Date()
        }
        
        lastReviewDate = Date()
        reviewCount += 1
        
        if isCorrect && masteryLevel < 3 {
            masteryLevel += 1
        } else if !isCorrect && masteryLevel > 0 {
            masteryLevel = max(0, masteryLevel - 1)
        }
    }
}