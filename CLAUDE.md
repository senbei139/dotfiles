# dotfiles

macOS 向けの個人用 dotfiles。シンボリックリンクで各設定を配置する。

## セットアップ

```sh
export DOTFILES_DIR="$HOME/workspace/github.com/$USERNAME/dotfiles"
sh initilize.sh     # brew でツールを導入し、pre-commit フックを有効化する
sh dotfilesLink.sh  # ~/ 以下へシンボリックリンクを張る
```

`.git/hooks` は git 管理外なので、clone した環境では `pre-commit install` が必要
（`initilize.sh` に含めてある）。

## 構成

| パス | 役割 |
|---|---|
| `.tmux.conf` | tmux。フッターと `prefix + w` の選択画面を独自に構成している |
| `tmux-status` | tmux のステータスライン用に git の状態を生成する。`~/.local/bin` へリンク |
| `wezterm/` | wezterm。タブバーは非表示で、情報はタイトルバーと tmux のフッターに集約 |
| `nvim/` | Neovim (lazy.nvim)。`.vimrc` は dein ベースの旧設定で現在は未使用 |
| `.zshrc` / `.zprofile` | zsh。`.zprofile` から `.zshrc` を source しないこと（二重読み込みになる） |

## tmux の設計

wezterm 側でタブバーを消しているため、**tmux のフッターが唯一の情報源**になっている。

### 色の意味

フッター・メッセージ・メニュー・選択画面で意味を統一している。色を足すときはこの体系に従う。

| 色 | 意味 | 使用箇所 |
|---|---|---|
| 青 `#6A90CD` | 入力待ち | セッション名、prefix 押下中の反転、プロンプト、通知 |
| 緑 `#34A853` | 選択中 | アクティブウィンドウ、choose-tree の選択行、メニューの選択行 |
| 黄 `#FBBC04` | 注意 | ZOOM、git の未ステージ変更、activity 通知 |
| 赤 `#EA4335` | 危険 | SYNC、COPY、保護ブランチ (main/master/release/develop) |

色は `.tmux.conf` の Define Colors セクションで変数化してある。**個別の箇所ではなく変数を変える**こと。

### tmux-status

`git status --porcelain=v2 --branch` 1 回でブランチ・追跡差分・作業ツリーをまとめて取得する。
`--no-optional-locks` を付けて、裏で走る git 操作を待たせないこと。

`/usr/local/bin` は root 所有で sudo が要るため、リンク先は `~/.local/bin` を使う。

## 見た目を変えたときの確認方法

設定値を `show -g` で見るだけでは分からない。**実際に描画して確認する**こと。

```sh
tmux -L test -f .tmux.conf new-session -d -s x -x 130 -y 28
tmux -L outer new-session -d -x 130 -y 28 "tmux -L test attach -t x"
tmux -L outer capture-pane -p  -t 0 | tail -3   # 描画結果
tmux -L outer capture-pane -pe -t 0 | tail -3   # 色つき（エスケープシーケンス）
```

`#()` の結果はジョブ完了後に入るため、初回の描画では空になることがある。

## 踏んだ罠

- **tmux 3.6a の `#{S:A,B}`（セッション反復の 2 引数形式）はサーバごとクラッシュする。**
  `#{W:A,B}` は安全。セッションごとに書式を変えたいときは
  `#{?#{==:#{session_name},#{client_session}},...}` で代用する
- **zsh の `$path` は `$PATH` と連動する特殊変数。** スクリプト内で `local path=...` とすると
  PATH が壊れ、以降の外部コマンドが見つからなくなる
- **ダブルクォート内の `~` は展開されない。** `[ -s "~/foo" ]` は常に false になる
- **zsh の glob 修飾子は配列代入の文脈でのみ評価される。**
  `[[ -n ~/.zcompdump(#q...) ]]` は `extended_glob` が無効だとただの文字列になり、条件が常に真になる
- **実行中の tmux サーバは、設定ファイルから消したオプションを保持し続ける。**
  `source-file` では既定に戻らないので、戻したい値は明示的に書く（例: `set -g status on`, `set -gu status-format`）
- **`export TERM` をシェル設定に書かない。** tmux が設定した TERM を上書きしてしまう

## コミット

Conventional Commits（`feat(tmux): ...`）。subject は日本語で書く。
pre-commit が有効なので、行末空白や機密情報が混ざるとコミットは止まる。
