#!/bin/env python3

import json
from os.path import isfile
import sys

if not isfile("blocks.json"):
    print(f"ERROR: File `blocks.json` does not exist", file=sys.stderr)
    exit(1)

blocks_json = {}
with open("blocks.json", "r") as f:
    blocks_json = json.load(f)

print("Writing block list to `file.txt`...")
with open("file.txt", "w") as f:
    for k, _ in blocks_json.items():
        print(k, file=f)