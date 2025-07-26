import SwiftUI

/// クイズモード表示用のViewコンポーネント
/// 4択問題形式で語彙学習を行うためのインタラクティブなUI
struct QuizModeView: View {
    /// 問題の語彙
    let vocabulary: Vocabulary
    /// 選択肢のリスト（正解を含む4つの語彙）
    let choices: [Vocabulary]
    /// 問題タイプ（イラスト→言葉、言葉→イラスト）
    let quizType: QuizType
    /// 選択された回答のインデックス
    @Binding var selectedChoiceIndex: Int?
    /// 回答が確定されたかどうか
    @Binding var isAnswerSubmitted: Bool
    /// 選択時のコールバック
    let onChoiceSelected: (Int) -> Void
    
    /// クイズの問題タイプ
    enum QuizType {
        case imageToWord    // イラスト→言葉
        case wordToImage    // 言葉→イラスト
    }
    
    var body: some View {
        VStack(spacing: 24) {
            // 問題部分
            questionSection
            
            // 選択肢部分
            choicesSection
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(UIColor.systemBackground))
                .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
        )
    }
    
    /// 問題セクション
    private var questionSection: some View {
        VStack(spacing: 16) {
            Text(quizType == .imageToWord ? "この絵は何を表していますか？" : "この言葉を表す絵はどれですか？")
                .font(.title3)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
            
            if quizType == .imageToWord {
                // イラストを表示
                vocabularyImage(for: vocabulary)
                    .frame(width: 200, height: 200)
            } else {
                // 言葉を表示
                VStack(spacing: 8) {
                    RubyText(vocabulary.word, ruby: vocabulary.rubyText, fontSize: 32)
                    
                    Text(vocabulary.meaning)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.gray.opacity(0.1))
                )
            }
        }
    }
    
    /// 選択肢セクション
    private var choicesSection: some View {
        LazyVGrid(columns: [
            GridItem(.flexible()),
            GridItem(.flexible())
        ], spacing: 16) {
            ForEach(Array(choices.enumerated()), id: \.element.id) { index, choice in
                choiceButton(for: choice, at: index)
            }
        }
    }
    
    /// 個別の選択肢ボタン
    private func choiceButton(for choice: Vocabulary, at index: Int) -> some View {
        Button(action: {
            if !isAnswerSubmitted {
                selectedChoiceIndex = index
                onChoiceSelected(index)
            }
        }) {
            VStack(spacing: 8) {
                if quizType == .imageToWord {
                    // 言葉の選択肢
                    RubyText(choice.word, ruby: choice.rubyText, fontSize: 18)
                        .multilineTextAlignment(.center)
                } else {
                    // イラストの選択肢
                    vocabularyImage(for: choice)
                        .frame(width: 100, height: 100)
                }
            }
            .frame(maxWidth: .infinity, minHeight: 100)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(choiceBackgroundColor(for: index))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(choiceBorderColor(for: index), lineWidth: 3)
                    )
            )
        }
        .disabled(isAnswerSubmitted)
        .scaleEffect(selectedChoiceIndex == index ? 0.95 : 1.0)
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: selectedChoiceIndex)
    }
    
    /// 選択肢の背景色を決定
    private func choiceBackgroundColor(for index: Int) -> Color {
        if !isAnswerSubmitted {
            return selectedChoiceIndex == index ? Color.blue.opacity(0.1) : Color(UIColor.secondarySystemBackground)
        } else {
            let isCorrect = choices[index].id == vocabulary.id
            let isSelected = selectedChoiceIndex == index
            
            if isCorrect {
                return Color.green.opacity(0.2)
            } else if isSelected {
                return Color.red.opacity(0.2)
            } else {
                return Color(UIColor.secondarySystemBackground)
            }
        }
    }
    
    /// 選択肢の枠線色を決定
    private func choiceBorderColor(for index: Int) -> Color {
        if !isAnswerSubmitted {
            return selectedChoiceIndex == index ? Color.blue : Color.clear
        } else {
            let isCorrect = choices[index].id == vocabulary.id
            let isSelected = selectedChoiceIndex == index
            
            if isCorrect {
                return Color.green
            } else if isSelected {
                return Color.red
            } else {
                return Color.clear
            }
        }
    }
    
    /// 語彙のイラスト表示（仮実装）
    private func vocabularyImage(for vocabulary: Vocabulary) -> some View {
        // 実際の実装では、vocabulary.imageUrlから画像を読み込む
        // 現在は仮のアイコンを表示
        Image(systemName: iconForCategory(vocabulary.category))
            .font(.system(size: 60))
            .foregroundColor(.blue)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.blue.opacity(0.1))
            )
    }
    
    /// カテゴリーに応じたアイコンを返す（仮実装）
    private func iconForCategory(_ category: String) -> String {
        switch category {
        case "教室":
            return "book.fill"
        case "給食":
            return "fork.knife"
        case "休み時間":
            return "figure.play"
        case "掃除の時間":
            return "sparkles"
        case "朝の会・帰りの会":
            return "sunrise.fill"
        default:
            return "questionmark.circle.fill"
        }
    }
}

