# 小学生語彙力向上アプリ「ことばクエスト」要件定義書

## 1. プロジェクト概要

### 1.1 プロダクト名
- **日本語名**: ことばクエスト 〜小学生の語彙力アップ〜
- **英語名**: Kotoba Quest - Japanese Vocabulary Adventure
- **リポジトリ名**: japanese-vocabulary-quest

### 1.2 目的
小学校低学年（特に2年生）の児童が、学校生活や日常生活で使う語彙を楽しく学習し、実生活で活用できるようにする

### 1.3 ターゲットユーザー
- **主要ユーザー**: 小学1-3年生（6-9歳）
- **副次ユーザー**: 保護者、祖父母などの家族

### 1.4 解決する課題
- 教科書には載っていない日常語彙（校舎、体育館、給食当番など）の理解不足
- 友達との会話に必要な語彙力の不足
- 継続的な語彙学習へのモチベーション維持の難しさ

## 2. 機能要件

### 2.1 コア機能

#### 2.1.1 場面別語彙学習モジュール
**学校生活場面（第1フェーズ）**
- 朝の会（10-15語彙）
  - 例：日直、健康観察、出席番号、連絡帳
- 授業時間（15-20語彙）
  - 例：黒板、チョーク、教科書、ノート、発表
- 給食時間（10-15語彙）
  - 例：配膳、おかわり、完食、給食当番
- 掃除時間（10-15語彙）
  - 例：ほうき、ちりとり、雑巾、バケツ
- 休み時間（10-15語彙）
  - 例：校庭、遊具、ドッジボール、鬼ごっこ

**日常生活場面（第2フェーズ）**
- 家での生活
- 買い物
- 公園・遊び場
- 習い事

#### 2.1.2 学習形式
**ストーリーモード**
- 各場面をイラスト付きストーリーで展開
- 文脈の中で自然に語彙を提示
- 1ストーリー3-5分で完結

**クイズモード**
- 4択問題（イラスト→言葉、言葉→イラスト）
- 穴埋め問題（文章の中の適切な語彙を選択）
- 並べ替え問題（語彙を使った文章作成）

**復習モード**
- 間違えた語彙の集中学習
- スペースドリピティション（忘却曲線に基づく復習）

### 2.2 ゲーミフィケーション要素

#### 2.2.1 キャラクター育成システム
- メインキャラクター「ことばモンスター」
- 学習ポイントで成長・進化（3段階）
- コレクション要素（全30種類のキャラクター）

#### 2.2.2 報酬システム
- 即時報酬：正解時のコイン獲得
- デイリーボーナス：連続ログインボーナス
- 達成報酬：バッジシステム（初級・中級・上級）

#### 2.2.3 進捗の可視化
- レベルシステム（1-50レベル）
- 学習カレンダー（継続日数の表示）
- 習得語彙図鑑（ビジュアル辞書）

### 2.3 保護者機能

#### 2.3.1 学習管理ダッシュボード
- リアルタイム学習状況
- 週間・月間レポート
- 苦手分野分析

#### 2.3.2 設定・管理
- 学習時間制限設定
- 通知設定（学習完了、未学習アラート）
- 複数子どもアカウント管理（最大5人）

#### 2.3.3 コミュニケーション機能
- 応援メッセージ送信
- 学習成果の共有（家族間）

## 3. 非機能要件

### 3.1 ユーザビリティ要件
- 起動から学習開始まで3タップ以内
- 読み込み時間：最大3秒
- オフライン対応（基本学習機能）

### 3.2 アクセシビリティ要件
- 音声読み上げ機能（全テキスト対応）
- 色覚多様性対応（カラーユニバーサルデザイン）
- 文字サイズ調整機能（3段階）
- **全ての漢字にルビ（ふりがな）表示**

### 3.3 パフォーマンス要件
- 同時接続ユーザー数：1,000人以上
- レスポンスタイム：1秒以内（95パーセンタイル）
- データ同期：リアルタイム（Wi-Fi環境下）

### 3.4 セキュリティ要件
- エンドツーエンド暗号化
- COPPA準拠
- 定期的なセキュリティ監査

## 4. 技術仕様

### 4.1 開発環境
- **言語**: Swift 6.0+
- **最小対応OS**: iOS 18.0
- **開発環境**: Xcode 16+
- **アーキテクチャ**: SVVS (Store-View-ViewState-Service)

### 4.2 主要フレームワーク
- **UI**: SwiftUI
- **データ永続化**: SwiftData + CloudKit
- **状態管理**: @Observable（ViewState）、Combine（Store-ViewState間の購読のみ）
- **非同期処理**: Swift Concurrency (async/await)
- **分析**: Firebase Analytics
- **通知**: UserNotifications + Firebase Cloud Messaging

### 4.3 外部サービス
- **認証**: Firebase Authentication
- **データベース**: Firestore
- **ストレージ**: Firebase Storage（イラスト、音声ファイル）
- **課金**: StoreKit 2

