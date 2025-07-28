import SwiftUI

/// 日本語のふりがな表示を行うSwiftUIコンポーネント
/// 漢字の上にひらがなのふりがなを表示するルビテキスト機能を提供する
struct RubyText: View {
    /// 表示する本文テキスト（漢字を含む）
    let text: String
    /// ふりがな（ひらがな）
    let ruby: String
    /// 本文のフォントサイズ
    let fontSize: CGFloat
    /// ふりがなのフォントサイズ
    let rubyFontSize: CGFloat
    /// テキストの水平方向の配置
    let alignment: HorizontalAlignment
    
    /// RubyTextを初期化
    /// - Parameters:
    ///   - text: 本文テキスト
    ///   - ruby: ふりがなテキスト
    ///   - fontSize: 本文フォントサイズ（デフォルト: 16）
    ///   - rubyFontSize: ふりがなフォントサイズ（デフォルト: 本文の60%）
    ///   - alignment: 水平配置（デフォルト: .center）
    init(_ text: String, ruby: String, fontSize: CGFloat = 16, rubyFontSize: CGFloat? = nil, alignment: HorizontalAlignment = .center) {
        self.text = text
        self.ruby = ruby
        self.fontSize = fontSize
        self.rubyFontSize = rubyFontSize ?? fontSize * 0.6
        self.alignment = alignment
    }
    
    var body: some View {
        VStack(alignment: alignment, spacing: 0) {
            Text(ruby)
                .font(.system(size: rubyFontSize))
                .foregroundColor(.secondary)
                .multilineTextAlignment(textAlignment)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
            
            Text(text)
                .font(.system(size: fontSize))
                .foregroundColor(.primary)
                .multilineTextAlignment(textAlignment)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
        }
        .fixedSize(horizontal: false, vertical: true)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("\(text)（\(ruby)）")
    }
    
    /// テキストの配置をTextAlignmentに変換する
    /// - Returns: 対応するTextAlignment値
    private var textAlignment: TextAlignment {
        switch alignment {
        case .leading:
            return .leading
        case .trailing:
            return .trailing
        default:
            return .center
        }
    }
}

/// 複数のテキストセグメントをインラインで表示するルビテキストコンポーネント
/// ふりがなが必要な部分と不要な部分を組み合わせて一行で表示する
struct RubyTextInline: View {
    /// 表示するテキストセグメントの配列
    let segments: [RubySegment]
    /// 本文のフォントサイズ
    let fontSize: CGFloat
    /// ふりがなのフォントサイズ
    let rubyFontSize: CGFloat
    
    /// RubyTextInlineを初期化
    /// - Parameters:
    ///   - segments: テキストセグメントの配列
    ///   - fontSize: 本文フォントサイズ（デフォルト: 16）
    ///   - rubyFontSize: ふりがなフォントサイズ（デフォルト: 本文の60%）
    init(segments: [RubySegment], fontSize: CGFloat = 16, rubyFontSize: CGFloat? = nil) {
        self.segments = segments
        self.fontSize = fontSize
        self.rubyFontSize = rubyFontSize ?? fontSize * 0.6
    }
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 2) {
            ForEach(segments.indices, id: \.self) { index in
                let segment = segments[index]
                
                if segment.ruby.isEmpty {
                    Text(segment.text)
                        .font(.system(size: fontSize))
                        .foregroundColor(.primary)
                } else {
                    VStack(alignment: .center, spacing: 0) {
                        Text(segment.ruby)
                            .font(.system(size: rubyFontSize))
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                        
                        Text(segment.text)
                            .font(.system(size: fontSize))
                            .foregroundColor(.primary)
                            .lineLimit(1)
                    }
                }
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(accessibilityText)
    }
    
    /// アクセシビリティ用のテキストを生成
    /// - Returns: ふりがなを括弧内に含む読み上げ用テキスト
    private var accessibilityText: String {
        segments.map { segment in
            segment.ruby.isEmpty ? segment.text : "\(segment.text)（\(segment.ruby)）"
        }.joined()
    }
}

/// ルビテキストの一つのセグメント（本文とふりがなのペア）を表す構造体
/// インラインルビテキスト表示で使用される
struct RubySegment {
    /// セグメントの本文テキスト
    let text: String
    /// セグメントのふりがな（空文字の場合はふりがななし）
    let ruby: String
    
    /// RubySegmentを初期化
    /// - Parameters:
    ///   - text: 本文テキスト
    ///   - ruby: ふりがな（デフォルト: 空文字）
    init(_ text: String, ruby: String = "") {
        self.text = text
        self.ruby = ruby
    }
}

extension RubySegment {
    /// 特殊な記法を含むテキストをRubySegmentの配列に解析する
    /// 《》でふりがなを、｜で漢字の開始を示す記法に対応
    /// - Parameter text: 解析するテキスト（例: "｜今日《きょう》は雨です"）
    /// - Returns: 解析されたRubySegmentの配列
    static func parse(from text: String) -> [RubySegment] {
        var segments: [RubySegment] = []
        var currentText = ""
        var currentRuby = ""
        var isInRuby = false
        var isInKanji = false
        
        for char: Swift.Character in text {
            if char == "《" {
                if !currentText.isEmpty {
                    segments.append(RubySegment(currentText, ruby: ""))
                    currentText = ""
                }
                isInRuby = true
                isInKanji = false
            } else if char == "》" {
                if !currentText.isEmpty && !currentRuby.isEmpty {
                    segments.append(RubySegment(currentText, ruby: currentRuby))
                }
                currentText = ""
                currentRuby = ""
                isInRuby = false
                isInKanji = false
            } else if char == "｜" {
                if !currentText.isEmpty {
                    segments.append(RubySegment(currentText, ruby: ""))
                    currentText = ""
                }
                isInKanji = true
            } else {
                if isInRuby {
                    currentRuby.append(char)
                } else if isInKanji || isKanjiCharacter(char) {
                    currentText.append(char)
                    isInKanji = true
                } else {
                    if isInKanji && !currentText.isEmpty {
                        segments.append(RubySegment(currentText, ruby: ""))
                        currentText = ""
                        isInKanji = false
                    }
                    currentText.append(char)
                }
            }
        }
        
        if !currentText.isEmpty {
            segments.append(RubySegment(currentText, ruby: ""))
        }
        
        return segments
    }
    
    /// 指定された文字が漢字かどうかを判定する
    /// - Parameter char: 判定する文字
    /// - Returns: 漢字の場合true、それ以外はfalse
    private static func isKanjiCharacter(_ char: Swift.Character) -> Bool {
        guard let scalar = char.unicodeScalars.first else { return false }
        return (0x4E00...0x9FAF).contains(scalar.value) ||  // CJK統合漢字
               (0x3400...0x4DBF).contains(scalar.value) ||  // CJK拡張A
               (0x20000...0x2A6DF).contains(scalar.value)   // CJK拡張B
    }
}

#Preview {
    VStack(spacing: 20) {
        RubyText("漢字", ruby: "かんじ", fontSize: 24)
        
        RubyText("日本語", ruby: "にほんご", fontSize: 20)
        
        RubyTextInline(segments: [
            RubySegment("今日", ruby: "きょう"),
            RubySegment("は"),
            RubySegment("学校", ruby: "がっこう"),
            RubySegment("に"),
            RubySegment("行", ruby: "い"),
            RubySegment("きます。")
        ], fontSize: 18)
        
        RubyTextInline(
            segments: RubySegment.parse(from: "｜今日《きょう》は｜学校《がっこう》です。"),
            fontSize: 18
        )
    }
    .padding()
}