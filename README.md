# 伝統色.nvim

> Four dark, transparency-first colorschemes in one plugin, derived from Overwatch's Shion concept art.

**At a glance:**

  `oxblood-chassis`  
  ![#0e0d11](https://img.shields.io/badge/%230e0d11-0e0d11?style=flat-square)
  ![#e9e4dc](https://img.shields.io/badge/%23e9e4dc-e9e4dc?style=flat-square)
  ![#9b2c30](https://img.shields.io/badge/%239b2c30-9b2c30?style=flat-square)
  ![#c9a24b](https://img.shields.io/badge/%23c9a24b-c9a24b?style=flat-square)
  ![#8fd9d4](https://img.shields.io/badge/%238fd9d4-8fd9d4?style=flat-square)

  `tiger-ink`  
  ![#100f14](https://img.shields.io/badge/%23100f14-100f14?style=flat-square)
  ![#e7e6ea](https://img.shields.io/badge/%23e7e6ea-e7e6ea?style=flat-square)
  ![#8a8893](https://img.shields.io/badge/%238a8893-8a8893?style=flat-square)
  ![#d9b14a](https://img.shields.io/badge/%23d9b14a-d9b14a?style=flat-square)
  ![#c45a3d](https://img.shields.io/badge/%23c45a3d-c45a3d?style=flat-square)
  ![#6fd6e6](https://img.shields.io/badge/%236fd6e6-6fd6e6?style=flat-square)

  `tiger-oxblood`  
  ![#100f14](https://img.shields.io/badge/%23100f14-100f14?style=flat-square)
  ![#e7e6ea](https://img.shields.io/badge/%23e7e6ea-e7e6ea?style=flat-square)
  ![#d9b14a](https://img.shields.io/badge/%23d9b14a-d9b14a?style=flat-square)
  ![#922c33](https://img.shields.io/badge/%23922c33-922c33?style=flat-square)
  ![#d97048](https://img.shields.io/badge/%23d97048-d97048?style=flat-square)
  ![#6fd6e6](https://img.shields.io/badge/%236fd6e6-6fd6e6?style=flat-square)

  `enji`  
  ![#0e0d11](https://img.shields.io/badge/%230e0d11-0e0d11?style=flat-square)
  ![#e9e4dc](https://img.shields.io/badge/%23e9e4dc-e9e4dc?style=flat-square)
  ![#9b2c30](https://img.shields.io/badge/%239b2c30-9b2c30?style=flat-square)
  ![#c9a24b](https://img.shields.io/badge/%23c9a24b-c9a24b?style=flat-square)
  ![#8fd9d4](https://img.shields.io/badge/%238fd9d4-8fd9d4?style=flat-square)
  ![#7e8aa8](https://img.shields.io/badge/%237e8aa8-7e8aa8?style=flat-square)

  ---

## Install

### lazy.nvim

  ```lua
{
  "pixelsandpointers/dentoushoku.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("dentoushoku").setup({ theme = "oxblood-chassis", transparent = true })
      end,
}
```

## Usage

Once installed, pick a theme any of these ways:

```lua
-- via setup (also lets you set transparency)
require("dentoushoku").setup({ theme = "tiger-ink", transparent = true })

-- via the unified loader, anytime after setup
require("dentoushoku").load("tiger-oxblood")
require("dentoushoku").load("oxblood-chassis", { transparent = false })
require("dentoushoku").load("enji")

-- or plain Neovim colorscheme commands — these always work too
:colorscheme oxblood-chassis
:colorscheme tiger-ink
:colorscheme tiger-oxblood
:colorscheme enji
```

A `:Dentoushoku` command is also registered for quick switching with
tab-completion:

```vim
:Dentoushoku tiger-ink
```

(Running `:Dentoushoku` with no argument defaults to `oxblood-chassis`.)

### Transparency

All four default to a transparent background (`Normal` highlight has
`bg = NONE`), meant to be paired with a transparent terminal — see the
Ghostty configs below. To force an opaque background instead:

```lua
require("dentoushoku").setup({ theme = "tiger-ink", transparent = false })
```

---

## Ghostty configs

Matching Ghostty terminal configs for each theme are in `ghostty/`. Copy the
one you want into `~/.config/ghostty/`, then reference it from your main
`~/.config/ghostty/config`:

```
config-file = oxblood-chassis.conf
```

Reload Ghostty (`Cmd+Shift+,` / `Ctrl+Shift+,`) to apply. Tune
`background-opacity` and `background-blur` inside the `.conf` file to taste.

---

## Palette reference

### oxblood-chassis

| Swatch | Theme role                          | Hex       |
|-------------------------------------------|--------------------------------------|-----------|
| ![#0e0d11](https://img.shields.io/badge/%230e0d11-0e0d11?style=flat-square) |  Background (transparent)             | `#0e0d11` |
| ![#e9e4dc](https://img.shields.io/badge/%23e9e4dc-e9e4dc?style=flat-square)                | Foreground text                      | `#e9e4dc` |
| ![#9b2c30](https://img.shields.io/badge/%239b2c30-9b2c30?style=flat-square)         | Primary accent (keywords, errors)    | `#9b2c30` |
| ![#c9a24b](https://img.shields.io/badge/%23c9a24b-c9a24b?style=flat-square)                          | Secondary accent (strings, warnings) | `#c9a24b` |
| ![#8fd9d4](https://img.shields.io/badge/%238fd9d4-8fd9d4?style=flat-square)              | Cursor / info / matches              | `#8fd9d4` |

### tiger-ink

| Swatch                     | Theme role                              | Hex       |
|----------------------------------------------|--------------------------------------------|-----------|
| ![#100f14](https://img.shields.io/badge/%23100f14-100f14?style=flat-square)       | Background (transparent)                   | `#100f14` |
| ![#e7e6ea](https://img.shields.io/badge/%23e7e6ea-e7e6ea?style=flat-square)                        | Foreground text                            | `#e7e6ea` |
| ![#8a8893](https://img.shields.io/badge/%238a8893-8a8893?style=flat-square)               | Comments / muted structural text           | `#8a8893` |
| ![#d9b14a](https://img.shields.io/badge/%23d9b14a-d9b14a?style=flat-square)             | Primary accent (keywords, functions)       | `#d9b14a` |
| ![#c45a3d](https://img.shields.io/badge/%23c45a3d-c45a3d?style=flat-square)              | Secondary accent (errors, exceptions)      | `#c45a3d` |
| ![#6fd6e6](https://img.shields.io/badge/%236fd6e6-6fd6e6?style=flat-square)                 | Cool accent (info, strings, search)        | `#6fd6e6` |

### tiger-oxblood

Same as tiger-ink, except the core-gem accent is true oxblood instead of
burnt red-orange — separating errors from the warm orange pistol-glow
accent, which now reads distinctly as its own color.

| Swatch                     | Theme role                              | Hex       |
|----------------------------------------------|--------------------------------------------|-----------|
| ![#100f14](https://img.shields.io/badge/%23100f14-100f14?style=flat-square)        | Background (transparent)                   | `#100f14` |
| ![#e7e6ea](https://img.shields.io/badge/%23e7e6ea-e7e6ea?style=flat-square)                        | Foreground text                            | `#e7e6ea` |
| ![#d9b14a](https://img.shields.io/badge/%23d9b14a-d9b14a?style=flat-square)             | Primary accent (keywords, functions)       | `#d9b14a` |
| ![#922c33](https://img.shields.io/badge/%23922c33-922c33?style=flat-square) | **Secondary accent (errors, exceptions)**  | `#922c33` |
| ![#d97048](https://img.shields.io/badge/%23d97048-d97048?style=flat-square) | Warm accent (warnings, diff-delete)        | `#d97048` |
| ![#6fd6e6](https://img.shields.io/badge/%236fd6e6-6fd6e6?style=flat-square) | Cool accent (info, strings, search)        | `#6fd6e6` |

### enji (臙脂)

Same underlying palette as oxblood-chassis — this variant renames every
field to the traditional Japanese color name its hex value lands closest
to. The primary red was the trigger: `#9b2c30` sits within a few RGB units
of the real 臙脂色 (enji-iro) reference value, a cochineal-red pigment name
historically used in lacquerware and dye. The whole theme took its name
from that match.

| Swatch | Lua field | Japanese name | Meaning | Theme role | Hex |
|--------|-----------|----------------|---------|------------|-----|
| ![#0e0d11](https://img.shields.io/badge/%230e0d11-0e0d11?style=flat-square) | `bg` | — | near-black | Background (transparent) | `#0e0d11` |
| ![#e9e4dc](https://img.shields.io/badge/%23e9e4dc-e9e4dc?style=flat-square) | `fg` | 白練 *shironeri* | unbleached silk | Foreground text | `#e9e4dc` |
| ![#9b2c30](https://img.shields.io/badge/%239b2c30-9b2c30?style=flat-square) | `enji` | 臙脂 *enji-iro* | cochineal red | Primary accent (keywords, errors) | `#9b2c30` |
| ![#c9a24b](https://img.shields.io/badge/%23c9a24b-c9a24b?style=flat-square) | `yamabuki` | 山吹 *yamabuki-iro* | golden yellow (kerria flower) | Secondary accent (strings, warnings) | `#c9a24b` |
| ![#8fd9d4](https://img.shields.io/badge/%238fd9d4-8fd9d4?style=flat-square) | `mizu` | 水 *mizu* | water blue | Cursor / matched search | `#8fd9d4` |
| ![#6fa8a3](https://img.shields.io/badge/%236fa8a3-6fa8a3?style=flat-square) | `asagi` | 浅葱 *asagi-iro* | light blue | Info / function names | `#6fa8a3` |
| ![#7e8aa8](https://img.shields.io/badge/%237e8aa8-7e8aa8?style=flat-square) | `fuji` | 藤 *fuji-iro* | wisteria | Operators / hints | `#7e8aa8` |
| ![#8a6a8f](https://img.shields.io/badge/%238a6a8f-8a6a8f?style=flat-square) | `murasaki` | 紫 *murasaki* | purple | Constants / numbers | `#8a6a8f` |
| ![#7a8a6b](https://img.shields.io/badge/%237a8a6b-7a8a6b?style=flat-square) | `yanagi` | 柳鼠 *yanagi-nezumi* | willow grey | Diff-add / success | `#7a8a6b` |
| ![#8a8590](https://img.shields.io/badge/%238a8590-8a8590?style=flat-square) | `fg_muted` | 利休鼠-adjacent *rikyū-nezumi* | Rikyū grey | Comments / muted text | `#8a8590` |

---
