import Foundation
import SwiftData

/// 日本語語彙を表すSwiftDataモデル
/// 小学生向けの語彙学習データを管理し、ふりがなや例文を含む
@Model
final class Vocabulary {
    /// 語彙の一意識別子
    var id: UUID
    /// 語彙（漢字を含む表記）
    var word: String
    /// よみがな（ひらがな表記）
    var reading: String
    /// ルビテキスト（ふりがな表示用の形式化されたテキスト）
    var rubyText: String
    /// 意味（日本語での説明）
    var meaning: String
    /// 英語での意味（オプショナル、多言語対応）
    var meaningEn: String?
    /// カテゴリー（学習場面やテーマ）
    var category: String
    /// 難易度レベル（1-10）
    var difficulty: Int
    /// JLPT（日本語能力試験）レベル（オプショナル）
    var jlptLevel: Int?
    /// イラスト画像のURL
    var imageUrl: String
    /// 音声ファイルのURL
    var audioUrl: String
    /// 例文のリスト
    var exampleSentences: [String]
    /// ローマ字表記（オプショナル）
    var romaji: String?
    
    /// 語彙インスタンスを初期化
    /// - Parameters:
    ///   - word: 語彙（漢字表記）
    ///   - reading: よみがな
    ///   - rubyText: ルビテキスト形式
    ///   - meaning: 日本語での意味
    ///   - category: カテゴリー
    ///   - difficulty: 難易度（1-10）
    ///   - imageUrl: イラストURL（デフォルト: 空文字）
    ///   - audioUrl: 音声URL（デフォルト: 空文字）
    ///   - exampleSentences: 例文リスト（デフォルト: 空配列）
    ///   - meaningEn: 英語での意味（オプショナル）
    ///   - jlptLevel: JLPTレベル（オプショナル）
    ///   - romaji: ローマ字表記（オプショナル）
    init(word: String, reading: String, rubyText: String, meaning: String, category: String, difficulty: Int, imageUrl: String = "", audioUrl: String = "", exampleSentences: [String] = [], meaningEn: String? = nil, jlptLevel: Int? = nil, romaji: String? = nil) {
        self.id = UUID()
        self.word = word
        self.reading = reading
        self.rubyText = rubyText
        self.meaning = meaning
        self.meaningEn = meaningEn
        self.category = category
        self.difficulty = difficulty
        self.jlptLevel = jlptLevel
        self.imageUrl = imageUrl
        self.audioUrl = audioUrl
        self.exampleSentences = exampleSentences
        self.romaji = romaji
    }
}