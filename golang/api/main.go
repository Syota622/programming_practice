package main

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

type Item struct {
	ID   int    `json:"id"`
	Name string `json:"name"`
}

func main() {
	// 1. Ginルーターを初期化
	router := gin.Default()

	// 2. ルートエンドポイントを設定
	router.GET("/api/items", getItems)    // GETリクエスト用エンドポイント
	router.POST("/api/items", createItem) // POSTリクエスト用エンドポイント

	// 3. サーバーをポート8080で起動
	router.Run(":8080")
}

func getItems(c *gin.Context) {
	// 4. サンプルのアイテムリストを作成
	items := []Item{
		{ID: 1, Name: "Item 1"},
		{ID: 2, Name: "Item 2"},
	}

	// 5. JSON形式でアイテムリストをレスポンスとして返す
	c.JSON(http.StatusOK, items)
}

func createItem(c *gin.Context) {
	var newItem Item

	// 6. リクエストボディからアイテムデータをバインド
	if err := c.BindJSON(&newItem); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	// 7. 新しいアイテムを保存（ここではダミーのIDを付与）
	newItem.ID = 3 // 仮のID

	// 8. 新しいアイテムをレスポンスとして返す
	c.JSON(http.StatusCreated, newItem)
}
