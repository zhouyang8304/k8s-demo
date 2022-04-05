package main

import (
	"fmt"
	"github.com/gin-gonic/gin"
	"net/http"
)

func setupRouter() (*gin.Engine, error) {
	ginEngine := gin.Default()
	ginEngine.GET("/health", func(c *gin.Context) {
		c.String(http.StatusOK, "ok")
	})

	ginEngine.GET("/hello", func(c *gin.Context) {
		c.String(http.StatusOK, "world v1")
	})

	return ginEngine, nil
}

func main() {
	ginEngine, err := setupRouter()
	if err != nil {
		panic(err)
	}

	err = ginEngine.Run(fmt.Sprintf(":%d", 80))

	if err != nil {
		panic(err)
	}
}
