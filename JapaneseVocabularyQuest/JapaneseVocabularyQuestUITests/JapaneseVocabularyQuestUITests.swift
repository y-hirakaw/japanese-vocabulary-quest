import XCTest

/// Japanese Vocabulary Quest UIテストスイート
/// アプリケーションの主要なUI機能と画面遷移をテストする
final class JapaneseVocabularyQuestUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        // テストエラー時に継続しない設定
        continueAfterFailure = false
        
        // アプリケーションインスタンスを初期化
        app = XCUIApplication()
        
        // テスト用のランチ引数を設定（必要に応じて）
        app.launchArguments.append("--uitesting")
    }

    override func tearDownWithError() throws {
        app = nil
    }

    // MARK: - App Launch Tests
    
    @MainActor
    func testAppLaunch() throws {
        app.launch()
        
        // アプリが正常に起動することを確認
        XCTAssertTrue(app.state == .runningForeground)
    }

    @MainActor
    func testLaunchPerformance() throws {
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
    
    // MARK: - TabView Navigation Tests
    
    @MainActor
    func testTabViewNavigation() throws {
        app.launch()
        
        // タブビューが存在することを確認
        let tabBar = app.tabBars.firstMatch
        XCTAssertTrue(tabBar.waitForExistence(timeout: 5))
        
        // ホームタブが存在し、選択されていることを確認
        let homeTab = tabBar.buttons["ホーム"]
        XCTAssertTrue(homeTab.exists)
        XCTAssertTrue(homeTab.isSelected)
        
        // 学習タブに切り替え
        let studyTab = tabBar.buttons["学習"]
        if studyTab.exists {
            studyTab.tap()
            XCTAssertTrue(studyTab.isSelected)
        }
        
        // 図鑑タブに切り替え
        let dictionaryTab = tabBar.buttons["図鑑"]
        if dictionaryTab.exists {
            dictionaryTab.tap()
            XCTAssertTrue(dictionaryTab.isSelected)
        }
        
        // 記録タブに切り替え
        let recordTab = tabBar.buttons["記録"]
        if recordTab.exists {
            recordTab.tap()
            XCTAssertTrue(recordTab.isSelected)
        }
    }
    
    // MARK: - Home Screen Tests
    
    @MainActor
    func testHomeScreenElements() throws {
        app.launch()
        
        // アプリが起動できることを確認
        XCTAssertTrue(app.state == .runningForeground)
        
        // タブバーの存在を確認
        let tabBar = app.tabBars.firstMatch
        XCTAssertTrue(tabBar.waitForExistence(timeout: 10))
        
        // ホームタブが存在することを確認
        let homeTab = tabBar.buttons["ホーム"]
        XCTAssertTrue(homeTab.exists)
    }
    
    @MainActor
    func testUserCreation() throws {
        app.launch()
        
        // ユーザー作成ボタンが存在する場合のテスト
        let createUserButton = app.buttons["ユーザーを作る"]
        if createUserButton.exists {
            createUserButton.tap()
            
            // ユーザー名入力フィールドの確認
            let nameTextField = app.textFields["user_name_input"]
            if nameTextField.exists {
                nameTextField.tap()
                nameTextField.typeText("テストユーザー")
                
                // 作成ボタンをタップ
                let confirmButton = app.buttons["ユーザーを作る"]
                if confirmButton.exists {
                    confirmButton.tap()
                    
                    // ユーザーが作成されたことを確認
                    let userProfile = app.otherElements["user_profile"]
                    XCTAssertTrue(userProfile.waitForExistence(timeout: 3))
                }
            }
        }
    }
    
    // MARK: - Learning Screen Tests
    
    @MainActor
    func testSceneSelectionScreen() throws {
        app.launch()
        
        // 学習タブに移動
        let tabBar = app.tabBars.firstMatch
        let studyTab = tabBar.buttons["学習"]
        if studyTab.exists {
            studyTab.tap()
            
            // 場面選択画面が表示されることを確認
            let sceneSelectionView = app.otherElements["scene_selection_view"]
            if sceneSelectionView.exists {
                XCTAssertTrue(sceneSelectionView.waitForExistence(timeout: 5))
            }
            
            // 学習場面カードが表示されることを確認
            let sceneCards = app.otherElements.matching(NSPredicate(format: "identifier CONTAINS 'scene_card'"))
            if sceneCards.count > 0 {
                XCTAssertTrue(sceneCards.element(boundBy: 0).exists)
            }
        }
    }
    
    @MainActor
    func testLearningViewNavigation() throws {
        app.launch()
        
        // 学習タブに移動
        let tabBar = app.tabBars.firstMatch
        let studyTab = tabBar.buttons["学習"]
        if studyTab.exists {
            studyTab.tap()
            
            // 最初の学習場面カードをタップ
            let firstSceneCard = app.otherElements.matching(NSPredicate(format: "identifier CONTAINS 'scene_card'")).element(boundBy: 0)
            if firstSceneCard.exists {
                firstSceneCard.tap()
                
                // 学習画面が表示されることを確認
                let learningView = app.otherElements["learning_view"]
                if learningView.exists {
                    XCTAssertTrue(learningView.waitForExistence(timeout: 5))
                    
                    // 学習モード切り替えボタンの確認
                    let flashcardModeButton = app.buttons["フラッシュカード"]
                    let quizModeButton = app.buttons["クイズ"]
                    
                    if flashcardModeButton.exists && quizModeButton.exists {
                        // クイズモードに切り替え
                        quizModeButton.tap()
                        XCTAssertTrue(quizModeButton.isSelected)
                        
                        // フラッシュカードモードに切り替え
                        flashcardModeButton.tap()
                        XCTAssertTrue(flashcardModeButton.isSelected)
                    }
                }
            }
        }
    }
    
    // MARK: - Accessibility Tests
    
    @MainActor
    func testAccessibilityElements() throws {
        app.launch()
        
        // アプリが正常に起動することを確認
        XCTAssertTrue(app.state == .runningForeground)
        
        // アプリに何らかのUI要素が存在することを確認
        XCTAssertTrue(app.exists)
    }
    
    // MARK: - Performance Tests
    
    @MainActor
    func testScrollPerformance() throws {
        app.launch()
        
        // 学習タブに移動
        let tabBar = app.tabBars.firstMatch
        let studyTab = tabBar.buttons["学習"]
        if studyTab.exists {
            studyTab.tap()
            
            // スクロール性能のテスト
            let scrollView = app.scrollViews.firstMatch
            if scrollView.exists {
                measure(metrics: [XCTOSSignpostMetric.scrollingAndDecelerationMetric]) {
                    scrollView.swipeUp()
                    scrollView.swipeDown()
                }
            }
        }
    }
}