# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.
必ず日本語でチャットに回答してください

## Project Overview
Japanese Vocabulary Quest (ことばクエスト) is an iOS educational app for elementary school students (ages 6-9) to improve Japanese vocabulary through gamified learning. Built with SwiftUI, SwiftData, and modern iOS development practices.

## Development Commands

### Building and Running
```bash
# Open project in Xcode
open JapaneseVocabularyQuest/JapaneseVocabularyQuest.xcodeproj

# Build from command line (use Xcode for development)
xcodebuild -project JapaneseVocabularyQuest/JapaneseVocabularyQuest.xcodeproj -scheme JapaneseVocabularyQuest -destination 'platform=iOS Simulator,name=iPhone 15' build
```

### Testing
```bash
# Run all tests
xcodebuild test -project JapaneseVocabularyQuest/JapaneseVocabularyQuest.xcodeproj -scheme JapaneseVocabularyQuest -destination 'platform=iOS Simulator,name=iPhone 15'

# Run unit tests only
xcodebuild test -project JapaneseVocabularyQuest/JapaneseVocabularyQuest.xcodeproj -scheme JapaneseVocabularyQuest -destination 'platform=iOS Simulator,name=iPhone 15' -only-testing:JapaneseVocabularyQuestTests

# Run UI tests only
xcodebuild test -project JapaneseVocabularyQuest/JapaneseVocabularyQuest.xcodeproj -scheme JapaneseVocabularyQuest -destination 'platform=iOS Simulator,name=iPhone 15' -only-testing:JapaneseVocabularyQuestUITests
```

## Architecture

### Current State
The project is in initial setup phase with basic SwiftUI + SwiftData boilerplate. Main components:
- `JapaneseVocabularyQuestApp.swift`: App entry point with SwiftData ModelContainer setup
- `ContentView.swift`: Basic SwiftUI view with list functionality
- `Item.swift`: Simple SwiftData model for demonstration

### Planned Architecture (SVVS Pattern)
- **Store**: Data management with @Published properties using Combine
- **View**: SwiftUI views with @State ViewState instances
- **ViewState**: @Observable classes for UI state management (iOS 17+)
- **Service/Repository**: External API and database communication layer

### Technology Stack
- **UI**: SwiftUI (iOS 18.5+)
- **Data**: SwiftData for local persistence, CloudKit for sync
- **Testing**: Swift Testing framework (@Test) + XCTest for UI tests
- **Future Integrations**: Firebase (Auth, Firestore, Storage), StoreKit 2

### Key Project Structure
```
JapaneseVocabularyQuest/
├── JapaneseVocabularyQuest/          # Main app source
├── JapaneseVocabularyQuestTests/     # Unit tests (Swift Testing)
└── JapaneseVocabularyQuestUITests/   # UI tests (XCTest)
```

## Requirements Document
See `RDD.md` for comprehensive feature specifications, including:
- User personas and learning objectives
- Detailed data models (User, Vocabulary, Scene, Character, etc.)
- Game mechanics and progression system
- 4-phase development plan
- Business model and monetization strategy

## Development Notes
- Uses modern iOS 18.5+ APIs with SwiftUI and SwiftData
- CloudKit entitlements configured for data sync
- Bundle ID: jp.hray.JapaneseVocabularyQuest
- Swift Testing framework for new tests, XCTest for UI testing
- Project targets Japanese elementary school vocabulary education market

## 作業完了時の必須行動

* `.claude/workspace/task.md`作業進捗を記録する必要がある
* これは作業の一時記録のファイル
* このファイルには、作業のスコープ、完了の定義、進捗状況、Claude Codeでのコード生成割合を記録する
* このファイルの目的は、上記を記録することにcompactによるコンテキスト喪失を防止
* 作業開始と完了時に`.claude/workspace/task.md`を更新すること

## 実装について

* SwiftDocと、実装意図のコメントはつけるようにしてください。

## ビルドについて

* シュミレータは iOS16.5 の iPhone 16 にしてください

# ファイル操作について

## MCP Server effortlessly-mcpの使用

**重要**: このプロジェクトでは、ファイル操作に effortlessly-mcp の基本ツール群を優先的に使用してください。

### 利用可能なツール

