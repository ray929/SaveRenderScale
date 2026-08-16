# Save Render Scale | 保存渲染比例

为多开玩家设计：每个账号记住自己的渲染比例，登录时自动恢复。
Built for multiboxers: each account remembers its own Render Scale and restores it automatically on login.

---

## 简体中文

### 为什么需要它？

《魔兽世界》客户端的渲染比例（Render Scale）是全局设置，**不区分账号保存**——无论哪个角色修改了它，客户端只记住最后一次的值。

对多开玩家来说这很折磨：大号想要高画质，小号想要低渲染比例换取多开流畅度，但每次登录都要手动来回改，忘了改还会互相覆盖。

### 它做了什么

本插件按账号分别记录渲染比例。登录任意角色时，自动恢复该账号上次使用的渲染比例：

- 小号永远是低渲染比例——多开更流畅、占用更低
- 大号永远是高渲染比例——画质不受影响

### 功能特性

- 按账号独立保存，互不覆盖
- 登录时自动恢复，无需任何手动操作
- 零配置：装好即用，没有选项面板，没有命令
- 轻量零负担：单文件、无库依赖

### 工作方式

1. 你在 系统设置 → 图形 中调整渲染比例，插件立即为当前账号保存该数值
2. 下次登录该账号的任意角色，自动应用

### 兼容性

- 适用于《魔兽世界》12.0 / 12.0.1 / 12.1

## English

### Why do I need it?

The Render Scale in World of Warcraft is a client-wide setting — it is **not saved per account**. No matter which character changes it, the client only remembers the last value used.

That's a pain for multiboxers: you want high quality on your main but low Render Scale on your alts for smoother performance, yet you have to change it back and forth manually every login — and forget once, and one account's setting overwrites the other's.

### What it does

This addon records the Render Scale per account. Whenever you log in, it automatically restores the value that account last used:

- Alts always run at low Render Scale — smoother and lighter when multiboxing
- Your main always runs at high Render Scale — image quality untouched

### Features

- Saved per account, never overwriting each other
- Restored automatically on login — no manual steps
- Zero configuration: works out of the box — no options panel, no commands
- Lightweight: single file, no libraries

### How it works

1. You adjust Render Scale in System Settings → Graphics, and the addon saves it for the current account instantly
2. On your next login with that account (any character), it is applied automatically

### Compatibility

- For World of Warcraft 12.0 / 12.0.1 / 12.1
