import Foundation
import SwiftData

/// キャラクターの情報を管理するSwiftDataモデル
/// ゲーミフィケーション要素として使用され、学習進捗に応じてアンロック・進化する
@Model
final class Character {
    /// キャラクターの一意識別子
    var id: UUID
    /// キャラクター名
    var name: String
    /// レアリティ（獲得難易度）
    var rarity: CharacterRarity
    /// 進化段階（1-3）
    var evolutionStage: Int
    /// アンロックに必要なポイント数
    var requiredPoints: Int
    /// キャラクター画像のURLリスト
    var imageUrls: [String]
    /// キャラクターの説明文（SwiftDataの制限により'description'は使用不可）
    var characterDescription: String
    /// アンロック条件の説明
    var unlockCondition: String
    /// アンロック済みフラグ
    var isUnlocked: Bool
    
    /// キャラクターインスタンスを初期化
    /// - Parameters:
    ///   - name: キャラクター名
    ///   - rarity: レアリティ
    ///   - evolutionStage: 進化段階（デフォルト: 1）
    ///   - requiredPoints: 必要ポイント数
    ///   - description: キャラクター説明
    ///   - unlockCondition: アンロック条件
    ///   - imageUrls: 画像URLリスト（デフォルト: 空配列）
    ///   - isUnlocked: アンロック状態（デフォルト: false）
    init(name: String, rarity: CharacterRarity, evolutionStage: Int = 1, requiredPoints: Int, description: String, unlockCondition: String, imageUrls: [String] = [], isUnlocked: Bool = false) {
        self.id = UUID()
        self.name = name
        self.rarity = rarity
        self.evolutionStage = evolutionStage
        self.requiredPoints = requiredPoints
        self.imageUrls = imageUrls
        self.characterDescription = description
        self.unlockCondition = unlockCondition
        self.isUnlocked = isUnlocked
    }
    
    /// キャラクターが進化可能かどうかを判定
    /// - Returns: 進化段階が3未満の場合true
    var canEvolve: Bool {
        return evolutionStage < 3
    }
    
    /// キャラクターを進化させる
    /// - Returns: 進化に成功した場合true
    func evolve() -> Bool {
        guard canEvolve else { return false }
        evolutionStage += 1
        return true
    }
}

/// キャラクターのレアリティを定義するenum
/// 獲得難易度と視覚的表現を決定する
enum CharacterRarity: String, Codable, CaseIterable {
    /// コモン（一般的）
    case common = "common"
    /// アンコモン（やや稀）
    case uncommon = "uncommon"
    /// レア（稀）
    case rare = "rare"
    /// エピック（非常に稀）
    case epic = "epic"
    /// レジェンダリー（極めて稀）
    case legendary = "legendary"
    
    /// レアリティの日本語表示名
    var displayName: String {
        switch self {
        case .common: return "コモン"
        case .uncommon: return "アンコモン"
        case .rare: return "レア"
        case .epic: return "エピック"
        case .legendary: return "レジェンダリー"
        }
    }
    
    /// レアリティに対応する色コード（HEX形式）
    var color: String {
        switch self {
        case .common: return "#CCCCCC"
        case .uncommon: return "#4CAF50"
        case .rare: return "#2196F3"
        case .epic: return "#9C27B0"
        case .legendary: return "#FF9800"
        }
    }
}