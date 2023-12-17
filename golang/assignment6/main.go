package main

import "fmt"

type MyInt int

// MyInt型に対するStringメソッドを定義
func (m MyInt) String() string {
	return "hoge"
}

func main() {
	// MyInt型の変数mを作成し、その値を3に設定する
	var m MyInt = 3

	// Stringメソッドにより"hoge"と出力される
	fmt.Println(m.String())
}
