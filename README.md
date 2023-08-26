# The Ohio RP Custom Minecraft

<p align="center">
  <br>
    <img alt="logo" src="./logo.png" height="272" />
  <br>
  <br>
  The minetest-based game for Ohio RP
<p>

The Ohio RP Custom Minecraft (OhioCraft). This is a fork of [`minetest_game`](https://github.com/minetest/minetest_game). <br>
If you want to know our general goals with this project, please read the [organization's README](https://github.com/OhioRP). <br>
To get more info about the [Utils](./Utils/) folder, read [Utils](#utils). <br>
To get more info on the remaining Minecraft stuff that needs to be implemented, check [`blocklist.txt`](./blocklist.txt). <br>
This game is obviously API compatible with [`minetest_game`](https://github.com/minetest/minetest_game), so if you want to use its API, please check `minetest_game`'s API. <br>
<br>
**If you want to contribute to the project, please read [Contributing](CONTRIBUTING.md)**.

## Quick Start (Linux)
```console
$ ./install.sh # will install to `~/.minetest/mods/ohiocraft`
```

## Utils

Useful scripts meant to make the development process easier.

### `parse_blocks_json.py`

A script that will parse [`blocks.json`](#blocksjson) and generate a list of blocks in `file.txt`.

#### `blocks.json`

A file containing Minecraft: Java Edition block data. Can be generated by downloading the server and running:
```console
$ java -DbundlerMainClass=net.minecraft.data.Main -jar server.jar --all
```
The generated `blocks.json` will be located at `./generated/reports/blocks.json`.
