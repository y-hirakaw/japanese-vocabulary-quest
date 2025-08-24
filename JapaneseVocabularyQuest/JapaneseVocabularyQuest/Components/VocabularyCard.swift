import SwiftUI

struct VocabularyCard: View {
    let vocabulary: Vocabulary
    let showAnswer: Bool
    let onTap: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            if let imageUrl = URL(string: vocabulary.imageUrl), !vocabulary.imageUrl.isEmpty {
                AsyncImage(url: imageUrl) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.gray.opacity(0.2))
                        .overlay(
                            Image(systemName: "photo")
                                .font(.title)
                                .foregroundColor(.gray)
                        )
                }
                .frame(height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            
            VStack(spacing: 12) {
                if showAnswer {
                    VStack(spacing: 8) {
                        RubyText(vocabulary.word, ruby: vocabulary.rubyText, fontSize: 32, alignment: .center)
                        
                        Text(vocabulary.meaning)
                            .font(.title2)
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.center)
                        
                        if !vocabulary.reading.isEmpty && vocabulary.reading != vocabulary.rubyText {
                            Text("読み: \(vocabulary.reading)")
                                .font(.body)
                                .foregroundColor(.secondary)
                        }
                    }
                } else {
                    Text("この言葉は何でしょう？")
                        .font(.title2)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                    
                    Text("タップして答えを見る")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                if showAnswer && !vocabulary.exampleSentences.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("例文:")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        ForEach(vocabulary.exampleSentences.prefix(2), id: \.self) { sentence in
                            RubyTextInline(
                                segments: RubySegment.parse(from: sentence),
                                fontSize: 14
                            )
                            .padding(.vertical, 2)
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                }
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(UIColor.systemBackground))
                .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
        )
        .onTapGesture {
            print("🎯 VocabularyCard onTapGesture fired")
            onTap()
            print("🎯 VocabularyCard onTap() called")
        }
        .accessibilityElement(children: .combine)
        .accessibilityAddTraits(showAnswer ? [] : .isButton)
        .accessibilityLabel(accessibilityLabel)
        .accessibilityHint(showAnswer ? "" : "タップして答えを表示")
    }
    
    private var accessibilityLabel: String {
        if showAnswer {
            let reading = vocabulary.reading != vocabulary.rubyText ? ", 読み方: \(vocabulary.reading)" : ""
            return "\(vocabulary.word), \(vocabulary.rubyText)\(reading), 意味: \(vocabulary.meaning)"
        } else {
            return "語彙カード, この言葉は何でしょう？"
        }
    }
}

struct VocabularyMiniCard: View {
    let vocabulary: Vocabulary
    let progress: LearningProgress?
    
    var body: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                RubyText(vocabulary.word, ruby: vocabulary.rubyText, fontSize: 18, alignment: .leading)
                
                Text(vocabulary.meaning)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            Spacer()
            
            VStack(spacing: 4) {
                masteryIndicator
                
                if let progress = progress {
                    Text("\(progress.reviewCount)回")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(UIColor.systemBackground))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(borderColor, lineWidth: 1)
                )
        )
    }
    
    private var masteryIndicator: some View {
        HStack(spacing: 2) {
            ForEach(0..<3, id: \.self) { level in
                Circle()
                    .fill(level < (progress?.masteryLevel ?? 0) ? Color.green : Color.gray.opacity(0.3))
                    .frame(width: 6, height: 6)
            }
        }
    }
    
    private var borderColor: Color {
        if let progress = progress, progress.isMastered {
            return .green
        } else if let progress = progress, progress.masteryLevel > 0 {
            return .orange
        } else {
            return .gray.opacity(0.3)
        }
    }
}

#Preview {
    let vocabulary = Vocabulary(
        word: "学校",
        reading: "がっこう",
        rubyText: "がっこう",
        meaning: "勉強をするところ",
        category: "education",
        difficulty: 1,
        exampleSentences: ["｜今日《きょう》は｜学校《がっこう》に｜行《い》きます。"]
    )
    
    VStack(spacing: 20) {
        VocabularyCard(vocabulary: vocabulary, showAnswer: false) {}
        VocabularyCard(vocabulary: vocabulary, showAnswer: true) {}
        VocabularyMiniCard(vocabulary: vocabulary, progress: nil)
    }
    .padding()
    .background(Color.gray.opacity(0.1))
}