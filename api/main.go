package main

import (
	"api/model"

	"github.com/gin-gonic/gin"
)

func main() {
	r := gin.Default()

	r.GET("/pokemons", func(c *gin.Context) {
		pokemons := model.GetAll()
		c.JSON(200, pokemons)
	})

	r.Run()
}
