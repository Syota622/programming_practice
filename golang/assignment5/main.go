package main

import "fmt"

var appConfig = Config{Env: "test"}

type Config struct {
	Env string
}

func getConfig() *Config { // 1つ目の変更: 戻り値の型をポインタに
	return &appConfig // 2つ目の変更: appConfigのアドレスを返す
}

// func getConfig() Config {
// 	return appConfig
// }

func main() {
	c := getConfig()
	fmt.Println(c)
	c.Env = "production"
	fmt.Println(c)

	fmt.Println(c.Env)         // production
	fmt.Println(appConfig.Env) // testではなくproducionへ
}
