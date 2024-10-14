<div align="center"><p>
    <a href="https://github.com/Chen-Yulin/ColorfulDiff.nvim/releases/latest">
      <img alt="Latest release" src="https://img.shields.io/github/v/release/Chen-Yulin/ColorfulDiff.nvim?style=for-the-badge&logo=starship&color=C9CBFF&logoColor=D9E0EE&labelColor=302D41&include_prerelease&sort=semver" />
    </a>
    <a href="https://github.com/Chen-Yulin/ColorfulDiff.nvim/pulse">
      <img alt="Last commit" src="https://img.shields.io/github/last-commit/Chen-Yulin/ColorfulDiff.nvim?style=for-the-badge&logo=starship&color=8bd5ca&logoColor=D9E0EE&labelColor=302D41"/>
    </a>
    <a href="https://github.com/Chen-Yulin/ColorfulDiff.nvim/blob/main/LICENSE">
      <img alt="License" src="https://img.shields.io/github/license/Chen-Yulin/ColorfulDiff.nvim?style=for-the-badge&logo=starship&color=ee999f&logoColor=D9E0EE&labelColor=302D41" />
    </a>
    <a href="https://github.com/Chen-Yulin/ColorfulDiff.nvim/stargazers">
      <img alt="Stars" src="https://img.shields.io/github/stars/Chen-Yulin/ColorfulDiff.nvim?style=for-the-badge&logo=starship&color=c69ff5&logoColor=D9E0EE&labelColor=302D41" />
    </a>
    <a href="https://github.com/Chen-Yulin/ColorfulDiff.nvim/issues">
      <img alt="Issues" src="https://img.shields.io/github/issues/Chen-Yulin/ColorfulDiff.nvim?style=for-the-badge&logo=bilibili&color=F5E0DC&logoColor=D9E0EE&labelColor=302D41" />
    </a>
    <a href="https://github.com/Chen-Yulin/ColorfulDiff.nvim">
      <img alt="Repo Size" src="https://img.shields.io/github/repo-size/Chen-Yulin/ColorfulDiff.nvim?color=%23DDB6F2&label=SIZE&logo=codesandbox&style=for-the-badge&logoColor=D9E0EE&labelColor=302D41" />
    </a>
</div>



**ColorfulDiff.nvim** is a extremely light plugin that renders highlights for git diff.

![image](https://github.com/user-attachments/assets/ba072e82-2adb-4c42-ab57-718ce745f58f)

## 🚀 Getting Started

### Installation
If you are using Lazy.nvim:
```lua
require("lazy").setup({
  ...,
  {"Chen-Yulin/ColorfulDiff.nvim"},
})
```

### Configuration
```lua
local config = {
  colors = {
    origin = "#445522", -- color for the original part
    diff = "#225544", -- color for the incoming change
  },
  refresh_cycle = 250, -- smaller value for higher refresh frequency, will only refresh when the buffer has changed
}
require("colorful_diff").setup(config)
```
