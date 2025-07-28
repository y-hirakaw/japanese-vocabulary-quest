import Foundation
import SwiftData

/// 語彙データの初期化と管理を行うマネージャー
/// アプリ起動時に初期語彙データをデータベースに投入する責任を持つ
@MainActor
final class VocabularyDataManager {
    private let modelContext: ModelContext
    
    /// 初期化
    /// - Parameter modelContext: SwiftDataのモデルコンテキスト
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    /// 初期語彙データを設定
    /// データベースが空の場合のみ、初期データを投入する
    func setupInitialDataIfNeeded() async throws {
        // 既存データの確認
        let descriptor = FetchDescriptor<Vocabulary>()
        let existingVocabularies = try modelContext.fetch(descriptor)
        
        // データが既に存在する場合はスキップ
        if !existingVocabularies.isEmpty {
            print("語彙データは既に存在します。スキップします。")
            return
        }
        
        print("初期語彙データを投入します...")
        
        // 初期データの投入
        let initialVocabularies = createInitialVocabularies()
        for vocabulary in initialVocabularies {
            modelContext.insert(vocabulary)
        }
        
        try modelContext.save()
        print("初期語彙データを\(initialVocabularies.count)件投入しました。")
    }
    
    /// 初期語彙データを生成
    /// - Returns: 初期語彙データの配列
    private func createInitialVocabularies() -> [Vocabulary] {
        var vocabularies: [Vocabulary] = []
        
        // 教室の語彙
        vocabularies.append(contentsOf: createClassroomVocabularies())
        
        // 給食の語彙
        vocabularies.append(contentsOf: createLunchVocabularies())
        
        // 休み時間の語彙
        vocabularies.append(contentsOf: createBreakTimeVocabularies())
        
        // 掃除の時間の語彙
        vocabularies.append(contentsOf: createCleaningTimeVocabularies())
        
        // 朝の会・帰りの会の語彙
        vocabularies.append(contentsOf: createMorningMeetingVocabularies())
        
        return vocabularies
    }
    
    /// 教室関連の語彙を生成
    private func createClassroomVocabularies() -> [Vocabulary] {
        return [
            Vocabulary(
                word: "黒板",
                reading: "こくばん",
                rubyText: "｜黒板《こくばん》",
                meaning: "先生が字を書く大きな板",
                category: "教室",
                difficulty: 1,
                exampleSentences: ["先生が｜黒板《こくばん》に字を書きます。", "｜黒板《こくばん》をきれいに｜消《け》しましょう。"],
                meaningEn: "blackboard",
                jlptLevel: 5,
                romaji: "kokuban"
            ),
            Vocabulary(
                word: "教科書",
                reading: "きょうかしょ",
                rubyText: "｜教科書《きょうかしょ》",
                meaning: "勉強するための本",
                category: "教室",
                difficulty: 1,
                exampleSentences: ["｜教科書《きょうかしょ》を｜開《ひら》いてください。", "｜新《あたら》しい｜教科書《きょうかしょ》をもらいました。"],
                meaningEn: "textbook",
                jlptLevel: 5,
                romaji: "kyoukasho"
            ),
            Vocabulary(
                word: "筆箱",
                reading: "ふでばこ",
                rubyText: "｜筆箱《ふでばこ》",
                meaning: "えんぴつや消しゴムを入れる箱",
                category: "教室",
                difficulty: 1,
                exampleSentences: ["｜筆箱《ふでばこ》に｜鉛筆《えんぴつ》を入れます。", "｜新《あたら》しい｜筆箱《ふでばこ》を｜買《か》いました。"],
                meaningEn: "pencil case",
                jlptLevel: 5,
                romaji: "fudebako"
            ),
            Vocabulary(
                word: "宿題",
                reading: "しゅくだい",
                rubyText: "｜宿題《しゅくだい》",
                meaning: "家でする勉強",
                category: "教室",
                difficulty: 2,
                exampleSentences: ["｜今日《きょう》の｜宿題《しゅくだい》は｜算数《さんすう》です。", "｜宿題《しゅくだい》を｜忘《わす》れないでください。"],
                meaningEn: "homework",
                jlptLevel: 5,
                romaji: "shukudai"
            ),
            Vocabulary(
                word: "先生",
                reading: "せんせい",
                rubyText: "｜先生《せんせい》",
                meaning: "学校で教える人",
                category: "教室",
                difficulty: 1,
                exampleSentences: ["｜先生《せんせい》に｜質問《しつもん》します。", "｜先生《せんせい》が｜説明《せつめい》してくれました。"],
                meaningEn: "teacher",
                jlptLevel: 5,
                romaji: "sensei"
            )
        ]
    }
    
