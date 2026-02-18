## Requirements

### Neovim

- Neovim Nightly (installed using `bob`)

Install with:
https://github.com/MordechaiHadad/bob

---

### LSP Servers (Installed via Mason)

Install inside Neovim using `:Mason`.

Common servers:

- lua-language-server
- clangd
- pyright
- tsserver
- tailwindcss-language-server
- html-lsp
- css-lsp

---


# Keymaps

## Insert Mode

| Key | Action |
|------|--------|
| `jk` | Escape insert mode and save file |

---

## Core / Buffer Management

| Key | Action |
|------|--------|
| `Esc` | Clear search highlight |
| `Shift + h` | Previous buffer |
| `Shift + l` | Next buffer |
| `<leader>q` | Delete current buffer |
| `<leader>t` | Close all buffers except current |

---

## File Picking (mini.pick)

| Key | Action |
|------|--------|
| `<leader><leader>` | Pick files |
| `<leader>fg` | Live grep |
| `<leader>h` | Help tags |
| `<leader>b` | Pick buffers |
| `<leader>sw` | Search word under cursor |

---

## Mini.visits

| Key | Action |
|------|--------|
| `<leader>vr` | Select visited path |

---

## Mini.files

| Key | Action |
|------|--------|
| `<leader>e` | Toggle file explorer |

---

## Mini.sessions

| Key | Action |
|------|--------|
| `<leader>ss` | Save session |
| `<leader>sr` | Restore/select session |

---

## Splits

| Key | Action |
|------|--------|
| `<leader>sh` | Vertical split and swap original buffer |
| `<leader>sv` | Horizontal split and swap original buffer |
| `Ctrl + h` | Move to left split |
| `Ctrl + j` | Move to down split |
| `Ctrl + k` | Move to up split |
| `Ctrl + l` | Move to right split |

---

## CompetiTest

| Key | Action |
|------|--------|
| `<leader>ra` | Add testcase |
| `<leader>rr` | Run tests |

---

## LSP (Active on LspAttach)

| Key | Action |
|------|--------|
| `<leader>gd` | Go to definition |
| `<leader>gr` | Show references |
| `<leader>ca` | Code action |
| `K` | Hover documentation |

---

## Trouble

| Key | Action |
|------|--------|
| `<leader>d` | Toggle diagnostics |
| `<leader>fx` | Toggle quickfix list |
