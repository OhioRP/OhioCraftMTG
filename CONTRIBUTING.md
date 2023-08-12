# Contributing

## Before making any changes

If you want to implement anything too complex, like enchanting or redstone, please create a separate mod for that.

## Code conventions

- Everything is formatted using [`lua-language-server`](https://github.com/LuaLS/lua-language-server)
- Features that do not depend on the existing system should be implemented on a separate file. Like how [Amethyst](./PortCraft/blocks/amethyst.lua) is not implemented in the same file as [Stone Like Blocks](./PortCraft/blocks/stone_like.lua)

## Adding media

If you want to add any kind of media (like textures or sounds) into the project, please make sure the licensing allows it to be added. <br>
In case of self-created content, you will need to agree that your content will be licensed under the [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/). <br>
After adding any kind of media, please specify the author and the license in a README file inside the mod's `textures` or `sounds` folder, depending on the folder you added your media to.