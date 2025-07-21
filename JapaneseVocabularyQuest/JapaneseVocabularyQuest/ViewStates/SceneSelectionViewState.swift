import Foundation
import Combine

@MainActor
@Observable
final class SceneSelectionViewState {
    var scenes: [LearningScene] = []
    var isLoading: Bool = false
    var error: Error?
    var selectedCategory: SceneCategory = .morningAssembly
    
    private let sceneStore: any SceneStoreProtocol
    private let userStore: any UserStoreProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(sceneStore: any SceneStoreProtocol = SceneStore.shared,
         userStore: any UserStoreProtocol = UserStore.shared) {
        self.sceneStore = sceneStore
        self.userStore = userStore
        setupStoreBindings()
    }
    
    private func setupStoreBindings() {
        sceneStore.scenesPublisher
            .sink { [weak self] scenes in
                self?.scenes = scenes
            }
            .store(in: &cancellables)
        
        sceneStore.isLoadingPublisher
            .sink { [weak self] isLoading in
                self?.isLoading = isLoading
            }
            .store(in: &cancellables)
        
        sceneStore.errorPublisher
            .sink { [weak self] error in
                self?.error = error
            }
            .store(in: &cancellables)
    }
    
    func onAppear() async {
        await sceneStore.fetchAllScenes()
    }
    
    func selectCategory(_ category: SceneCategory) async {
        selectedCategory = category
        await sceneStore.fetchScenesByCategory(category)
    }
    
    func refreshScenes() async {
        await sceneStore.fetchAllScenes()
    }
    
    var schoolLifeScenes: [LearningScene] {
        scenes.filter { scene in
            [SceneCategory.morningAssembly, .classTime, .lunchTime, .cleaningTime, .breakTime].contains(scene.category)
        }
    }
    
    var dailyLifeScenes: [LearningScene] {
        scenes.filter { scene in
            [SceneCategory.homeLife, .shopping, .park, .lessons].contains(scene.category)
        }
    }
    
    func getProgress(for scene: LearningScene) -> Double {
        return 0.0
    }
}