    /// 給食関連の語彙を生成
    private func createLunchVocabularies() -> [Vocabulary] {
        return [
            Vocabulary(
                word: "給食",
                reading: "きゅうしょく",
                rubyText: "｜給食《きゅうしょく》",
                meaning: "学校で食べる昼ごはん",
                category: "給食",
                difficulty: 1,
                exampleSentences: ["｜今日《きょう》の｜給食《きゅうしょく》はカレーです。", "｜給食《きゅうしょく》の｜時間《じかん》が｜楽《たの》しみです。"],
                meaningEn: "school lunch",
                jlptLevel: 4,
                romaji: "kyuushoku"
            ),
            Vocabulary(
                word: "配膳",
                reading: "はいぜん",
                rubyText: "｜配膳《はいぜん》",
                meaning: "食べ物を配ること",
                category: "給食",
                difficulty: 3,
                exampleSentences: ["｜給食《きゅうしょく》の｜配膳《はいぜん》をします。", "｜配膳《はいぜん》｜当番《とうばん》になりました。"],
                meaningEn: "serving food",
                jlptLevel: 3,
                romaji: "haizen"
            ),
            Vocabulary(
                word: "おかわり",
                reading: "おかわり",
                rubyText: "おかわり",
                meaning: "もう一度もらうこと",
                category: "給食",
                difficulty: 1,
                exampleSentences: ["｜牛乳《ぎゅうにゅう》のおかわりをください。", "おかわりはありますか？"],
                meaningEn: "seconds",
                jlptLevel: 5,
                romaji: "okawari"
            ),
            Vocabulary(
                word: "完食",
                reading: "かんしょく",
                rubyText: "｜完食《かんしょく》",
                meaning: "全部食べること",
                category: "給食",
                difficulty: 2,
                exampleSentences: ["｜今日《きょう》は｜完食《かんしょく》できました。", "クラス｜全員《ぜんいん》が｜完食《かんしょく》しました。"],
                meaningEn: "eating everything",
                jlptLevel: 3,
                romaji: "kanshoku"
            ),
            Vocabulary(
                word: "献立",
                reading: "こんだて",
                rubyText: "｜献立《こんだて》",
                meaning: "食事のメニュー",
                category: "給食",
                difficulty: 3,
                exampleSentences: ["｜今日《きょう》の｜献立《こんだて》を｜見《み》ましょう。", "｜献立表《こんだてひょう》を｜配《くば》ります。"],
                meaningEn: "menu",
                jlptLevel: 3,
                romaji: "kondate"
            )
        ]
    }
    
    /// 休み時間関連の語彙を生成
    private func createBreakTimeVocabularies() -> [Vocabulary] {
        return [
            Vocabulary(
                word: "休み時間",
                reading: "やすみじかん",
                rubyText: "｜休《やす》み｜時間《じかん》",
                meaning: "授業と授業の間の休憩時間",
                category: "休み時間",
                difficulty: 1,
                exampleSentences: ["｜休《やす》み｜時間《じかん》に｜遊《あそ》びます。", "もうすぐ｜休《やす》み｜時間《じかん》です。"],
                meaningEn: "break time",
                jlptLevel: 5,
                romaji: "yasumijikan"
            ),
            Vocabulary(
                word: "校庭",
                reading: "こうてい",
                rubyText: "｜校庭《こうてい》",
                meaning: "学校の運動場",
                category: "休み時間",
                difficulty: 2,
                exampleSentences: ["｜校庭《こうてい》でサッカーをします。", "｜校庭《こうてい》で｜遊《あそ》びましょう。"],
                meaningEn: "schoolyard",
                jlptLevel: 4,
                romaji: "koutei"
            ),
            Vocabulary(
                word: "鬼ごっこ",
                reading: "おにごっこ",
                rubyText: "｜鬼《おに》ごっこ",
                meaning: "鬼が人を追いかける遊び",
                category: "休み時間",
                difficulty: 1,
                exampleSentences: ["｜鬼《おに》ごっこをして｜遊《あそ》びました。", "｜鬼《おに》ごっこの｜鬼《おに》になりました。"],
                meaningEn: "tag",
                jlptLevel: 4,
                romaji: "onigokko"
            ),
            Vocabulary(
                word: "図書室",
                reading: "としょしつ",
                rubyText: "｜図書室《としょしつ》",
                meaning: "本を読む部屋",
                category: "休み時間",
                difficulty: 2,
                exampleSentences: ["｜図書室《としょしつ》で｜本《ほん》を｜借《か》りました。", "｜図書室《としょしつ》は｜静《しず》かにします。"],
                meaningEn: "library",
                jlptLevel: 4,
                romaji: "toshoshitsu"
            ),
            Vocabulary(
                word: "なわとび",
                reading: "なわとび",
                rubyText: "なわとび",
                meaning: "縄を回して跳ぶ運動",
                category: "休み時間",
                difficulty: 1,
                exampleSentences: ["なわとびで｜二重跳《にじゅうと》びができました。", "なわとび｜大会《たいかい》があります。"],
                meaningEn: "jump rope",
                jlptLevel: 4,
                romaji: "nawatobi"
            )
        ]
    }
    
