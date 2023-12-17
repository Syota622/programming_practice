package main

import (
	"fmt"
)

type User struct {
	Name string
	Age  int
}

func main() {
	users := []User{
		{"tarou", 33},
		{"zirou", 22},
		{"itirou", 11},
	}

	// userに何らかの変更が加えても、usersには反映されない
	// for _, user := range users {
	// 	user.Age = 44
	// }

	for i := range users {
		users[i].Age = 44
	}

	fmt.Printf("%v", users) // どうなる？
}
