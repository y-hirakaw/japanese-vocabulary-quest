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

## .claude/workspace/task.mdについて

* これは作業の一時記録のファイル
* このファイルには、作業のスコープ、完了の定義、進捗状況、Claude Codeでのコード生成割合を記録する
* このファイルの目的は、上記を記録することにcompactによるコンテキスト喪失を防止
* 作業開始と完了時に`.claude/workspace/task.md`を更新すること