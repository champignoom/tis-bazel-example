import json

config = [
    {
        "name": "hello-world",
        "files": [],
        "compilation_database": ["compile_commands.json"]
    }
]

with open("compile_commands.json") as f:
    config[0]["files"] = [p["file"] for p in json.load(f) if p["file"].endswith(".cc")]

print(json.dumps(config))
