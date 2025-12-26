<h1 align="center">🔗 makelink.yazi</h1>
<p align="center">
  <b>A simple and effective plugin for <a href="https://github.com/sxyazi/yazi">Yazi</a> to create soft and hard links.</b><br>
  <i>Save a path, then link to it from anywhere.</i>
</p>

---

## 📖 Table of Contents

- [Features](#-features)
- [Installation](#%EF%B8%8F-installation)
- [Keymap Example](#-keymap-example)
- [Usage](#%EF%B8%8F-usage)

---

## 🚀 Features

- **Two-step workflow:** Save a source path and then create a link to it later.
- **Flexible linking:** Supports both soft (symbolic) and hard links.
- **Clear notifications:** Get feedback for each action.
- **Seamless integration:** Works asynchronously without blocking the UI.

---

## ⚡️ Installation

```bash
# Unix/Linux
git clone https://github.com/WindustH/makelink.yazi.git ~/.config/yazi/plugins/makelink.yazi

# Windows (CMD, not PowerShell!)
git clone https://github.com/WindustH/makelink.yazi.git %AppData%\\yazi\\config\\plugins\\makelink.yazi

# Or with a yazi package manager (e.g., https://github.com/yazi-rs/yazi/wiki/Awesome-Yazi#package-managers)
ya pkg add WindustH/makelink
```

---

## 🎹 Keymap Example

Add these keybindings to your `keymap.toml` to use the plugin:

```toml
[[mgr.prepend_keymap]]
on   = [ "c", "l", "s" ]
run  = "plugin makelink save"
desc = "Link: Save source path"

[[mgr.prepend_keymap]]
on   = ["c", "l", "l" ]
run  = "plugin makelink soft"
desc = "Link: Create soft link"

[[mgr.prepend_keymap]]
on   = [ "c", "l", "h" ]
run  = "plugin makelink hard"
desc = "Link: Create hard link"
```

---

## 🛠️ Usage

The plugin operates in two steps, using three separate commands:

1.  **Save Path:** Hover over the target file or directory you want to link **to**, and run the `save` action (e.g., press `cls`). You will get a notification that the source path has been saved.
2.  **Create Link:** Navigate to the destination directory where you want to create the link.
    *   Run the `soft` action (e.g., press `cll`) to create a soft link (symlink).
    *   Run the `hard` action (e.g., press `clh`) to create a hard link.

The link will be created in the current directory with the same name as the source file. The saved path is cleared after creating a link.