## 5. UI/UXデザイン仕様

### 5.1 デザイン原則
- 明るく親しみやすいビジュアル
- 大きくタップしやすいボタン（最小44×44pt）
- アニメーションによるフィードバック
- 一貫性のあるナビゲーション

### 5.2 カラーパレット
- プライマリ：明るいブルー（#4A90E2）
- セカンダリ：オレンジ（#F5A623）
- 成功：グリーン（#7ED321）
- エラー：レッド（#D0021B）

### 5.3 タイポグラフィ
- 本文：ヒラギノ角ゴ 16pt以上
- 見出し：ヒラギノ角ゴ 20pt以上
- ボタンテキスト：18pt以上

### 5.4 アセット管理
- イラスト：Canvaで作成、SVG形式で管理
- アイコン：SF Symbols優先使用
- 音声：mp3形式、各ファイル1MB以下
- ルビ表示：NSAttributedStringまたはText組み合わせで実装

## 6. データモデル

### 6.1 ユーザー関連（SwiftData Model）
```swift
@Model
final class User {
    var id: UUID
    var name: String
    var avatar: String
    var level: Int
    var totalPoints: Int
    var createdAt: Date
    var parentId: UUID?
    
    @Relationship(deleteRule: .cascade)
    var learningProgress: [LearningProgress]
}

@Model
final class LearningProgress {
    var userId: UUID
    var vocabularyId: UUID
    var masteryLevel: Int // 0-3
    var lastReviewDate: Date
    var reviewCount: Int
    
    @Relationship(inverse: \User.learningProgress)
    var user: User?
}
```

### 6.2 コンテンツ関連
```swift
@Model
final class Vocabulary {
    var id: UUID
    var word: String
    var reading: String  // ひらがな読み
    var rubyText: String // ルビ用テキスト
    var meaning: String
    var meaningEn: String? // 英語での意味（将来の海外展開用）
    var category: String
    var difficulty: Int // 1-3
    var jlptLevel: Int? // N5=5, N4=4... N1=1（将来の海外展開用）
    var imageUrl: String
    var audioUrl: String
    var exampleSentences: [String]
    var romaji: String? // ローマ字表記（将来の海外展開用）
}

@Model
final class Scene {
    var id: UUID
    var title: String
    var titleEn: String? // 英語タイトル（将来の海外展開用）
    var rubyTitle: String // ルビ付きタイトル
    var description: String
    var descriptionEn: String? // 英語説明（将来の海外展開用）
    var vocabularyIds: [UUID]
    var storyContent: String
    var illustrationUrls: [String]
    var culturalNote: String? // 文化的な説明（将来の海外展開用）
}
```

### 6.3 ゲーミフィケーション関連
```swift
@Model
final class Character {
    var id: UUID
    var name: String
    var rarity: String
    var evolutionStage: Int
    var requiredPoints: Int
    var imageUrls: [String]
}

@Model
final class Achievement {
    var id: UUID
    var title: String
    var description: String
    var requirement: String
    var badgeImageUrl: String
    var points: Int
}
```

## 7. ビジネスモデル

### 7.1 フリーミアムモデル

**無料版**
- 1日5問まで学習可能
- 基本キャラクター3種類
- 広告表示あり（インタースティシャル）

**プレミアム版（月額300円）**
- 無制限学習
- 全キャラクター解放
- 広告非表示
- 詳細な学習レポート
- 優先サポート

### 7.2 アプリ内課金
- キャラクターパック：各100円
- 特別イベント参加券：200円
- 年間パス：3,000円（17%割引）

## 8. 開発フェーズ

### Phase 1（MVP）- 2ヶ月
- 基本学習機能（学校生活5場面）
- シンプルなクイズモード
- ユーザー登録・ログイン
- 基本的な進捗表示

### Phase 2（ゲーミフィケーション）- 1.5ヶ月
- キャラクター育成システム
- ポイント・レベルシステム
- デイリーボーナス
- 達成バッジ

### Phase 3（保護者機能）- 1ヶ月
- 保護者ダッシュボード
- レポート機能
- 通知システム
- 複数子ども管理

### Phase 4（収益化）- 0.5ヶ月
- 課金システム実装
- 広告実装
- A/Bテスト環境構築

## 9. 成功指標（KPI）

### 9.1 ユーザーエンゲージメント
- DAU/MAU比率：40%以上
- 平均セッション時間：15分以上
- 7日間継続率：60%以上
- 30日間継続率：40%以上

### 9.2 学習効果
- 1ヶ月での習得語彙数：100語以上
- クイズ正答率の向上：初回50%→1ヶ月後80%
- 復習完了率：70%以上

### 9.3 ビジネス指標
- 有料会員転換率：5%以上
- ARPU：月額100円以上
- ユーザー獲得コスト（CAC）：500円以下
- LTV/CAC比率：3以上

