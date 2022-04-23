import json
import numpy as np
import pandas as pd

class JsonFormatter:
    def __init__(self, file_path):
        self.file_path = file_path

    def format(self):
        df = pd.read_csv(self.file_path)
        df = df[["id", "name", "type1", "type2", "height", "weight", "status", "hp", "attack", "defence", "sp_atk", "sp_def", "speed", "url"]]
        df["types"] = df[["type1", "type2"]].apply(lambda x: [x.dropna().astype(str)], axis=1)
        df.drop(["type1", "type2"], axis=1, inplace=True)

        return df


if __name__ == "__main__":
    formatter = JsonFormatter("../data/pokemon.csv")
    df = formatter.format()
    df.to_json("../data/pokemon.json", orient="records", force_ascii=False)

    with open("../data/pokemon.json", "r+") as f:
        data  = json.load(f)
        for i, d in enumerate(data):
            d["types"] = d["types"][0]

    with open("../data/pokemon.json", "w") as f:
        json.dump(data, f, ensure_ascii=False)