    /// 掃除の時間関連の語彙を生成
    private func createCleaningTimeVocabularies() -> [Vocabulary] {
        return [
            Vocabulary(
                word: "掃除",
                reading: "そうじ",
                rubyText: "｜掃除《そうじ》",
                meaning: "きれいにすること",
                category: "掃除の時間",
                difficulty: 1,
                exampleSentences: ["｜教室《きょうしつ》を｜掃除《そうじ》します。", "｜掃除《そうじ》の｜時間《じかん》です。"],
                meaningEn: "cleaning",
                jlptLevel: 5,
                romaji: "souji"
            ),
            Vocabulary(
                word: "雑巾",
                reading: "ぞうきん",
                rubyText: "｜雑巾《ぞうきん》",
                meaning: "床や机を拭く布",
                category: "掃除の時間",
                difficulty: 2,
                exampleSentences: ["｜雑巾《ぞうきん》で｜床《ゆか》を｜拭《ふ》きます。", "｜雑巾《ぞうきん》を｜絞《しぼ》ります。"],
                meaningEn: "cleaning cloth",
                jlptLevel: 3,
                romaji: "zoukin"
            ),
            Vocabulary(
                word: "ほうき",
                reading: "ほうき",
                rubyText: "ほうき",
                meaning: "ゴミを掃く道具",
                category: "掃除の時間",
                difficulty: 1,
                exampleSentences: ["ほうきで｜教室《きょうしつ》を｜掃《は》きます。", "ほうきとちりとりを｜使《つか》います。"],
                meaningEn: "broom",
                jlptLevel: 4,
                romaji: "houki"
            ),
            Vocabulary(
                word: "ちりとり",
                reading: "ちりとり",
                rubyText: "ちりとり",
                meaning: "ゴミを集める道具",
                category: "掃除の時間",
                difficulty: 1,
                exampleSentences: ["ちりとりでゴミを｜集《あつ》めます。", "ほうきとちりとりはセットです。"],
                meaningEn: "dustpan",
                jlptLevel: 4,
                romaji: "chiritori"
            ),
            Vocabulary(
                word: "当番",
                reading: "とうばん",
                rubyText: "｜当番《とうばん》",
                meaning: "順番に仕事をする人",
                category: "掃除の時間",
                difficulty: 2,
                exampleSentences: ["｜今日《きょう》は｜掃除《そうじ》｜当番《とうばん》です。", "｜当番《とうばん》｜表《ひょう》を｜見《み》ましょう。"],
                meaningEn: "person on duty",
                jlptLevel: 4,
                romaji: "touban"
            )
        ]
    }
    
    /// 朝の会・帰りの会関連の語彙を生成
    private func createMorningMeetingVocabularies() -> [Vocabulary] {
        return [
            Vocabulary(
                word: "朝の会",
                reading: "あさのかい",
                rubyText: "｜朝《あさ》の｜会《かい》",
                meaning: "朝、みんなで集まる時間",
                category: "朝の会・帰りの会",
                difficulty: 1,
                exampleSentences: ["｜朝《あさ》の｜会《かい》で｜挨拶《あいさつ》をします。", "｜朝《あさ》の｜会《かい》が｜始《はじ》まります。"],
                meaningEn: "morning meeting",
                jlptLevel: 5,
                romaji: "asanokai"
            ),
            Vocabulary(
                word: "日直",
                reading: "にっちょく",
                rubyText: "｜日直《にっちょく》",
                meaning: "その日の当番の人",
                category: "朝の会・帰りの会",
                difficulty: 2,
                exampleSentences: ["｜今日《きょう》の｜日直《にっちょく》は｜誰《だれ》ですか。", "｜日直《にっちょく》が｜号令《ごうれい》をかけます。"],
                meaningEn: "daily duty person",
                jlptLevel: 3,
                romaji: "nicchoku"
            ),
            Vocabulary(
                word: "連絡帳",
                reading: "れんらくちょう",
                rubyText: "｜連絡帳《れんらくちょう》",
                meaning: "先生と家の人が連絡する帳面",
                category: "朝の会・帰りの会",
                difficulty: 3,
                exampleSentences: ["｜連絡帳《れんらくちょう》を｜出《だ》してください。", "｜連絡帳《れんらくちょう》に｜明日《あした》の｜持《も》ち｜物《もの》を｜書《か》きます。"],
                meaningEn: "communication notebook",
                jlptLevel: 3,
                romaji: "renrakuchou"
            ),
            Vocabulary(
                word: "出席",
                reading: "しゅっせき",
                rubyText: "｜出席《しゅっせき》",
                meaning: "学校に来ること",
                category: "朝の会・帰りの会",
                difficulty: 2,
                exampleSentences: ["｜今日《きょう》は｜全員《ぜんいん》｜出席《しゅっせき》です。", "｜出席《しゅっせき》｜番号《ばんごう》を｜言《い》います。"],
                meaningEn: "attendance",
                jlptLevel: 4,
                romaji: "shusseki"
            ),
            Vocabulary(
                word: "下校",
                reading: "げこう",
                rubyText: "｜下校《げこう》",
                meaning: "学校から帰ること",
                category: "朝の会・帰りの会",
                difficulty: 2,
                exampleSentences: ["｜下校《げこう》｜時間《じかん》になりました。", "｜安全《あんぜん》に｜下校《げこう》しましょう。"],
                meaningEn: "leaving school",
                jlptLevel: 3,
                romaji: "gekou"
            )
        ]
    }
}