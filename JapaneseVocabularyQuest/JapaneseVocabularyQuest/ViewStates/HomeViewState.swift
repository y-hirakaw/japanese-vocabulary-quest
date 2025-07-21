import Foundation
import Combine

@MainActor
@Observable
final class HomeViewState {
    var currentUser: User?
    var isLoading: Bool = false
    var error: Error?
    var showUserCreation: Bool = false
    
    private let userStore: any UserStoreProtocol
    private let sceneStore: any SceneStoreProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(userStore: (any UserStoreProtocol)? = nil,
         sceneStore: (any SceneStoreProtocol)? = nil) {
        self.userStore = userStore ?? UserStore.shared
        self.sceneStore = sceneStore ?? SceneStore.shared
        setupStoreBindings()
    }
    
    private func setupStoreBindings() {
        userStore.currentUserPublisher
            .sink { [weak self] user in
                self?.currentUser = user
                self?.showUserCreation = user == nil
            }
            .store(in: &cancellables)
        
        userStore.isLoadingPublisher
            .sink { [weak self] isLoading in
                self?.isLoading = isLoading
            }
            .store(in: &cancellables)
        
        userStore.errorPublisher
            .sink { [weak self] error in
                self?.error = error
            }
            .store(in: &cancellables)
    }
    
    func onAppear() async {
        await userStore.fetchCurrentUser()
        if currentUser == nil {
            showUserCreation = true
        }
        await sceneStore.fetchAllScenes()
    }
    
    func createUser(name: String) async {
        await userStore.createUser(name: name)
        showUserCreation = false
    }
    
    var userLevelProgress: Double {
        guard let user = currentUser else { return 0.0 }
        let pointsForCurrentLevel = user.level * 100
        let pointsForNextLevel = (user.level + 1) * 100
        let progressPoints = max(0, user.totalPoints - pointsForCurrentLevel)
        let totalLevelPoints = pointsForNextLevel - pointsForCurrentLevel
        return Double(progressPoints) / Double(totalLevelPoints)
    }
    
    var nextLevelPoints: Int {
        guard let user = currentUser else { return 100 }
        return (user.level + 1) * 100 - user.totalPoints
    }
}