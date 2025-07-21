import SwiftUI

struct LearningView: View {
    let scene: LearningScene
    @State private var viewState = LearningViewState()
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        ZStack {
            backgroundColor
            
            if viewState.isLoading {
                loadingView
            } else if viewState.isCompleted {
                completionView
            } else if viewState.vocabularies.isEmpty {
                emptyStateView
            } else {
                learningContentView
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("戻る") {
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                progressIndicator
            }
        }
        .task {
            await viewState.startLearning(scene: scene)
        }
    }
    
    private var backgroundColor: some View {
        LinearGradient(
            colors: [Color.purple.opacity(0.1), Color.pink.opacity(0.1)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
    
    private var loadingView: some View {
        VStack(spacing: 20) {
            ProgressView()
                .scaleEffect(2.0)
            
            Text("語彙を読み込み中...")
                .font(.title3)
                .foregroundColor(.secondary)
        }
    }
    
    private var progressIndicator: some View {
        HStack(spacing: 4) {
            Text("\(viewState.currentVocabularyIndex + 1)")
                .font(.caption)
                .fontWeight(.semibold)
            Text("/")
                .font(.caption)
            Text("\(viewState.vocabularies.count)")
                .font(.caption)
        }
        .foregroundColor(.secondary)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(
            Capsule()
                .fill(Color(UIColor.systemBackground))
                .opacity(0.8)
        )
    }
    
    private var learningContentView: some View {
        VStack(spacing: 0) {
            progressBar
            
            ScrollView {
                VStack(spacing: 24) {
                    sceneInfoHeader
                    
                    if let vocabulary = viewState.currentVocabulary {
                        VocabularyCard(
                            vocabulary: vocabulary,
                            showAnswer: viewState.showAnswer
                        ) {
                            if !viewState.showAnswer {
                                Task {
                                    await viewState.submitAnswer("")
                                }
                            }
                        }
                        .animation(.easeInOut(duration: 0.3), value: viewState.showAnswer)
                    }
                    
                    if viewState.showAnswer {
                        answerFeedback
                        nextButton
                    }
                    
                    Spacer(minLength: 100)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
            }
        }
    }
    
    private var progressBar: some View {
        ProgressView(value: viewState.progress)
            .progressViewStyle(LinearProgressViewStyle())
            .accentColor(.purple)
            .scaleEffect(y: 3.0)
            .padding(.horizontal)
    }
    
    private var sceneInfoHeader: some View {
        VStack(spacing: 8) {
            RubyText(scene.title, ruby: scene.rubyTitle, fontSize: 24)
            
            Text(scene.sceneDescription)
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(UIColor.systemBackground))
                .opacity(0.8)
        )
    }
    
    private var answerFeedback: some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                Image(systemName: "checkmark.circle.fill")
                    .font(.title2)
                    .foregroundColor(.green)
                
                Text("よくできました！")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.green)
            }
            
            Text("この語彙を覚えました")
                .font(.body)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.green.opacity(0.1))
        )
    }
    
    private var nextButton: some View {
        Button(action: {
            viewState.nextVocabulary()
        }) {
            Text(viewState.remainingVocabularies > 0 ? "次へ" : "完了")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.purple)
                )
        }
        .padding(.horizontal)
    }
    
    private var completionView: some View {
        VStack(spacing: 24) {
            VStack(spacing: 16) {
                Image(systemName: "star.circle.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.yellow)
                
                RubyText("完了しました！", ruby: "かんりょうしました！", fontSize: 28)
                
                Text("\(scene.title)の学習が終わりました")
                    .font(.title3)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            
            VStack(spacing: 12) {
                HStack {
                    VStack {
                        Text("\(viewState.correctAnswersCount)")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                        Text("正解")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    VStack {
                        Text("\(viewState.totalAnswersCount)")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                        Text("回答")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    VStack {
                        Text("\(Int(viewState.accuracyRate * 100))%")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.orange)
                        Text("正答率")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(20)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(UIColor.systemBackground))
                        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                )
            }
            
            VStack(spacing: 12) {
                Button(action: {
                    Task {
                        await viewState.restartLearning()
                    }
                }) {
                    Text("もう一度学習する")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.purple)
                        )
                }
                
                Button(action: {
                    dismiss()
                }) {
                    Text("場面選択に戻る")
                        .font(.title3)
                        .foregroundColor(.purple)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.purple, lineWidth: 2)
                        )
                }
            }
        }
        .padding(32)
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 20) {
            Image(systemName: "questionmark.circle")
                .font(.system(size: 60))
                .foregroundColor(.gray)
            
            VStack(spacing: 8) {
                Text("語彙がありません")
                    .font(.title2)
                    .foregroundColor(.primary)
                
                Text("この場面の語彙はまだ準備中です")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            
            Button(action: {
                dismiss()
            }) {
                Text("戻る")
                    .font(.title3)
                    .foregroundColor(.blue)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.blue, lineWidth: 2)
                    )
            }
            .padding(.horizontal)
        }
        .padding(32)
    }
}

#Preview {
    let scene = LearningScene(
        title: "朝の会",
        rubyTitle: "あさのかい",
        description: "みんなで朝のあいさつをして、一日の始まりです",
        storyContent: "みんなで朝のあいさつをして、健康観察や今日の予定を確認します。",
        order: 1,
        category: .morningAssembly
    )
    
    NavigationView {
        LearningView(scene: scene)
    }
}