1. **`mcp__effortlessly-mcp__read_file`**
   - ファイル内容の読み取り
   - UTF-8エンコーディング対応
   - パラメータ: `file_path`, `encoding`(optional)

2. **`mcp__effortlessly-mcp__list_directory`**
   - ディレクトリ一覧の取得
   - 再帰検索対応
   - パラメータ: `directory_path`, `recursive`(optional), `pattern`(optional)

3. **`mcp__effortlessly-mcp__get_file_metadata`**
   - ファイル/ディレクトリのメタデータ取得
   - 権限、サイズ、更新日時等の詳細情報
   - パラメータ: `file_path`

4. **`mcp__effortlessly-mcp__search_files`**
   - ファイル検索とパターンマッチング
   - ファイル名/内容での検索対応
   - パラメータ: `directory`, `file_pattern`(optional), `content_pattern`(optional), `recursive`(optional), `case_sensitive`(optional), `max_depth`(optional), `max_results`(optional), `include_content`(optional)

5. **`mcp__effortlessly-mcp__echo`**
   - 接続テスト用エコー機能
   - パラメータ: `message`, `prefix`(optional)

### パフォーマンス比較と推奨事項

**effortlessly-mcp vs serena パフォーマンス**:
- ✅ **effortlessly-mcp**: 基本操作（検索、読み取り、簡単な編集）で高速・安定
- ⚠️ **serena**: 複雑な正規表現検索・置換で処理時間が長い場合あり（5分以上）

**推奨使い分け**:
1. **基本ファイル操作**: effortlessly-mcp を優先使用
2. **複雑なコード解析**: 必要に応じてserenaを併用（時間がかかる場合は中断を検討）
3. **大きなファイル編集**: 標準Editツールが最も確実で高速

### 使用方針

- **第一選択**: effortlessly-mcp のツール群を使用
- **フォールバック**: 必要に応じて serena や標準ツールを併用
- **テスト目的**: これらのツールを使用することで、開発中のMCPサーバーの動作確認も兼ねる

### 今回の実装例（RDD更新作業）

**成功パターン**:
1. `mcp__effortlessly-mcp__search_files`: 特定のテキストパターンを高速検索
2. `mcp__effortlessly-mcp__read_file`: 該当箇所の確認
3. 標準`Edit`ツール: 確実で高速な文書更新

**避けるべきパターン**:
- `mcp__serena__search_for_pattern`: 複雑な正規表現で長時間処理
- `mcp__serena__replace_regex`: 大きなファイルの置換で処理時間過大

## 🚨 重要：編集ツール使用ルール

### effortlessly-mcp編集ツールの優先使用

**必須**: Claude Codeの標準ツール（Edit, MultiEdit, Write）の代わりに、effortlessly-mcpの編集ツールを優先的に使用してください。

#### 利用可能な編集ツール

1. **`mcp__effortlessly-mcp__smart_edit_file`** ✅ **優先使用**
   - 標準Editツールの代替
   - 安全な置換操作（プレビュー、バックアップ、エラーハンドリング付き）
   - パラメータ: `file_path`, `old_text`, `new_text`, `case_sensitive?`, `replace_all?`, `preview_mode?`, `intent?`

2. **`mcp__effortlessly-mcp__smart_insert_text`** ✅ **優先使用**  
   - 柔軟な位置指定テキスト挿入
   - 行番号・相対位置・ファイル開始/終了での精密挿入
   - パラメータ: `file_path`, `text`, `position_type`, `line_number?`, `reference_text?`, `auto_indent?`, `preview_mode?`, `intent?`

#### 使用優先順位

1. **第一選択**: `mcp__effortlessly-mcp__smart_edit_file` （置換操作）
2. **第一選択**: `mcp__effortlessly-mcp__smart_insert_text` （挿入操作）
3. **フォールバック**: 標準 `Edit`, `MultiEdit`, `Write` ツール（MCPツールでエラーの場合のみ）

#### 必須の使用パターン

- ✅ **正しい使用例**: 
  ```
  mcp__effortlessly-mcp__smart_edit_file を使用してファイルを編集
  → 自動バックアップ作成、安全な置換処理
  ```

- ❌ **避けるべきパターン**:
  ```  
  標準 Edit ツールを直接使用
  → バックアップなし、テスト機会の損失
  ```