#Preview("イラスト→言葉") {
    @Previewable @State var selectedChoiceIndex: Int? = nil
    @Previewable @State var isAnswerSubmitted = false
    
    let vocabulary = Vocabulary(
        word: "黒板",
        reading: "こくばん",
        rubyText: "｜黒板《こくばん》",
        meaning: "先生が字を書く板",
        category: "教室",
        difficulty: 1,
        imageUrl: "",
        audioUrl: ""
    )
    
    let choices = [
        vocabulary,
        Vocabulary(word: "机", reading: "つくえ", rubyText: "｜机《つくえ》", meaning: "勉強する台", category: "教室", difficulty: 1, imageUrl: "", audioUrl: ""),
        Vocabulary(word: "椅子", reading: "いす", rubyText: "｜椅子《いす》", meaning: "座るもの", category: "教室", difficulty: 1, imageUrl: "", audioUrl: ""),
        Vocabulary(word: "鉛筆", reading: "えんぴつ", rubyText: "｜鉛筆《えんぴつ》", meaning: "字を書く道具", category: "教室", difficulty: 1, imageUrl: "", audioUrl: "")
    ]
    
    QuizModeView(
        vocabulary: vocabulary,
        choices: choices,
        quizType: .imageToWord,
        selectedChoiceIndex: $selectedChoiceIndex,
        isAnswerSubmitted: $isAnswerSubmitted,
        onChoiceSelected: { _ in }
    )
}

#Preview("言葉→イラスト") {
    @Previewable @State var selectedChoiceIndex: Int? = nil
    @Previewable @State var isAnswerSubmitted = false
    
    let vocabulary = Vocabulary(
        word: "給食",
        reading: "きゅうしょく",
        rubyText: "｜給食《きゅうしょく》",
        meaning: "学校で食べる昼ご飯",
        category: "給食",
        difficulty: 1,
        imageUrl: "",
        audioUrl: ""
    )
    
    let choices = [
        vocabulary,
        Vocabulary(word: "配膳", reading: "はいぜん", rubyText: "｜配膳《はいぜん》", meaning: "料理を配ること", category: "給食", difficulty: 2, imageUrl: "", audioUrl: ""),
        Vocabulary(word: "当番", reading: "とうばん", rubyText: "｜当番《とうばん》", meaning: "順番に仕事をする人", category: "給食", difficulty: 1, imageUrl: "", audioUrl: ""),
        Vocabulary(word: "献立", reading: "こんだて", rubyText: "｜献立《こんだて》", meaning: "料理の計画", category: "給食", difficulty: 2, imageUrl: "", audioUrl: "")
    ]
    
    QuizModeView(
        vocabulary: vocabulary,
        choices: choices,
        quizType: .wordToImage,
        selectedChoiceIndex: $selectedChoiceIndex,
        isAnswerSubmitted: $isAnswerSubmitted,
        onChoiceSelected: { _ in }
    )
}