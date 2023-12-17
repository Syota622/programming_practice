package main

import (
	"errors"
	"fmt"
)

// findKeyByValue は、map[int]string と文字列の値を受け取り、
// (int, error) を返す関数です。
func findKeyByValue(m map[int]string, value string) (int, error) {
	for key, val := range m {
		if val == value {
			return key, nil
		}
	}
	// errors.New は、文字列を受け取り、それをエラーとして返す関数です。
	return 0, errors.New("対応するキーが見つかりません")
}

func main() {
	// キーが int 型、値が string 型の map を作成
	m := map[int]string{
		1: "01",
		2: "02",
		3: "03",
	}

	key, err := findKeyByValue(m, "03")
	if err != nil {
		fmt.Println(err)
	} else {
		fmt.Println("キー:", key)
	}

	key, err = findKeyByValue(m, "05")
	if err != nil {
		fmt.Println(err)
	} else {
		fmt.Println("キー:", key)
	}
}
