/*
node calendar.js
node calendar.js -m 9
      9月 2023
日 月 火 水 木 金 土
                1  2
 3  4  5  6  7  8  9
10 11 12 13 14 15 16
17 18 19 20 21 22 23
24 25 26 27 28 29 30
*/

// process.argv[0] - 通常、実行されているNode.jsのパスです。
// process.argv[1] - スクリプトのパスです。
// process.argv[2] 以降 - それ以降の引数はコマンドライン引数として取得されます。
const args = process.argv.slice(2);
// 現在の年月を取得
const today = new Date();

// getFullYear()メソッドは、西暦年を取得する
let year = today.getFullYear();
// getMonth()メソッドは、月を0から11の整数で取得する:0-11 (Jan-Dec)
let month = today.getMonth();

// -m オプションの処理
if (args.length === 2 && args[0] === '-m') {
    const m = parseInt(args[1], 10);
    if (m < 1 || m > 12 || isNaN(m)) {
        console.error('無効な月を指定しました。');
        process.exit(1);
    }
    month = m - 1;  // 0-based month
}

// Dateオブジェクトの「日」の部分を0にすると、前月の末日になる
const getDaysInMonth = (year, month) => new Date(year, month + 1, 0).getDate();

// カレンダーを出力
const printCalendar = (year, month) => {
    const days = ["日", "月", "火", "水", "木", "金", "土"];
    const monthName = new Date(year, month).toLocaleString('ja-JP', { month: 'long' });

    console.log(`      ${monthName} ${year}`);
    console.log(days.join(' '));

    // 月の最初の日の曜日を取得。getDay()メソッドは、曜日を0から6の整数で取得する。
    const firstDay = new Date(year, month, 1).getDay();
    // 月の最後の日の日付を取得
    const lastDate = getDaysInMonth(year, month);

    let dayCount = 1;
    let output = ' '.repeat(3 * firstDay);  // スペースで最初の日まで埋める

    // dayCount（現在の日）がlastDate（月の最後の日）より小さいまたは等しい間、繰り返し実行    
    for (; dayCount <= lastDate; dayCount++) {
        
        // 文字列が指定の長さになるように先頭または末尾に文字を追加
        const dayStr = dayCount.toString().padStart(2, ' ');
        // 文字列の末尾に文字を追加:01 02 03 04......
        output += dayStr + ' ';

        // 7日ごとに改行するために、日曜日または月の最後の日の場合に改行する
        if ((dayCount + firstDay) % 7 === 0 || dayCount === lastDate) {
            console.log(output.trimEnd()); // trimEnd()メソッドは、文字列の末尾から空白を削除
            output = '';
        }
    }
}

printCalendar(year, month);

/*
> new Date(year, month + 1, 0).getDate();
30
> new Date(year, month, 1).getDay();
5
> new Date(year, month).toLocaleString('ja-JP')
'2023/9/1 0:00:00'
> new Date(year, month + 1, 0).toLocaleString('ja-JP')
'2023/9/30 0:00:00'
*/
