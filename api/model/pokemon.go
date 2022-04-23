package model

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"os"
)

type Pokemon struct {
	ID    int      `json:"id"`
	Name  string   `json:"name"`
	Types []string `json:"types"`
	URL   string   `json:"url"`
}

func ReadJson() []Pokemon {
	jsonText, err := ioutil.ReadFile("data/pokemon.json")
	if err != nil {
		fmt.Println(err.Error())
		os.Exit(1)
	}
	var pokemons []Pokemon

	json.Unmarshal([]byte(jsonText), &pokemons)

	return pokemons
}

func GetAll() []Pokemon {
	pokemons := ReadJson()
	return pokemons
}
