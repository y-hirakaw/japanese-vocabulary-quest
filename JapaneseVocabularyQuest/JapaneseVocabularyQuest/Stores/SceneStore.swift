import Foundation
import Combine
import SwiftData

@MainActor
protocol SceneStoreProtocol: AnyObject {
    var scenesPublisher: Published<[LearningScene]>.Publisher { get }
    var errorPublisher: Published<Error?>.Publisher { get }
    var isLoadingPublisher: Published<Bool>.Publisher { get }
    
    func fetchAllScenes() async
    func fetchScenesByCategory(_ category: SceneCategory) async
    func initializeDefaultScenes() async
}

@MainActor
final class SceneStore: ObservableObject, SceneStoreProtocol {
    static let shared = SceneStore()
    
    @Published private(set) var scenes: [LearningScene] = []
    @Published private(set) var error: Error?
    @Published private(set) var isLoading: Bool = false
    
    var scenesPublisher: Published<[LearningScene]>.Publisher { $scenes }
    var errorPublisher: Published<Error?>.Publisher { $error }
    var isLoadingPublisher: Published<Bool>.Publisher { $isLoading }
    
    private let repository: SceneRepositoryProtocol?
    
    /// Store初期化
    /// useMockRepository使用時は基本場面データを自動設定
    private init(repository: SceneRepositoryProtocol? = nil, useMockRepository: Bool = true) {
        self.repository = useMockRepository ? nil : repository
    }
    
    func fetchAllScenes() async {
        isLoading = true
        error = nil
        
        guard let repository = repository else {
            if scenes.isEmpty {
                scenes = SceneStore.createDefaultScenes()
            }
            isLoading = false
            return
        }
        
        do {
            let fetchedScenes = try await repository.fetchAll()
            
            if fetchedScenes.isEmpty {
                await initializeDefaultScenes()
            } else {
                scenes = fetchedScenes
            }
        } catch {
            self.error = error
            scenes = SceneStore.createDefaultScenes()
        }
        
        isLoading = false
    }
    
    func fetchScenesByCategory(_ category: SceneCategory) async {
        isLoading = true
        error = nil
        
        guard let repository = repository else {
            scenes = SceneStore.createDefaultScenes().filter { $0.category == category }
            isLoading = false
            return
        }
        
        do {
            let fetchedScenes = try await repository.fetchByCategory(category)
            scenes = fetchedScenes
        } catch {
            self.error = error
            scenes = []
        }
        
        isLoading = false
    }
    
    func initializeDefaultScenes() async {
        let defaultScenes = SceneStore.createDefaultScenes()
        
        guard let repository = repository else {
            scenes = defaultScenes
            return
        }
        
        do {
            for scene in defaultScenes {
                try await repository.save(scene)
            }
            scenes = defaultScenes
        } catch {
            self.error = error
        }
    }
    
    /// デフォルト学習場面データを生成
    /// 学校生活5場面の基本データを提供
    static nonisolated private func createDefaultScenes() -> [LearningScene] {
        return [
            LearningScene(
                title: "朝の会",
                rubyTitle: "あさのかい",
                description: "みんなで朝のあいさつをして、一日の始まりです",
                storyContent: "みんなで朝のあいさつをして、健康観察や今日の予定を確認します。",
                order: 1,
                category: .morningAssembly
            ),
            LearningScene(
                title: "授業時間",
                rubyTitle: "じゅぎょうじかん",
                description: "みんなで勉強する楽しい時間です",
                storyContent: "先生と一緒に楽しく勉強しましょう。",
                order: 2,
                category: .classTime
            ),
            LearningScene(
                title: "給食時間",
                rubyTitle: "きゅうしょくじかん",
                description: "みんなで美味しい給食を食べる時間です",
                storyContent: "栄養満点の給食をみんなで楽しく食べましょう。",
                order: 3,
                category: .lunchTime
            ),
            LearningScene(
                title: "掃除時間",
                rubyTitle: "そうじじかん",
                description: "みんなで教室をきれいにする時間です",
                storyContent: "使った教室をみんなで協力してきれいにしましょう。",
                order: 4,
                category: .cleaningTime
            ),
            LearningScene(
                title: "休み時間",
                rubyTitle: "やすみじかん",
                description: "友達と楽しく遊ぶ時間です",
                storyContent: "校庭や教室で友達と楽しく遊びましょう。",
                order: 5,
                category: .breakTime
            )
        ]
    }
}