## 10. リスクと対策

### 10.1 技術的リスク
- **リスク**: オフライン時のデータ同期問題
- **対策**: SwiftData＋CloudKitの適切な同期戦略

### 10.2 コンテンツリスク
- **リスク**: イラスト作成の工数過多
- **対策**: Canvaテンプレート化、段階的リリース

### 10.3 ユーザー獲得リスク
- **リスク**: 競合アプリとの差別化不足
- **対策**: 学校生活特化、保護者口コミ促進

## 12. アーキテクチャ詳細（SVVS）

### 12.1 Store層
**役割**: データの取得・保持・管理
- APIやDBからデータを取得し、アプリ全体で共有するデータを保持
- SwiftDataのModelContainerとの連携
- Repositoryを介したAPI通信
- @Publishedプロパティによるデータ変更の通知（Combine必須）
- シングルトンパターンで実装（例：UserStore.shared）

**実装例**:
```swift
@MainActor
protocol VocabularyStoreProtocol: ObservableObject {
    var vocabulariesPublisher: Published<[Vocabulary]>.Publisher { get }
    var errorPublisher: Published<Error?>.Publisher { get }
    func fetchVocabularies(for scene: Scene) async
}

@MainActor
class VocabularyStore: ObservableObject, VocabularyStoreProtocol {
    static let shared = VocabularyStore()
    @Published var vocabularies: [Vocabulary] = []
    @Published var error: Error?
    
    var vocabulariesPublisher: Published<[Vocabulary]>.Publisher { $vocabularies }
    var errorPublisher: Published<Error?>.Publisher { $error }
}
```

### 12.2 View層
**役割**: UI表示
- SwiftUIビューの実装
- ViewStateを@Stateで保持（iOS 17+の@Observableを活用）
- ユーザーアクションをViewStateに委譲
- ルビ表示用のカスタムビューコンポーネント

**実装例**:
```swift
struct LearningView: View {
    @State private var viewState = LearningViewState()
    
    var body: some View {
        VStack {
            if viewState.isLoading {
                ProgressView()
            } else if let vocabulary = viewState.currentVocabulary {
                VocabularyCard(vocabulary: vocabulary)
            }
        }
        .task {
            await viewState.onAppear()
        }
    }
}
```

### 12.3 ViewState層  
**役割**: Viewの状態管理とビジネスロジック
- @Observable マクロを使用（iOS 17+）
- Storeの@Publishedプロパティを購読（Combineは購読部分のみ使用）
- ユーザーアクションの処理とStoreへの指示
- Viewに表示するデータの加工・整形
- プロトコルによるテスタビリティの確保

**実装例**:
```swift
@MainActor
@Observable
class LearningViewState {
    private let vocabularyStore: any VocabularyStoreProtocol
    private let userStore: any UserStoreProtocol
    
    var currentVocabulary: Vocabulary?
    var isLoading: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init(vocabularyStore: any VocabularyStoreProtocol = VocabularyStore.shared,
         userStore: any UserStoreProtocol = UserStore.shared) {
        self.vocabularyStore = vocabularyStore
        self.userStore = userStore
        setupStoreBindings()
    }
    
    private func setupStoreBindings() {
        // Combineは購読部分のみ使用
        vocabularyStore.vocabulariesPublisher
            .sink { [weak self] vocabularies in
                self?.updateCurrentVocabulary(from: vocabularies)
            }
            .store(in: &cancellables)
    }
    
    func onAppear() async {
        isLoading = true
        await vocabularyStore.fetchVocabularies(for: currentScene)
        isLoading = false
    }
}
```

### 12.4 Repository層（Service層を改名）
**役割**: 外部通信の抽象化
- Firebase APIとの通信
- SwiftDataのクエリ実行
- エラーハンドリング
- データ変換処理

### 12.5 データフローの流れ
1. **ユーザーアクション**: View → ViewState
2. **データ取得依頼**: ViewState → Store
3. **外部通信**: Store → Repository → API/DB
4. **データ保持**: Repository → Store（@Published更新）
5. **UI更新**: Store → ViewState（Combine購読） → View（@Observable経由）

### 12.6 @ObservableとCombineの使い分け
- **@Observable使用箇所**:
  - ViewStateクラス全般
  - Viewから直接参照されるプロパティ
  - UIの状態管理（isLoading、エラー状態など）
  
- **Combine使用箇所**:
  - Store層の@Publishedプロパティ（ObservableObjectプロトコル準拠のため必須）
  - Store → ViewState間のデータ購読
  - 複数のストリームを合成する必要がある場合

### 12.7 テスト戦略
- **ViewState**: Mockストアを使用したユニットテスト
- **Store**: MockRepositoryを使用したユニットテスト
- **View**: ViewStateのテスト用実装によるUIテスト
- swift-testingフレームワークの活用