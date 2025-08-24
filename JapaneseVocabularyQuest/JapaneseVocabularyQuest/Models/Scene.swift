import Foundation
import SwiftData

/// 学習場面を表すSwiftDataモデル
/// 学校生活や日常生活の各場面での語彙学習を管理する
@Model
final class LearningScene {
    /// 場面の一意識別子
    var id: UUID
    /// 場面のタイトル（日本語）
    var title: String
    /// 場面のタイトル（英語、オプショナル）
    var titleEn: String?
    /// タイトルのふりがな
    var rubyTitle: String
    /// 場面の説明文（SwiftDataの制限により'description'は使用不可）
    var sceneDescription: String
    /// 場面の説明（英語、オプショナル）
    var descriptionEn: String?
    /// この場面に含まれる語彙のIDリスト
    var vocabularyIds: [UUID]
    /// 場面のストーリー内容
    var storyContent: String
    /// イラスト画像のURLリスト
    var illustrationUrls: [String]
    /// 文化的背景の説明（オプショナル）
    var culturalNote: String?
    /// 場面の表示順序
    var order: Int
    /// 場面のカテゴリー
    var category: SceneCategory
    
    /// 学習場面インスタンスを初期化
    /// - Parameters:
    ///   - title: 場面のタイトル
    ///   - rubyTitle: タイトルのふりがな
    ///   - description: 場面の説明
    ///   - storyContent: ストーリー内容
    ///   - order: 表示順序
    ///   - category: 場面カテゴリー
    ///   - vocabularyIds: 関連語彙IDリスト（デフォルト: 空配列）
    ///   - illustrationUrls: イラストURLリスト（デフォルト: 空配列）
    ///   - titleEn: 英語タイトル（オプショナル）
    ///   - descriptionEn: 英語説明（オプショナル）
    ///   - culturalNote: 文化的背景（オプショナル）
    init(title: String, rubyTitle: String, description: String, storyContent: String, order: Int, category: SceneCategory, vocabularyIds: [UUID] = [], illustrationUrls: [String] = [], titleEn: String? = nil, descriptionEn: String? = nil, culturalNote: String? = nil) {
        self.id = UUID()
        self.title = title
        self.titleEn = titleEn
        self.rubyTitle = rubyTitle
        self.sceneDescription = description
        self.descriptionEn = descriptionEn
        self.vocabularyIds = vocabularyIds
        self.storyContent = storyContent
        self.illustrationUrls = illustrationUrls
        self.culturalNote = culturalNote
        self.order = order
        self.category = category
    }
}

/// LearningSceneをHashableに準拠させるための拡張
/// NavigationPathでの使用に必要
extension LearningScene: Hashable {
    static func == (lhs: LearningScene, rhs: LearningScene) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

/// 学習場面のカテゴリーを定義するenum
/// 学校生活と日常生活の主要場面を分類する
enum SceneCategory: String, Codable, CaseIterable {
    /// 朝の会
    case morningAssembly = "morning_assembly"
    /// 授業時間
    case classTime = "class_time"
    /// 給食時間
    case lunchTime = "lunch_time"
    /// 掃除時間
    case cleaningTime = "cleaning_time"
    /// 休み時間
    case breakTime = "break_time"
    /// 家での生活
    case homeLife = "home_life"
    /// 買い物
    case shopping = "shopping"
    /// 公園・遊び場
    case park = "park"
    /// 習い事
    case lessons = "lessons"
    
    /// カテゴリーの日本語表示名
    var displayName: String {
        switch self {
        case .morningAssembly: return "朝の会"
        case .classTime: return "授業時間"
        case .lunchTime: return "給食時間"
        case .cleaningTime: return "掃除時間"
        case .breakTime: return "休み時間"
        case .homeLife: return "家での生活"
        case .shopping: return "買い物"
        case .park: return "公園・遊び場"
        case .lessons: return "習い事"
        }
    }
    
    /// カテゴリーのふりがな表示名
    var rubyDisplayName: String {
        switch self {
        case .morningAssembly: return "あさのかい"
        case .classTime: return "じゅぎょうじかん"
        case .lunchTime: return "きゅうしょくじかん"
        case .cleaningTime: return "そうじじかん"
        case .breakTime: return "やすみじかん"
        case .homeLife: return "いえでのせいかつ"
        case .shopping: return "かいもの"
        case .park: return "こうえん・あそびば"
        case .lessons: return "ならいごと"
        }
    }
}