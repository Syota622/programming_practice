package main

import (
	"fmt"
)

// MyIntSlice は int のスライスに互換性のある独自の型です。
type MyIntSlice []int

// MyIntSlice：Unique は、レシーバーが保持するスライスの重複を削除したスライスを返すメソッドです。
// Unique()：関数名
// MyIntSlice：戻り値の型
func (s MyIntSlice) Unique() MyIntSlice {

	seen := make(map[int]bool)

	// 空のスライスを作成
	var unique MyIntSlice

	// range: スライスの要素数分ループ
	for _, v := range s {

		// if _, ok := seen[v]; !ok：この条件文は、vがseenマップにすでに存在するかどうかをチェック
		// seen[v];：Golangの二つの戻り値が返される
		// !boolean：booleanがfalseの場合にtrueを返す
		if _, boolean := seen[v]; !boolean {
			// fmt.Println(seen)
			seen[v] = true
			unique = append(unique, v)
		}

	}

	return unique
}

func main() {
	m := MyIntSlice{5, 1, 2, 2, 3, 3, 3, 4}
	fmt.Println(m.Unique()) // [1 2 3 4 5]
}
