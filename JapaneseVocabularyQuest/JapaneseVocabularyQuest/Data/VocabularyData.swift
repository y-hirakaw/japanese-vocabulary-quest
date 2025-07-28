import Foundation

/// 小学生向けの日本語語彙サンプルデータ
/// 学校生活の各場面に対応した語彙を提供する
struct VocabularyData {
    /// 全てのサンプル語彙データを提供する
    static let allVocabularies: [Vocabulary] = [
        // 教室・授業時間の語彙
        Vocabulary(
            word: "黒板",
            reading: "こくばん",
            rubyText: "｜黒板《こくばん》",
            meaning: "先生が字や絵を書く黒い板",
            category: "教室",
            difficulty: 1,
            exampleSentences: ["先生が黒板に字を書きました。"]
        ),
        Vocabulary(
            word: "机",
            reading: "つくえ",
            rubyText: "｜机《つくえ》",
            meaning: "勉強するときに使う台",
            category: "教室",
            difficulty: 1,
            exampleSentences: ["机の上にノートを置きます。"]
        ),
        Vocabulary(
            word: "椅子",
            reading: "いす",
            rubyText: "｜椅子《いす》",
            meaning: "座るための道具",
            category: "教室",
            difficulty: 1,
            exampleSentences: ["椅子に静かに座りましょう。"]
        ),
        Vocabulary(
            word: "鉛筆",
            reading: "えんぴつ",
            rubyText: "｜鉛筆《えんぴつ》",
            meaning: "字を書くための道具",
            category: "教室",
            difficulty: 1,
            exampleSentences: ["鉛筆で名前を書きます。"]
        ),
        Vocabulary(
            word: "消しゴム",
            reading: "けしゴム",
            rubyText: "｜消《け》しゴム",
            meaning: "鉛筆で書いた字を消すもの",
            category: "教室",
            difficulty: 1,
            exampleSentences: ["間違えたら消しゴムで消します。"]
        ),
        Vocabulary(
            word: "ノート",
            reading: "ノート",
            rubyText: "ノート",
            meaning: "字を書くための本",
            category: "教室",
            difficulty: 1,
            exampleSentences: ["ノートに宿題を書きました。"]
        ),
        Vocabulary(
            word: "教科書",
            reading: "きょうかしょ",
            rubyText: "｜教科書《きょうかしょ》",
            meaning: "勉強に使う本",
            category: "教室",
            difficulty: 2,
            exampleSentences: ["国語の教科書を開いてください。"]
        ),
        Vocabulary(
            word: "筆箱",
            reading: "ふでばこ",
            rubyText: "｜筆箱《ふでばこ》",
            meaning: "鉛筆や消しゴムを入れる箱",
            category: "教室",
            difficulty: 2,
            exampleSentences: ["筆箱の中に鉛筆が入っています。"]
        ),
        
        // 給食時間の語彙
        Vocabulary(
            word: "給食",
            reading: "きゅうしょく",
            rubyText: "｜給食《きゅうしょく》",
            meaning: "学校で食べる昼ご飯",
            category: "給食",
            difficulty: 1,
            exampleSentences: ["今日の給食はカレーライスです。"]
        ),
        Vocabulary(
            word: "配膳",
            reading: "はいぜん",
            rubyText: "｜配膳《はいぜん》",
            meaning: "料理をお皿に分けて配ること",
            category: "給食",
            difficulty: 2,
            exampleSentences: ["給食当番が配膳をします。"]
        ),
        Vocabulary(
            word: "当番",
            reading: "とうばん",
            rubyText: "｜当番《とうばん》",
            meaning: "順番に仕事をする人",
            category: "給食",
            difficulty: 1,
            exampleSentences: ["今日は給食当番の日です。"]
        ),
        Vocabulary(
            word: "献立",
            reading: "こんだて",
            rubyText: "｜献立《こんだて》",
            meaning: "食事のメニュー",
            category: "給食",
            difficulty: 2,
            exampleSentences: ["明日の献立はハンバーグです。"]
        ),
        Vocabulary(
            word: "食器",
            reading: "しょっき",
            rubyText: "｜食器《しょっき》",
            meaning: "食事に使うお皿やお椀",
            category: "給食",
            difficulty: 2,
            exampleSentences: ["食器をきれいに洗いました。"]
        ),
        Vocabulary(
            word: "おかわり",
            reading: "おかわり",
            rubyText: "おかわり",
            meaning: "もう一度もらうこと",
            category: "給食",
            difficulty: 1,
            exampleSentences: ["ご飯のおかわりをください。"]
        ),
        
        // 休み時間の語彙
        Vocabulary(
            word: "休み時間",
            reading: "やすみじかん",
            rubyText: "｜休《やす》み｜時間《じかん》",
            meaning: "授業と授業の間の時間",
            category: "休み時間",
            difficulty: 1,
            exampleSentences: ["休み時間に友達と遊びます。"]
        ),
        Vocabulary(
            word: "校庭",
            reading: "こうてい",
            rubyText: "｜校庭《こうてい》",
            meaning: "学校の運動場",
            category: "休み時間",
            difficulty: 2,
            exampleSentences: ["校庭でサッカーをしました。"]
        ),
        Vocabulary(
            word: "図書室",
            reading: "としょしつ",
            rubyText: "｜図書室《としょしつ》",
            meaning: "本がたくさんある部屋",
            category: "休み時間",
            difficulty: 2,
            exampleSentences: ["図書室で本を借りました。"]
        ),
        Vocabulary(
            word: "廊下",
            reading: "ろうか",
            rubyText: "｜廊下《ろうか》",
            meaning: "教室をつなぐ通り道",
            category: "休み時間",
            difficulty: 1,
            exampleSentences: ["廊下は走らないでください。"]
        ),
        Vocabulary(
            word: "階段",
            reading: "かいだん",
            rubyText: "｜階段《かいだん》",
            meaning: "上の階に上がるための段",
            category: "休み時間",
            difficulty: 1,
            exampleSentences: ["階段を使って二階に行きます。"]
        ),
        
        // 掃除の時間の語彙
        Vocabulary(
            word: "掃除",
            reading: "そうじ",
            rubyText: "｜掃除《そうじ》",
            meaning: "きれいにすること",
            category: "掃除の時間",
            difficulty: 1,
            exampleSentences: ["毎日教室の掃除をします。"]
        ),
        Vocabulary(
            word: "ほうき",
            reading: "ほうき",
            rubyText: "ほうき",
            meaning: "ゴミを掃くための道具",
            category: "掃除の時間",
            difficulty: 1,
            exampleSentences: ["ほうきで床を掃きます。"]
        ),
        Vocabulary(
            word: "ちりとり",
            reading: "ちりとり",
            rubyText: "ちりとり",
            meaning: "ゴミを集める道具",
            category: "掃除の時間",
            difficulty: 1,
            exampleSentences: ["ちりとりでゴミを集めます。"]
        ),
        Vocabulary(
            word: "雑巾",
            reading: "ぞうきん",
            rubyText: "｜雑巾《ぞうきん》",
            meaning: "机や床を拭く布",
            category: "掃除の時間",
            difficulty: 1,
            exampleSentences: ["雑巾で机を拭きました。"]
        ),
        Vocabulary(
            word: "ゴミ箱",
            reading: "ゴミばこ",
            rubyText: "ゴミ｜箱《ばこ》",
            meaning: "ゴミを入れる箱",
            category: "掃除の時間",
            difficulty: 1,
            exampleSentences: ["紙くずをゴミ箱に捨てます。"]
        ),
        
        // 朝の会・帰りの会の語彙
        Vocabulary(
            word: "朝の会",
            reading: "あさのかい",
            rubyText: "｜朝《あさ》の｜会《かい》",
            meaning: "朝の始まりの時間",
            category: "朝の会・帰りの会",
            difficulty: 1,
            exampleSentences: ["朝の会で今日の予定を聞きます。"]
        ),
        Vocabulary(
            word: "帰りの会",
            reading: "かえりのかい",
            rubyText: "｜帰《かえ》りの｜会《かい》",
            meaning: "一日の終わりの時間",
            category: "朝の会・帰りの会",
            difficulty: 1,
            exampleSentences: ["帰りの会で明日の連絡を聞きます。"]
        ),
        Vocabulary(
            word: "出席",
            reading: "しゅっせき",
            rubyText: "｜出席《しゅっせき》",
            meaning: "学校に来ること",
            category: "朝の会・帰りの会",
            difficulty: 2,
            exampleSentences: ["今日は全員出席です。"]
        ),
        Vocabulary(
            word: "欠席",
            reading: "けっせき",
            rubyText: "｜欠席《けっせき》",
            meaning: "学校を休むこと",
            category: "朝の会・帰りの会",
            difficulty: 2,
            exampleSentences: ["風邪で欠席しました。"]
        ),
        Vocabulary(
            word: "連絡帳",
            reading: "れんらくちょう",
            rubyText: "｜連絡帳《れんらくちょう》",
            meaning: "家と学校の連絡に使うノート",
            category: "朝の会・帰りの会",
            difficulty: 2,
            exampleSentences: ["連絡帳に宿題を書きます。"]
        )
    ]
    
    /// 指定されたカテゴリーの語彙を取得する
    /// - Parameter category: カテゴリー名
    /// - Returns: 該当する語彙の配列
    static func vocabularies(for category: String) -> [Vocabulary] {
        return allVocabularies.filter { $0.category == category }
    }
    
    /// 指定された難易度の語彙を取得する
    /// - Parameter difficulty: 難易度レベル
    /// - Returns: 該当する語彙の配列
    static func vocabularies(for difficulty: Int) -> [Vocabulary] {
        return allVocabularies.filter { $0.difficulty == difficulty }
    }
    
    /// カテゴリーごとの語彙数を取得する
    /// - Returns: カテゴリー名と語彙数の辞書
    static func vocabularyCountByCategory() -> [String: Int] {
        var counts: [String: Int] = [:]
        for vocabulary in allVocabularies {
            counts[vocabulary.category, default: 0] += 1
        }
        return counts
    }
    
    /// ランダムに語彙を取得する
    /// - Parameter count: 取得する語彙数
    /// - Returns: ランダムに選ばれた語彙の配列
    static func randomVocabularies(count: Int) -> [Vocabulary] {
        return Array(allVocabularies.shuffled().prefix(count))
    }
}