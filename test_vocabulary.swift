import Foundation

// VocabularyDataの構造をテストするための簡単なスクリプト
// 実際のカテゴリー名を確認する

struct MockVocabulary {
    let word: String
    let category: String
}

let vocabularies = [
    MockVocabulary(word: "黒板", category: "教室"),
    MockVocabulary(word: "給食", category: "給食"),
    MockVocabulary(word: "休み時間", category: "休み時間"),
    MockVocabulary(word: "掃除", category: "掃除の時間"),
    MockVocabulary(word: "朝の会", category: "朝の会・帰りの会")
]

enum SceneCategory: String, CaseIterable {
    case morningAssembly = "morning_assembly"
    case classTime = "class_time"
    case lunchTime = "lunch_time"
    case cleaningTime = "cleaning_time"
    case breakTime = "break_time"
}

func getCategoryName(for sceneCategory: SceneCategory) -> String {
    switch sceneCategory {
    case .morningAssembly:
        return "朝の会・帰りの会"
    case .classTime:
        return "教室"
    case .lunchTime:
        return "給食"
    case .cleaningTime:
        return "掃除の時間"
    case .breakTime:
        return "休み時間"
    }
}

// テスト実行
for scene in SceneCategory.allCases {
    let targetCategory = getCategoryName(for: scene)
    let matchingVocabs = vocabularies.filter { $0.category == targetCategory }
    print("Scene: \(scene.rawValue) -> Category: \(targetCategory) -> Count: \(matchingVocabs.count)")
}