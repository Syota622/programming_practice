package main

import (
	"fmt"
	"strconv"
)

func main() {
	// 異なる型の値を含むスライスを定義
	values := []interface{}{1, "2", 10, "11"}

	// range: スライスの要素数分ループ
	for _, value := range values {
		// 数値を文字列に変換
		var strValue string

		// switch: 型によって処理を分岐
		// value.(type): 型アサーション
		switch v := value.(type) {
		case int:
			// fmt.Printf("整数: %v (元の値: %d)\n", strconv.Itoa(v), v)
			strValue = strconv.Itoa(v) // 数値を文字列に変換
		case string:
			// fmt.Printf("文字列: %v\n", v)
			strValue = v
		default:
			fmt.Println("不明な型です。")
			continue
		}

		// 一桁なら前に0を付ける
		if len(strValue) == 1 {
			strValue = "0" + strValue
		}

		// 結果を表示
		fmt.Println(strValue)
	}
}
