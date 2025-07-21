import Foundation
import SwiftData

/// 学習成果を記録するアチーブメントSwiftDataモデル
/// ユーザーの学習モチベーション向上のためのゲーミフィケーション要素
@Model
final class Achievement {
    /// アチーブメントの一意識別子
    var id: UUID
    /// アチーブメントのタイトル
    var title: String
    /// アチーブメントの説明文（SwiftDataの制限により'description'は使用不可）
    var achievementDescription: String
    /// 達成条件の詳細
    var requirement: String
    /// バッジ画像のURL
    var badgeImageUrl: String
    /// 達成時に獲得できるポイント数
    var points: Int
    /// アチーブメントのカテゴリー
    var category: AchievementCategory
    /// 隠しアチーブメントかどうか
    var isHidden: Bool
    /// アンロック日時（アンロック済みの場合）
    var unlockedDate: Date?
    
    /// アチーブメントインスタンスを初期化
    /// - Parameters:
    ///   - title: アチーブメントタイトル
    ///   - description: アチーブメント説明
    ///   - requirement: 達成条件
    ///   - points: 獲得ポイント数
    ///   - category: カテゴリー
    ///   - badgeImageUrl: バッジ画像URL（デフォルト: 空文字）
    ///   - isHidden: 隠しアチーブメント（デフォルト: false）
    init(title: String, description: String, requirement: String, points: Int, category: AchievementCategory, badgeImageUrl: String = "", isHidden: Bool = false) {
        self.id = UUID()
        self.title = title
        self.achievementDescription = description
        self.requirement = requirement
        self.badgeImageUrl = badgeImageUrl
        self.points = points
        self.category = category
        self.isHidden = isHidden
        self.unlockedDate = nil
    }
    
    /// アチーブメントがアンロック済みかどうかを判定
    /// - Returns: アンロック日時が設定されている場合true
    var isUnlocked: Bool {
        return unlockedDate != nil
    }
    
    /// アチーブメントをアンロックする
    func unlock() {
        guard !isUnlocked else { return }
        unlockedDate = Date()
    }
}

/// アチーブメントのカテゴリーを定義するenum
/// アチーブメントの種類別に分類する
enum AchievementCategory: String, Codable, CaseIterable {
    /// 語彙関連のアチーブメント
    case vocabulary = "vocabulary"
    /// 継続学習関連のアチーブメント
    case streak = "streak"
    /// 習得関連のアチーブメント
    case mastery = "mastery"
    /// キャラクター関連のアチーブメント
    case character = "character"
    /// 特別なアチーブメント
    case special = "special"
    
    /// カテゴリーの日本語表示名
    var displayName: String {
        switch self {
        case .vocabulary: return "語彙"
        case .streak: return "継続"
        case .mastery: return "習得"
        case .character: return "キャラクター"
        case .special: return "特別"
        }
    }
}