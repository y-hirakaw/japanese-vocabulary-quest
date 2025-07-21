import Foundation
import SwiftData

/// 語彙学習アプリのユーザーを表すSwiftDataモデル
/// 小学生ユーザーの学習進捗とプロフィール情報を管理する
@Model
final class User {
    /// ユーザーの一意識別子
    var id: UUID
    /// ユーザー名（小学生の名前）
    var name: String
    /// アバター画像の識別子
    var avatar: String
    /// 現在のレベル（学習進捗に基づいて上昇）
    var level: Int
    /// 累計獲得ポイント
    var totalPoints: Int
    /// アカウント作成日時
    var createdAt: Date
    /// 保護者アカウントのID（オプショナル）
    var parentId: UUID?
    
    /// 各語彙に対する学習進捗データとのリレーションシップ
    @Relationship(deleteRule: .cascade)
    var learningProgress: [LearningProgress]
    
    /// ユーザーインスタンスを初期化
    /// - Parameters:
    ///   - name: ユーザー名
    ///   - avatar: アバター識別子（デフォルト: "default"）
    ///   - level: 初期レベル（デフォルト: 1）
    ///   - totalPoints: 初期ポイント（デフォルト: 0）
    ///   - parentId: 保護者アカウントID（オプショナル）
    init(name: String, avatar: String = "default", level: Int = 1, totalPoints: Int = 0, parentId: UUID? = nil) {
        self.id = UUID()
        self.name = name
        self.avatar = avatar
        self.level = level
        self.totalPoints = totalPoints
        self.createdAt = Date()
        self.parentId = parentId
        self.learningProgress = []
    }
}