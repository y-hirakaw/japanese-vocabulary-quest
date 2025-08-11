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
        ),
        
        // 動物の語彙
        Vocabulary(
            word: "犬",
            reading: "いぬ",
            rubyText: "｜犬《いぬ》",
            meaning: "人と仲良くする動物",
            category: "動物",
            difficulty: 1,
            exampleSentences: ["公園で犬が走っています。"]
        ),
        Vocabulary(
            word: "猫",
            reading: "ねこ",
            rubyText: "｜猫《ねこ》",
            meaning: "柔らかい毛のかわいい動物",
            category: "動物",
            difficulty: 1,
            exampleSentences: ["猫がのんびり寝ています。"]
        ),
        Vocabulary(
            word: "うさぎ",
            reading: "うさぎ",
            rubyText: "うさぎ",
            meaning: "長い耳を持つ動物",
            category: "動物",
            difficulty: 1,
            exampleSentences: ["うさぎが野菜を食べています。"]
        ),
        Vocabulary(
            word: "象",
            reading: "ぞう",
            rubyText: "｜象《ぞう》",
            meaning: "長い鼻を持つ大きな動物",
            category: "動物",
            difficulty: 1,
            exampleSentences: ["動物園で象を見ました。"]
        ),
        Vocabulary(
            word: "ライオン",
            reading: "ライオン",
            rubyText: "ライオン",
            meaning: "動物の王様と呼ばれる強い動物",
            category: "動物",
            difficulty: 1,
            exampleSentences: ["ライオンは力が強いです。"]
        ),
        Vocabulary(
            word: "きりん",
            reading: "きりん",
            rubyText: "きりん",
            meaning: "首がとても長い動物",
            category: "動物",
            difficulty: 1,
            exampleSentences: ["きりんは高い木の葉を食べます。"]
        ),
        Vocabulary(
            word: "サル",
            reading: "サル",
            rubyText: "サル",
            meaning: "木登りが上手な動物",
            category: "動物",
            difficulty: 1,
            exampleSentences: ["サルがバナナを食べています。"]
        ),
        Vocabulary(
            word: "鳥",
            reading: "とり",
            rubyText: "｜鳥《とり》",
            meaning: "空を飛ぶことができる動物",
            category: "動物",
            difficulty: 1,
            exampleSentences: ["鳥が空を飛んでいます。"]
        ),
        Vocabulary(
            word: "魚",
            reading: "さかな",
            rubyText: "｜魚《さかな》",
            meaning: "水の中で泳ぐ動物",
            category: "動物",
            difficulty: 1,
            exampleSentences: ["池で魚が泳いでいます。"]
        ),
        Vocabulary(
            word: "蝶々",
            reading: "ちょうちょう",
            rubyText: "｜蝶々《ちょうちょう》",
            meaning: "美しい羽を持つ虫",
            category: "動物",
            difficulty: 1,
            exampleSentences: ["花に蝶々がとまっています。"]
        ),
        Vocabulary(
            word: "蟻",
            reading: "あり",
            rubyText: "｜蟻《あり》",
            meaning: "小さくて働き者の虫",           
            category: "動物",
            difficulty: 1,
            exampleSentences: ["蟻が列を作って歩いています。"]
        ),
        Vocabulary(
            word: "蜂",
            reading: "はち",
            rubyText: "｜蜂《はち》",
            meaning: "蜜を集める虫",
            category: "動物",
            difficulty: 1,
            exampleSentences: ["蜂が花の蜜を集めています。"]
        ),
        Vocabulary(
            word: "カエル",
            reading: "カエル",
            rubyText: "カエル",
            meaning: "池にいる緑色の動物",
            category: "動物",
            difficulty: 1,
            exampleSentences: ["雨の日にカエルが鳴いています。"]
        ),
        Vocabulary(
            word: "カメ",
            reading: "カメ",
            rubyText: "カメ",
            meaning: "甲羅を背負った動物",
            category: "動物",
            difficulty: 1,
            exampleSentences: ["カメがゆっくり歩いています。"]
        ),
        Vocabulary(
            word: "トカゲ",
            reading: "トカゲ",
            rubyText: "トカゲ",
            meaning: "長い尻尾を持つ爬虫類",
            category: "動物",
            difficulty: 2,
            exampleSentences: ["石の上でトカゲが日光浴をしています。"]
        ),
        Vocabulary(
            word: "クマ",
            reading: "クマ",
            rubyText: "クマ",
            meaning: "大きくて毛深い動物",
            category: "動物",
            difficulty: 1,
            exampleSentences: ["山にクマが住んでいます。"]
        ),
        Vocabulary(
            word: "リス",
            reading: "リス",
            rubyText: "リス",
            meaning: "ふわふわの尻尾を持つ小さな動物",
            category: "動物",
            difficulty: 1,
            exampleSentences: ["リスがドングリを食べています。"]
        ),
        Vocabulary(
            word: "ハムスター",
            reading: "ハムスター",
            rubyText: "ハムスター",
            meaning: "小さくて丸いペット",
            category: "動物",
            difficulty: 1,
            exampleSentences: ["ハムスターが回し車で遊んでいます。"]
        ),
        Vocabulary(
            word: "金魚",
            reading: "きんぎょ",
            rubyText: "｜金魚《きんぎょ》",
            meaning: "オレンジ色のペットの魚",
            category: "動物",
            difficulty: 1,
            exampleSentences: ["水槽で金魚を飼っています。"]
        ),
        Vocabulary(
            word: "イルカ",
            reading: "イルカ",
            rubyText: "イルカ",
            meaning: "海にいる賢い動物",
            category: "動物",
            difficulty: 1,
            exampleSentences: ["水族館でイルカのショーを見ました。"]
        ),
        
        // 食べ物の語彙
        Vocabulary(
            word: "りんご",
            reading: "りんご",
            rubyText: "りんご",
            meaning: "赤くて甘い果物",
            category: "食べ物",
            difficulty: 1,
            exampleSentences: ["りんごを食べると甘いです。"]
        ),
        Vocabulary(
            word: "バナナ",
            reading: "バナナ",
            rubyText: "バナナ",
            meaning: "黄色くて長い果物",
            category: "食べ物",
            difficulty: 1,
            exampleSentences: ["朝ごはんにバナナを食べました。"]
        ),
        Vocabulary(
            word: "みかん",
            reading: "みかん",
            rubyText: "みかん",
            meaning: "オレンジ色の甘い果物",
            category: "食べ物",
            difficulty: 1,
            exampleSentences: ["冬にみかんをたくさん食べます。"]
        ),
        Vocabulary(
            word: "いちご",
            reading: "いちご",
            rubyText: "いちご",
            meaning: "赤くて甘酸っぱい果物",
            category: "食べ物",
            difficulty: 1,
            exampleSentences: ["春になるといちごが美味しいです。"]
        ),
        Vocabulary(
            word: "ぶどう",
            reading: "ぶどう",
            rubyText: "ぶどう",
            meaning: "房になっている小さな果物",
            category: "食べ物",
            difficulty: 1,
            exampleSentences: ["紫色のぶどうが甘いです。"]
        ),
        Vocabulary(
            word: "トマト",
            reading: "トマト",
            rubyText: "トマト",
            meaning: "赤い野菜",
            category: "食べ物",
            difficulty: 1,
            exampleSentences: ["サラダにトマトを入れます。"]
        ),
        Vocabulary(
            word: "にんじん",
            reading: "にんじん",
            rubyText: "にんじん",
            meaning: "オレンジ色の野菜",
            category: "食べ物",
            difficulty: 1,
            exampleSentences: ["にんじんは目に良いです。"]
        ),
        Vocabulary(
            word: "じゃがいも",
            reading: "じゃがいも",
            rubyText: "じゃがいも",
            meaning: "土の中で育つ野菜",
            category: "食べ物",
            difficulty: 1,
            exampleSentences: ["じゃがいもでポテトサラダを作ります。"]
        ),
        Vocabulary(
            word: "たまねぎ",
            reading: "たまねぎ",
            rubyText: "たまねぎ",
            meaning: "切ると涙が出る野菜",
            category: "食べ物",
            difficulty: 1,
            exampleSentences: ["カレーにたまねぎを入れます。"]
        ),
        Vocabulary(
            word: "キャベツ",
            reading: "キャベツ",
            rubyText: "キャベツ",
            meaning: "葉がたくさん重なった野菜",
            category: "食べ物",
            difficulty: 1,
            exampleSentences: ["キャベツでサラダを作ります。"]
        ),
        Vocabulary(
            word: "ご飯",
            reading: "ごはん",
            rubyText: "ご｜飯《はん》",
            meaning: "お米を炊いたもの",
            category: "食べ物",
            difficulty: 1,
            exampleSentences: ["毎日ご飯を食べます。"]
        ),
        Vocabulary(
            word: "パン",
            reading: "パン",
            rubyText: "パン",
            meaning: "小麦粉で作った食べ物",
            category: "食べ物",
            difficulty: 1,
            exampleSentences: ["朝ごはんにパンを食べました。"]
        ),
        Vocabulary(
            word: "麺",
            reading: "めん",
            rubyText: "｜麺《めん》",
            meaning: "細長い食べ物",
            category: "食べ物",
            difficulty: 1,
            exampleSentences: ["お昼にラーメンの麺を食べました。"]
        ),
        Vocabulary(
            word: "卵",
            reading: "たまご",
            rubyText: "｜卵《たまご》",
            meaning: "鶏が産む白い食べ物",
            category: "食べ物",
            difficulty: 1,
            exampleSentences: ["朝ごはんに卵焼きを食べます。"]
        ),
        Vocabulary(
            word: "牛乳",
            reading: "ぎゅうにゅう",
            rubyText: "｜牛乳《ぎゅうにゅう》",
            meaning: "牛からもらう白い飲み物",
            category: "食べ物",
            difficulty: 1,
            exampleSentences: ["毎朝牛乳を飲みます。"]
        ),
        Vocabulary(
            word: "チーズ",
            reading: "チーズ",
            rubyText: "チーズ",
            meaning: "牛乳から作った食べ物",
            category: "食べ物",
            difficulty: 1,
            exampleSentences: ["パンにチーズをのせて食べます。"]
        ),
        Vocabulary(
            word: "肉",
            reading: "にく",
            rubyText: "｜肉《にく》",
            meaning: "動物から取れる食べ物",
            category: "食べ物",
            difficulty: 1,
            exampleSentences: ["夕ごはんに肉を食べました。"]
        ),
        Vocabulary(
            word: "魚",
            reading: "さかな",
            rubyText: "｜魚《さかな》",
            meaning: "海や川にいる食べ物",
            category: "食べ物",
            difficulty: 1,
            exampleSentences: ["今日の夕ごはんは魚です。"]
        ),
        Vocabulary(
            word: "お菓子",
            reading: "おかし",
            rubyText: "お｜菓子《かし》",
            meaning: "甘くて美味しい食べ物",
            category: "食べ物",
            difficulty: 1,
            exampleSentences: ["おやつにお菓子を食べます。"]
        ),
        Vocabulary(
            word: "アイスクリーム",
            reading: "アイスクリーム",
            rubyText: "アイスクリーム",
            meaning: "冷たくて甘い食べ物",
            category: "食べ物",
            difficulty: 1,
            exampleSentences: ["暑い日にアイスクリームを食べました。"]
        ),
        
        // 乗り物の語彙
        Vocabulary(
            word: "車",
            reading: "くるま",
            rubyText: "｜車《くるま》",
            meaning: "道路を走る乗り物",
            category: "乗り物",
            difficulty: 1,
            exampleSentences: ["お父さんの車で出かけます。"]
        ),
        Vocabulary(
            word: "電車",
            reading: "でんしゃ",
            rubyText: "｜電車《でんしゃ》",
            meaning: "レールの上を走る乗り物",
            category: "乗り物",
            difficulty: 1,
            exampleSentences: ["電車に乗って学校に行きます。"]
        ),
        Vocabulary(
            word: "バス",
            reading: "バス",
            rubyText: "バス",
            meaning: "たくさんの人が乗れる大きな車",
            category: "乗り物",
            difficulty: 1,
            exampleSentences: ["バスで動物園に行きました。"]
        ),
        Vocabulary(
            word: "自転車",
            reading: "じてんしゃ",
            rubyText: "｜自転車《じてんしゃ》",
            meaning: "ペダルをこいで進む乗り物",
            category: "乗り物",
            difficulty: 1,
            exampleSentences: ["自転車で公園に行きます。"]
        ),
        Vocabulary(
            word: "飛行機",
            reading: "ひこうき",
            rubyText: "｜飛行機《ひこうき》",
            meaning: "空を飛ぶ乗り物",
            category: "乗り物",
            difficulty: 1,
            exampleSentences: ["飛行機で旅行に行きます。"]
        ),
        Vocabulary(
            word: "船",
            reading: "ふね",
            rubyText: "｜船《ふね》",
            meaning: "水の上を進む乗り物",
            category: "乗り物",
            difficulty: 1,
            exampleSentences: ["船で島に行きました。"]
        ),
        Vocabulary(
            word: "新幹線",
            reading: "しんかんせん",
            rubyText: "｜新幹線《しんかんせん》",
            meaning: "とても速い電車",
            category: "乗り物",
            difficulty: 2,
            exampleSentences: ["新幹線で東京に行きます。"]
        ),
        Vocabulary(
            word: "タクシー",
            reading: "タクシー",
            rubyText: "タクシー",
            meaning: "お金を払って乗る車",
            category: "乗り物",
            difficulty: 1,
            exampleSentences: ["雨の日はタクシーに乗ります。"]
        ),
        Vocabulary(
            word: "救急車",
            reading: "きゅうきゅうしゃ",
            rubyText: "｜救急車《きゅうきゅうしゃ》",
            meaning: "病気の人を運ぶ車",
            category: "乗り物",
            difficulty: 2,
            exampleSentences: ["救急車のサイレンが聞こえます。"]
        ),
        Vocabulary(
            word: "消防車",
            reading: "しょうぼうしゃ",
            rubyText: "｜消防車《しょうぼうしゃ》",
            meaning: "火事を消す車",
            category: "乗り物",
            difficulty: 2,
            exampleSentences: ["消防車が火事の現場に向かいます。"]
        ),
        Vocabulary(
            word: "パトカー",
            reading: "パトカー",
            rubyText: "パトカー",
            meaning: "警察官が乗る車",
            category: "乗り物",
            difficulty: 1,
            exampleSentences: ["パトカーが街をパトロールしています。"]
        ),
        Vocabulary(
            word: "トラック",
            reading: "トラック",
            rubyText: "トラック",
            meaning: "荷物を運ぶ大きな車",
            category: "乗り物",
            difficulty: 1,
            exampleSentences: ["トラックが荷物を運んでいます。"]
        ),
        Vocabulary(
            word: "バイク",
            reading: "バイク",
            rubyText: "バイク",
            meaning: "二つの車輪がある乗り物",
            category: "乗り物",
            difficulty: 1,
            exampleSentences: ["お兄さんがバイクに乗っています。"]
        ),
        Vocabulary(
            word: "ヘリコプター",
            reading: "ヘリコプター",
            rubyText: "ヘリコプター",
            meaning: "プロペラで空を飛ぶ乗り物",
            category: "乗り物",
            difficulty: 2,
            exampleSentences: ["ヘリコプターが空を飛んでいます。"]
        ),
        Vocabulary(
            word: "地下鉄",
            reading: "ちかてつ",
            rubyText: "｜地下鉄《ちかてつ》",
            meaning: "地下を走る電車",
            category: "乗り物",
            difficulty: 2,
            exampleSentences: ["地下鉄で街の中心部に行きます。"]
        ),
        Vocabulary(
            word: "スクールバス",
            reading: "スクールバス",
            rubyText: "スクールバス",
            meaning: "学校に通うためのバス",
            category: "乗り物",
            difficulty: 1,
            exampleSentences: ["スクールバスで学校に通います。"]
        ),
        Vocabulary(
            word: "ロケット",
            reading: "ロケット",
            rubyText: "ロケット",
            meaning: "宇宙に行く乗り物",
            category: "乗り物",
            difficulty: 2,
            exampleSentences: ["ロケットが宇宙に向かって飛びました。"]
        ),
        Vocabulary(
            word: "気球",
            reading: "ききゅう",
            rubyText: "｜気球《ききゅう》",
            meaning: "風船で空を飛ぶ乗り物",
            category: "乗り物",
            difficulty: 2,
            exampleSentences: ["カラフルな気球が空に浮かんでいます。"]
        ),
        Vocabulary(
            word: "三輪車",
            reading: "さんりんしゃ",
            rubyText: "｜三輪車《さんりんしゃ》",
            meaning: "車輪が三つある子供の乗り物",
            category: "乗り物",
            difficulty: 1,
            exampleSentences: ["小さい子が三輪車に乗っています。"]
        ),
        Vocabulary(
            word: "スケートボード",
            reading: "スケートボード",
            rubyText: "スケートボード",
            meaning: "板に車輪がついた乗り物",
            category: "乗り物",
            difficulty: 2,
            exampleSentences: ["公園でスケートボードを楽しんでいます。"]
        ),
        
        // 自然・天気の語彙
        Vocabulary(
            word: "太陽",
            reading: "たいよう",
            rubyText: "｜太陽《たいよう》",
            meaning: "空に輝く明るい星",
            category: "自然・天気",
            difficulty: 1,
            exampleSentences: ["太陽が空に輝いています。"]
        ),
        Vocabulary(
            word: "月",
            reading: "つき",
            rubyText: "｜月《つき》",
            meaning: "夜に見える白い天体",
            category: "自然・天気",
            difficulty: 1,
            exampleSentences: ["夜空に月が見えます。"]
        ),
        Vocabulary(
            word: "星",
            reading: "ほし",
            rubyText: "｜星《ほし》",
            meaning: "夜空に光る小さな点",
            category: "自然・天気",
            difficulty: 1,
            exampleSentences: ["星がたくさん見えます。"]
        ),
        Vocabulary(
            word: "雲",
            reading: "くも",
            rubyText: "｜雲《くも》",
            meaning: "空に浮かぶ白いもの",
            category: "自然・天気",
            difficulty: 1,
            exampleSentences: ["空に白い雲が浮かんでいます。"]
        ),
        Vocabulary(
            word: "雨",
            reading: "あめ",
            rubyText: "｜雨《あめ》",
            meaning: "空から降る水",
            category: "自然・天気",
            difficulty: 1,
            exampleSentences: ["今日は雨が降っています。"]
        ),
        Vocabulary(
            word: "雪",
            reading: "ゆき",
            rubyText: "｜雪《ゆき》",
            meaning: "冬に降る白いもの",
            category: "自然・天気",
            difficulty: 1,
            exampleSentences: ["雪が降って白くなりました。"]
        ),
        Vocabulary(
            word: "風",
            reading: "かぜ",
            rubyText: "｜風《かぜ》",
            meaning: "空気が動くこと",
            category: "自然・天気",
            difficulty: 1,
            exampleSentences: ["風が涼しくて気持ちいいです。"]
        ),
        Vocabulary(
            word: "虹",
            reading: "にじ",
            rubyText: "｜虹《にじ》",
            meaning: "雨上がりに空に現れる七色の帯",
            category: "自然・天気",
            difficulty: 1,
            exampleSentences: ["雨が止んで虹が出ました。"]
        ),
        Vocabulary(
            word: "雷",
            reading: "かみなり",
            rubyText: "｜雷《かみなり》",
            meaning: "空で光って音がするもの",
            category: "自然・天気",
            difficulty: 2,
            exampleSentences: ["雷の音が大きくてびっくりしました。"]
        ),
        Vocabulary(
            word: "春",
            reading: "はる",
            rubyText: "｜春《はる》",
            meaning: "暖かくなる季節",
            category: "自然・天気",
            difficulty: 1,
            exampleSentences: ["春になって花が咲きました。"]
        ),
        Vocabulary(
            word: "夏",
            reading: "なつ",
            rubyText: "｜夏《なつ》",
            meaning: "暑い季節",
            category: "自然・天気",
            difficulty: 1,
            exampleSentences: ["夏はプールで泳ぎます。"]
        ),
        Vocabulary(
            word: "秋",
            reading: "あき",
            rubyText: "｜秋《あき》",
            meaning: "葉っぱが赤くなる季節",
            category: "自然・天気",
            difficulty: 1,
            exampleSentences: ["秋になって葉っぱが赤くなりました。"]
        ),
        Vocabulary(
            word: "冬",
            reading: "ふゆ",
            rubyText: "｜冬《ふゆ》",
            meaning: "寒い季節",
            category: "自然・天気",
            difficulty: 1,
            exampleSentences: ["冬は雪が降ります。"]
        ),
        Vocabulary(
            word: "花",
            reading: "はな",
            rubyText: "｜花《はな》",
            meaning: "植物のきれいな部分",
            category: "自然・天気",
            difficulty: 1,
            exampleSentences: ["庭に美しい花が咲いています。"]
        ),
        Vocabulary(
            word: "木",
            reading: "き",
            rubyText: "｜木《き》",
            meaning: "大きく育つ植物",
            category: "自然・天気",
            difficulty: 1,
            exampleSentences: ["公園に大きな木があります。"]
        ),
        Vocabulary(
            word: "草",
            reading: "くさ",
            rubyText: "｜草《くさ》",
            meaning: "地面に生える緑の植物",
            category: "自然・天気",
            difficulty: 1,
            exampleSentences: ["草の上で遊びました。"]
        ),
        Vocabulary(
            word: "葉っぱ",
            reading: "はっぱ",
            rubyText: "｜葉《は》っぱ",
            meaning: "木や草についている緑の部分",
            category: "自然・天気",
            difficulty: 1,
            exampleSentences: ["葉っぱが風で揺れています。"]
        ),
        Vocabulary(
            word: "山",
            reading: "やま",
            rubyText: "｜山《やま》",
            meaning: "高くそびえ立つ土地",
            category: "自然・天気",
            difficulty: 1,
            exampleSentences: ["遠くに高い山が見えます。"]
        ),
        Vocabulary(
            word: "川",
            reading: "かわ",
            rubyText: "｜川《かわ》",
            meaning: "水が流れる道",
            category: "自然・天気",
            difficulty: 1,
            exampleSentences: ["川で魚が泳いでいます。"]
        ),
        Vocabulary(
            word: "海",
            reading: "うみ",
            rubyText: "｜海《うみ》",
            meaning: "とても大きな水のかたまり",
            category: "自然・天気",
            difficulty: 1,
            exampleSentences: ["夏に海で泳ぎました。"]
        ),
        
        // スポーツの語彙
        Vocabulary(
            word: "サッカー",
            reading: "サッカー",
            rubyText: "サッカー",
            meaning: "ボールを足で蹴るスポーツ",
            category: "スポーツ",
            difficulty: 1,
            exampleSentences: ["友達とサッカーをしました。"]
        ),
        Vocabulary(
            word: "野球",
            reading: "やきゅう",
            rubyText: "｜野球《やきゅう》",
            meaning: "ボールとバットを使うスポーツ",
            category: "スポーツ",
            difficulty: 1,
            exampleSentences: ["お父さんと野球をしました。"]
        ),
        Vocabulary(
            word: "バスケットボール",
            reading: "バスケットボール",
            rubyText: "バスケットボール",
            meaning: "高いゴールにボールを入れるスポーツ",
            category: "スポーツ",
            difficulty: 2,
            exampleSentences: ["体育館でバスケットボールをしました。"]
        ),
        Vocabulary(
            word: "テニス",
            reading: "テニス",
            rubyText: "テニス",
            meaning: "ラケットでボールを打つスポーツ",
            category: "スポーツ",
            difficulty: 1,
            exampleSentences: ["テニスで相手と勝負しました。"]
        ),
        Vocabulary(
            word: "水泳",
            reading: "すいえい",
            rubyText: "｜水泳《すいえい》",
            meaning: "プールで泳ぐスポーツ",
            category: "スポーツ",
            difficulty: 2,
            exampleSentences: ["水泳の授業で25メートル泳ぎました。"]
        ),
        Vocabulary(
            word: "かけっこ",
            reading: "かけっこ",
            rubyText: "かけっこ",
            meaning: "速く走ること",
            category: "スポーツ",
            difficulty: 1,
            exampleSentences: ["運動会でかけっこをしました。"]
        ),
        Vocabulary(
            word: "縄跳び",
            reading: "なわとび",
            rubyText: "｜縄跳《なわと》び",
            meaning: "縄を回して跳ぶ運動",
            category: "スポーツ",
            difficulty: 1,
            exampleSentences: ["縄跳びで100回跳べました。"]
        ),
        Vocabulary(
            word: "鉄棒",
            reading: "てつぼう",
            rubyText: "｜鉄棒《てつぼう》",
            meaning: "鉄の棒にぶら下がる運動",
            category: "スポーツ",
            difficulty: 1,
            exampleSentences: ["鉄棒で逆上がりができました。"]
        ),
        Vocabulary(
            word: "跳び箱",
            reading: "とびばこ",
            rubyText: "｜跳《と》び｜箱《ばこ》",
            meaning: "箱を跳び越える運動",
            category: "スポーツ",
            difficulty: 1,
            exampleSentences: ["跳び箱を5段跳べました。"]
        ),
        Vocabulary(
            word: "マット運動",
            reading: "マットうんどう",
            rubyText: "マット｜運動《うんどう》",
            meaning: "マットの上でする運動",
            category: "スポーツ",
            difficulty: 2,
            exampleSentences: ["マット運動で前転をしました。"]
        ),
        Vocabulary(
            word: "ボール",
            reading: "ボール",
            rubyText: "ボール",
            meaning: "丸いスポーツ用具",
            category: "スポーツ",
            difficulty: 1,
            exampleSentences: ["ボールを投げて遊びました。"]
        ),
        Vocabulary(
            word: "バット",
            reading: "バット",
            rubyText: "バット",
            meaning: "野球でボールを打つ道具",
            category: "スポーツ",
            difficulty: 1,
            exampleSentences: ["バットでボールを打ちました。"]
        ),
        Vocabulary(
            word: "ラケット",
            reading: "ラケット",
            rubyText: "ラケット",
            meaning: "テニスでボールを打つ道具",
            category: "スポーツ",
            difficulty: 1,
            exampleSentences: ["ラケットでボールを打ち返しました。"]
        ),
        Vocabulary(
            word: "ゴール",
            reading: "ゴール",
            rubyText: "ゴール",
            meaning: "得点を入れる場所",
            category: "スポーツ",
            difficulty: 1,
            exampleSentences: ["サッカーでゴールを決めました。"]
        ),
        Vocabulary(
            word: "チーム",
            reading: "チーム",
            rubyText: "チーム",
            meaning: "一緒にスポーツをするグループ",
            category: "スポーツ",
            difficulty: 1,
            exampleSentences: ["私たちのチームが勝ちました。"]
        ),
        Vocabulary(
            word: "試合",
            reading: "しあい",
            rubyText: "｜試合《しあい》",
            meaning: "勝負をすること",
            category: "スポーツ",
            difficulty: 2,
            exampleSentences: ["今度の日曜日に試合があります。"]
        ),
        Vocabulary(
            word: "練習",
            reading: "れんしゅう",
            rubyText: "｜練習《れんしゅう》",
            meaning: "上手になるために繰り返すこと",
            category: "スポーツ",
            difficulty: 1,
            exampleSentences: ["毎日練習して上手になりました。"]
        ),
        Vocabulary(
            word: "運動会",
            reading: "うんどうかい",
            rubyText: "｜運動会《うんどうかい》",
            meaning: "学校でスポーツをする行事",
            category: "スポーツ",
            difficulty: 1,
            exampleSentences: ["運動会でリレーに参加しました。"]
        ),
        Vocabulary(
            word: "リレー",
            reading: "リレー",
            rubyText: "リレー",
            meaning: "バトンを渡しながら走る競技",
            category: "スポーツ",
            difficulty: 1,
            exampleSentences: ["リレーでアンカーを走りました。"]
        ),
        Vocabulary(
            word: "玉入れ",
            reading: "たまいれ",
            rubyText: "｜玉入《たまい》れ",
            meaning: "かごに玉を入れる競技",
            category: "スポーツ",
            difficulty: 1,
            exampleSentences: ["玉入れでたくさん入りました。"]
        ),
        
        // 家族の語彙
        Vocabulary(
            word: "お父さん",
            reading: "おとうさん",
            rubyText: "お｜父《とう》さん",
            meaning: "男の親",
            category: "家族",
            difficulty: 1,
            exampleSentences: ["お父さんと公園に行きました。"]
        ),
        Vocabulary(
            word: "お母さん",
            reading: "おかあさん",
            rubyText: "お｜母《かあ》さん",
            meaning: "女の親",
            category: "家族",
            difficulty: 1,
            exampleSentences: ["お母さんが料理を作ってくれました。"]
        ),
        Vocabulary(
            word: "お兄さん",
            reading: "おにいさん",
            rubyText: "お｜兄《にい》さん",
            meaning: "年上の男のきょうだい",
            category: "家族",
            difficulty: 1,
            exampleSentences: ["お兄さんと一緒に遊びました。"]
        ),
        Vocabulary(
            word: "お姉さん",
            reading: "おねえさん",
            rubyText: "お｜姉《ねえ》さん",
            meaning: "年上の女のきょうだい",
            category: "家族",
            difficulty: 1,
            exampleSentences: ["お姉さんが宿題を手伝ってくれました。"]
        ),
        Vocabulary(
            word: "弟",
            reading: "おとうと",
            rubyText: "｜弟《おとうと》",
            meaning: "年下の男のきょうだい",
            category: "家族",
            difficulty: 1,
            exampleSentences: ["弟と一緒におもちゃで遊びました。"]
        ),
        Vocabulary(
            word: "妹",
            reading: "いもうと",
            rubyText: "｜妹《いもうと》",
            meaning: "年下の女のきょうだい",
            category: "家族",
            difficulty: 1,
            exampleSentences: ["妹の面倒を見ました。"]
        ),
        Vocabulary(
            word: "おじいさん",
            reading: "おじいさん",
            rubyText: "おじいさん",
            meaning: "お父さんやお母さんのお父さん",
            category: "家族",
            difficulty: 1,
            exampleSentences: ["おじいさんが昔話をしてくれました。"]
        ),
        Vocabulary(
            word: "おばあさん",
            reading: "おばあさん",
            rubyText: "おばあさん",
            meaning: "お父さんやお母さんのお母さん",
            category: "家族",
            difficulty: 1,
            exampleSentences: ["おばあさんが美味しいご飯を作ってくれました。"]
        ),
        Vocabulary(
            word: "おじさん",
            reading: "おじさん",
            rubyText: "おじさん",
            meaning: "お父さんやお母さんの弟",
            category: "家族",
            difficulty: 1,
            exampleSentences: ["おじさんが遊びに来ました。"]
        ),
        Vocabulary(
            word: "おばさん",
            reading: "おばさん",
            rubyText: "おばさん",
            meaning: "お父さんやお母さんの妹",
            category: "家族",
            difficulty: 1,
            exampleSentences: ["おばさんがお土産をくれました。"]
        ),
        Vocabulary(
            word: "赤ちゃん",
            reading: "あかちゃん",
            rubyText: "｜赤《あか》ちゃん",
            meaning: "生まれたばかりの小さな人",
            category: "家族",
            difficulty: 1,
            exampleSentences: ["隣の家に赤ちゃんが生まれました。"]
        ),
        Vocabulary(
            word: "家族",
            reading: "かぞく",
            rubyText: "｜家族《かぞく》",
            meaning: "一緒に住んでいる人たち",
            category: "家族",
            difficulty: 1,
            exampleSentences: ["家族みんなで旅行に行きました。"]
        ),
        Vocabulary(
            word: "いとこ",
            reading: "いとこ",
            rubyText: "いとこ",
            meaning: "おじさんやおばさんの子供",
            category: "家族",
            difficulty: 2,
            exampleSentences: ["いとこと夏休みに遊びました。"]
        ),
        Vocabulary(
            word: "親戚",
            reading: "しんせき",
            rubyText: "｜親戚《しんせき》",
            meaning: "家族の仲間",
            category: "家族",
            difficulty: 2,
            exampleSentences: ["お正月に親戚が集まりました。"]
        ),
        
        // 体の部分の語彙
        Vocabulary(
            word: "頭",
            reading: "あたま",
            rubyText: "｜頭《あたま》",
            meaning: "体の一番上の部分",
            category: "体の部分",
            difficulty: 1,
            exampleSentences: ["帽子を頭にかぶります。"]
        ),
        Vocabulary(
            word: "顔",
            reading: "かお",
            rubyText: "｜顔《かお》",
            meaning: "頭の前の部分",
            category: "体の部分",
            difficulty: 1,
            exampleSentences: ["鏡で顔を見ました。"]
        ),
        Vocabulary(
            word: "目",
            reading: "め",
            rubyText: "｜目《め》",
            meaning: "見るための体の部分",
            category: "体の部分",
            difficulty: 1,
            exampleSentences: ["目で遠くを見ます。"]
        ),
        Vocabulary(
            word: "鼻",
            reading: "はな",
            rubyText: "｜鼻《はな》",
            meaning: "におい嗅ぐための体の部分",
            category: "体の部分",
            difficulty: 1,
            exampleSentences: ["鼻で花のにおいを嗅ぎました。"]
        ),
        Vocabulary(
            word: "口",
            reading: "くち",
            rubyText: "｜口《くち》",
            meaning: "食べ物を食べるための体の部分",
            category: "体の部分",
            difficulty: 1,
            exampleSentences: ["口でご飯を食べます。"]
        ),
        Vocabulary(
            word: "耳",
            reading: "みみ",
            rubyText: "｜耳《みみ》",
            meaning: "音を聞くための体の部分",
            category: "体の部分",
            difficulty: 1,
            exampleSentences: ["耳で音楽を聞きます。"]
        ),
        Vocabulary(
            word: "手",
            reading: "て",
            rubyText: "｜手《て》",
            meaning: "物をつかむための体の部分",
            category: "体の部分",
            difficulty: 1,
            exampleSentences: ["手でボールをつかみます。"]
        ),
        Vocabulary(
            word: "足",
            reading: "あし",
            rubyText: "｜足《あし》",
            meaning: "歩くための体の部分",
            category: "体の部分",
            difficulty: 1,
            exampleSentences: ["足で歩いて学校に行きます。"]
        ),
        Vocabulary(
            word: "腕",
            reading: "うで",
            rubyText: "｜腕《うで》",
            meaning: "肩から手までの部分",
            category: "体の部分",
            difficulty: 1,
            exampleSentences: ["腕を上げて挙手しました。"]
        ),
        Vocabulary(
            word: "背中",
            reading: "せなか",
            rubyText: "｜背中《せなか》",
            meaning: "体の後ろ側",
            category: "体の部分",
            difficulty: 1,
            exampleSentences: ["お父さんが背中をかいてくれました。"]
        ),
        Vocabulary(
            word: "お腹",
            reading: "おなか",
            rubyText: "お｜腹《なか》",
            meaning: "体の前側の真ん中",
            category: "体の部分",
            difficulty: 1,
            exampleSentences: ["お腹が空いてきました。"]
        ),
        Vocabulary(
            word: "心臓",
            reading: "しんぞう",
            rubyText: "｜心臓《しんぞう》",
            meaning: "体の中で血を送る大切な部分",
            category: "体の部分",
            difficulty: 2,
            exampleSentences: ["走ると心臓がドキドキします。"]
        ),
        Vocabulary(
            word: "指",
            reading: "ゆび",
            rubyText: "｜指《ゆび》",
            meaning: "手の先にある細い部分",
            category: "体の部分",
            difficulty: 1,
            exampleSentences: ["指で数を数えます。"]
        ),
        Vocabulary(
            word: "髪",
            reading: "かみ",
            rubyText: "｜髪《かみ》",
            meaning: "頭に生えている毛",
            category: "体の部分",
            difficulty: 1,
            exampleSentences: ["朝、髪をとかします。"]
        ),
        Vocabulary(
            word: "歯",
            reading: "は",
            rubyText: "｜歯《は》",
            meaning: "口の中にある白いもの",
            category: "体の部分",
            difficulty: 1,
            exampleSentences: ["毎日歯を磨きます。"]
        ),
        Vocabulary(
            word: "膝",
            reading: "ひざ",
            rubyText: "｜膝《ひざ》",
            meaning: "足の真ん中で曲がる部分",
            category: "体の部分",
            difficulty: 1,
            exampleSentences: ["転んで膝をすりむきました。"]
        ),
        
        // 色・形の語彙
        Vocabulary(
            word: "赤",
            reading: "あか",
            rubyText: "｜赤《あか》",
            meaning: "血のような色",
            category: "色・形",
            difficulty: 1,
            exampleSentences: ["りんごは赤い色です。"]
        ),
        Vocabulary(
            word: "青",
            reading: "あお",
            rubyText: "｜青《あお》",
            meaning: "空のような色",
            category: "色・形",
            difficulty: 1,
            exampleSentences: ["空は青い色です。"]
        ),
        Vocabulary(
            word: "黄色",
            reading: "きいろ",
            rubyText: "｜黄色《きいろ》",
            meaning: "太陽のような色",
            category: "色・形",
            difficulty: 1,
            exampleSentences: ["バナナは黄色です。"]
        ),
        Vocabulary(
            word: "緑",
            reading: "みどり",
            rubyText: "｜緑《みどり》",
            meaning: "葉っぱのような色",
            category: "色・形",
            difficulty: 1,
            exampleSentences: ["木の葉は緑色です。"]
        ),
        Vocabulary(
            word: "白",
            reading: "しろ",
            rubyText: "｜白《しろ》",
            meaning: "雪のような色",
            category: "色・形",
            difficulty: 1,
            exampleSentences: ["雲は白い色です。"]
        ),
        Vocabulary(
            word: "黒",
            reading: "くろ",
            rubyText: "｜黒《くろ》",
            meaning: "夜のような色",
            category: "色・形",
            difficulty: 1,
            exampleSentences: ["夜は黒い色です。"]
        ),
        Vocabulary(
            word: "紫",
            reading: "むらさき",
            rubyText: "｜紫《むらさき》",
            meaning: "赤と青を混ぜた色",
            category: "色・形",
            difficulty: 2,
            exampleSentences: ["なすは紫色です。"]
        ),
        Vocabulary(
            word: "オレンジ",
            reading: "オレンジ",
            rubyText: "オレンジ",
            meaning: "みかんのような色",
            category: "色・形",
            difficulty: 1,
            exampleSentences: ["みかんはオレンジ色です。"]
        ),
        Vocabulary(
            word: "ピンク",
            reading: "ピンク",
            rubyText: "ピンク",
            meaning: "桜のような色",
            category: "色・形",
            difficulty: 1,
            exampleSentences: ["桜の花はピンク色です。"]
        ),
        Vocabulary(
            word: "茶色",
            reading: "ちゃいろ",
            rubyText: "｜茶色《ちゃいろ》",
            meaning: "土のような色",
            category: "色・形",
            difficulty: 1,
            exampleSentences: ["犬の毛は茶色です。"]
        ),
        Vocabulary(
            word: "丸",
            reading: "まる",
            rubyText: "｜丸《まる》",
            meaning: "円の形",
            category: "色・形",
            difficulty: 1,
            exampleSentences: ["ボールは丸い形です。"]
        ),
        Vocabulary(
            word: "四角",
            reading: "しかく",
            rubyText: "｜四角《しかく》",
            meaning: "四つの角がある形",
            category: "色・形",
            difficulty: 1,
            exampleSentences: ["窓は四角い形です。"]
        ),
        Vocabulary(
            word: "三角",
            reading: "さんかく",
            rubyText: "｜三角《さんかく》",
            meaning: "三つの角がある形",
            category: "色・形",
            difficulty: 1,
            exampleSentences: ["屋根は三角の形です。"]
        ),
        Vocabulary(
            word: "星型",
            reading: "ほしがた",
            rubyText: "｜星型《ほしがた》",
            meaning: "星のような形",
            category: "色・形",
            difficulty: 2,
            exampleSentences: ["クッキーを星型で作りました。"]
        ),
        Vocabulary(
            word: "ハート",
            reading: "ハート",
            rubyText: "ハート",
            meaning: "心臓のような形",
            category: "色・形",
            difficulty: 1,
            exampleSentences: ["カードにハートの絵が描いてあります。"]
        ),
        Vocabulary(
            word: "大きい",
            reading: "おおきい",
            rubyText: "｜大《おお》きい",
            meaning: "サイズが大きいこと",
            category: "色・形",
            difficulty: 1,
            exampleSentences: ["象は大きい動物です。"]
        ),
        Vocabulary(
            word: "小さい",
            reading: "ちいさい",
            rubyText: "｜小《ちい》さい",
            meaning: "サイズが小さいこと",
            category: "色・形",
            difficulty: 1,
            exampleSentences: ["蟻は小さい虫です。"]
        ),
        Vocabulary(
            word: "長い",
            reading: "ながい",
            rubyText: "｜長《なが》い",
            meaning: "距離が長いこと",
            category: "色・形",
            difficulty: 1,
            exampleSentences: ["きりんの首は長いです。"]
        ),
        Vocabulary(
            word: "短い",
            reading: "みじかい",
            rubyText: "｜短《みじか》い",
            meaning: "距離が短いこと",
            category: "色・形",
            difficulty: 1,
            exampleSentences: ["鉛筆が短くなりました。"]
        ),
        Vocabulary(
            word: "太い",
            reading: "ふとい",
            rubyText: "｜太《ふと》い",
            meaning: "幅が太いこと",
            category: "色・形",
            difficulty: 1,
            exampleSentences: ["木の幹が太いです。"]
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