import SwiftUI

/// アプリケーションのメインホーム画面View
/// ユーザーの学習進捗とクイックアクション機能を表示する
struct HomeView: View {
    /// ホーム画面の状態管理ViewState
    @State private var viewState = HomeViewState()
    /// SwiftDataモデルコンテキスト（将来のデータ操作用）
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationView {
            ZStack {
                backgroundColor
                
                if viewState.isLoading {
                    loadingView
                } else if viewState.showUserCreation {
                    userCreationView
                } else {
                    homeContentView
                }
            }
            .navigationTitle("")
            .navigationBarHidden(true)
            .task {
                await viewState.onAppear()
            }
        }
    }
    
    private var backgroundColor: some View {
        LinearGradient(
            colors: [Color.blue.opacity(0.1), Color.green.opacity(0.1)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
    
    private var loadingView: some View {
        VStack(spacing: 20) {
            ProgressView()
                .scaleEffect(2.0)
            
            Text("読み込み中...")
                .font(.title2)
                .foregroundColor(.secondary)
        }
    }
    
    private var userCreationView: some View {
        UserCreationView { name in
            await viewState.createUser(name: name)
        }
    }
    
    private var homeContentView: some View {
        ScrollView {
            VStack(spacing: 24) {
                headerView
                userProgressView
                quickActionsView
                Spacer(minLength: 100)
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
        }
    }
    
    private var headerView: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                if let user = viewState.currentUser {
                    Text("こんにちは！")
                        .font(.title3)
                        .foregroundColor(.secondary)
                    
                    RubyText(user.name, ruby: "", fontSize: 28)
                        .frame(maxWidth: .infinity, alignment: .leading)
                } else {
                    Text("ことばクエスト")
                        .font(.title)
                        .fontWeight(.bold)
                }
            }
            
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "gearshape")
                    .font(.title2)
                    .foregroundColor(.primary)
            }
            .accessibilityLabel("設定")
        }
    }
    
    private var userProgressView: some View {
        VStack(spacing: 16) {
            if let user = viewState.currentUser {
                VStack(spacing: 12) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("レベル \(user.level)")
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                            Text("次のレベルまで \(viewState.nextLevelPoints)pt")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing) {
                            Text("\(user.totalPoints)")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.orange)
                            
                            Text("ポイント")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    ProgressView(value: viewState.userLevelProgress)
                        .progressViewStyle(LinearProgressViewStyle())
                        .accentColor(.orange)
                        .scaleEffect(y: 2.0)
                }
                .padding(20)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(UIColor.systemBackground))
                        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
                )
            }
        }
    }
    
    private var quickActionsView: some View {
        VStack(alignment: .leading, spacing: 16) {
            RubyText("今日の学習", ruby: "きょうのがくしゅう", fontSize: 22, alignment: .leading)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 16) {
                ActionCard(
                    title: "場面別学習",
                    rubyTitle: "ばめんべつがくしゅう",
                    description: "学校生活の場面で語彙を学習",
                    icon: "book.fill",
                    color: .blue
                ) {
                    // Navigation handled by TabView
                }
                
                ActionCard(
                    title: "復習",
                    rubyTitle: "ふくしゅう",
                    description: "間違えた語彙をもう一度",
                    icon: "arrow.clockwise",
                    color: .orange
                ) {
                    // TODO: Implement review functionality
                }
                
                ActionCard(
                    title: "図鑑",
                    rubyTitle: "ずかん",
                    description: "覚えた語彙を確認",
                    icon: "books.vertical.fill",
                    color: .green
                ) {
                    // TODO: Implement vocabulary dictionary
                }
                
                ActionCard(
                    title: "成績",
                    rubyTitle: "せいせき",
                    description: "学習の記録を見る",
                    icon: "chart.line.uptrend.xyaxis",
                    color: .purple
                ) {
                    // TODO: Implement progress tracking
                }
            }
        }
    }
}

/// ユーザー作成画面View
/// 初回起動時にユーザー名を入力してユーザーを作成する
struct UserCreationView: View {
    /// 入力中のユーザー名
    @State private var name: String = ""
    /// ユーザー作成完了時のコールバック
    let onCreate: (String) async -> Void
    
    var body: some View {
        VStack(spacing: 24) {
            VStack(spacing: 16) {
                Text("はじめまして！")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("あなたの名前を教えてください")
                    .font(.title3)
                    .foregroundColor(.secondary)
            }
            
            VStack(spacing: 16) {
                TextField("名前を入力", text: $name)
                    .font(.title2)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(UIColor.systemBackground))
                            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                    )
                    .multilineTextAlignment(.center)
                
                Button(action: {
                    Task {
                        await onCreate(name)
                    }
                }) {
                    Text("始める")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.blue)
                        )
                }
                .disabled(name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                .opacity(name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? 0.6 : 1.0)
            }
        }
        .padding(32)
    }
}

/// ホーム画面のクイックアクションカードView
/// 学習機能へのショートカットボタンを表示する
struct ActionCard: View {
    /// カードタイトル
    let title: String
    /// タイトルのふりがな
    let rubyTitle: String
    /// カードの説明テキスト
    let description: String
    /// 表示するSF Symbolアイコン
    let icon: String
    /// カードのテーマカラー
    let color: Color
    /// タップ時のアクション
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(color)
                .frame(width: 44, height: 44)
                .background(
                    Circle()
                        .fill(color.opacity(0.2))
                )
            
            VStack(spacing: 4) {
                RubyText(title, ruby: rubyTitle, fontSize: 16, alignment: .center)
                
                Text(description)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, minHeight: 140)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(UIColor.systemBackground))
                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
        )
        .onTapGesture {
            action()
        }
        .accessibilityElement(children: .combine)
        .accessibilityAddTraits(.isButton)
        .accessibilityLabel("\(title), \(description)")
    }
}

#Preview {
    HomeView()
}