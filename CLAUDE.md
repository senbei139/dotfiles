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
| `.tmux.conf` | tmux。フッターと switch 画面（`prefix + w`）を独自に構成している |
| `tmux-status` | tmux のステータスライン用に git の状態を生成する。`~/.local/bin` へリンク |
| `tmux-switch` | **switch 画面**。`prefix + w` の fzf ポップアップで、セッション / ウィンドウ操作の唯一の入口。`~/.local/bin` へリンク |
| `tmux-agent-state` | ペインで動いている Claude Code の状態を記録・集計する。Claude Code の hooks から呼ばれる。`~/.local/bin` へリンク |
| `tmux-oil` | 一括編集。`tmux-switch` から `^e` で入る。一覧を `$EDITOR` で開き、保存すると差分を tmux コマンドに変換する。`~/.local/bin` へリンク |
| `wezterm/` | wezterm。タブバーは非表示で、情報はタイトルバーと tmux のフッターに集約 |
| `nvim/` | Neovim (lazy.nvim)。`.vimrc` は dein ベースの旧設定で現在は未使用 |
| `herdr/` | herdr（AI エージェント向けターミナルワークスペース）。キーバインドは tmux に合わせてある |
| `.zshrc` / `.zprofile` | zsh。`.zprofile` から `.zshrc` を source しないこと（二重読み込みになる） |

## tmux の設計

wezterm 側でタブバーを消しているため、**tmux のフッターが唯一の情報源**になっている。

セッション / ウィンドウの操作は **switch 画面**（`prefix + w` = `tmux-switch`）に統合してある。
このリポジトリではこの画面を「switch 画面」と呼ぶ（herdr 側の `prefix + w` は別実装の `goto`）。
切り替え・リネーム・新規作成・削除はその場で、まとめて整理したいときは `^e` で
`tmux-oil` のバッファ編集へ抜ける（`:w` で反映 / `:q!` で中止、どちらでも一覧に戻る）。
キーの一覧は fzf のヘッダに出している。

操作は vim 風のモーダルにしてある。通常モードでは文字キーをクエリに入れず
`j` / `k` の移動を優先し、`/` を押したときだけ検索できる。`Esc` で通常モードに戻る。

一覧はセッションを独立した列にして罫線で区切り、階層が一目で分かるようにしてある。
セッション名はフッターと同じ青。fzf は行単位で絞り込むので、見出し行でグループ化すると
検索したときに見出しだけ消えて子が浮く。所属情報は各行に持たせること。

並びは `#{window_activity}` の降順（choose-tree の `-O time` と同じ基準）。
先頭は今いるウィンドウになるので、初期カーソルは 1 つ下に置いてある。
`prefix + w` → `Enter` が「直前のウィンドウへ戻る」になる。

`^t` / `^n` は作ったウィンドウ・セッションへそのまま移動する（ポップアップは閉じる）。
tmux 側のエラー（名前の重複など）はポップアップが閉じると読めないので、
キー入力を待ってから一覧に戻る。

### 生成 AI の状態

Claude Code のペインは `pane_current_command` がバージョン文字列 (`2.1.267`) になって
何も分からないので、ウィンドウ名は端末タイトル (会話のタイトルが `✳` 付きで入る) から
取る (`automatic-rename-format`)。長くなるので表示する側で `#{=/N/…}` で畳む。


tmux にエージェントの概念は無いので、状態は **Claude Code の hooks から書き込む**
(`tmux-agent-state hook <state>`、割り当ては `.claude/settings.json`)。
`tmux-switch` の一覧と、フッターの AI セグメントが同じファイルを読む。

| 記号 | 状態 | 色 | hook |
|---|---|---|---|
| `◆` | 承認・入力待ち | 青 (入力待ち) | `Notification` |
| `◐` | 実行中 | 黄 (注意) | `UserPromptSubmit` |
| `✓` | 応答が終わった | 緑 (良好) | `Stop` |
| `✳` | 起動しているだけ | グレー | `SessionStart` |

`✓` は 10 分 (`DONE_TTL`) で `✳` に落として居座らせない。ウィンドウに複数のペインが
あるときは緊急度の高い方を代表にする。

出す場所は 3 つ。

| 場所 | 中身 |
|---|---|
| フッター右 | `◆` `◐` の件数だけ (見落とすと困るものに絞る)。クリックでそのペインへ移動 |
| フッター中央のウィンドウ一覧 | ウィンドウごとの印。`window-status-format` では `#()` が使えないので、`tmux-agent-state sync` が `@ai_state` / `@ai_glyph` に置いた値を読む |
| switch 画面の一覧 | ウィンドウごとの印 (`tmux-agent-state windows`) |

`prefix + a` で承認待ち (無ければ実行中) のペインへ移動する。複数あるときは押すたびに巡回する。

状態はソケット名で分けて `~/.cache/tmux-agent-state/<socket>/` に置く。フッターの
`status` は 5 秒ごとに呼ばれるので、そこで印の同期も兼ねている (hook は状態が
変わったときしか来ないため、完了の期限切れやペインの消滅を拾えない)。

hooks は Claude Code の起動時に読み込まれるので、割り当てを変えたら既存の
セッションは再起動が必要。

### 色の意味

フッター・メッセージ・メニュー・switch 画面で意味を統一している。色を足すときはこの体系に従う。

| 色 | 意味 | 使用箇所 |
|---|---|---|
| 青 `#6A90CD` | 入力待ち | セッション名、prefix 押下中の反転、プロンプト、通知 |
| ティール `#5FA3A3` | 選択中 | アクティブウィンドウ、メニューの選択行、fzf のポインタ |
| 緑 `#34A853` | 追加・良好 | git の `+N` `↑N`、statusline の余裕バーと追加行数 |
| 黄 `#FBBC04` | 注意 | ZOOM、git の未ステージ変更、activity 通知 |
| 赤 `#EA4335` | 危険 | SYNC、COPY、保護ブランチ (main/master/release/develop) |
| シアン `#24C1E0` | 識別子 | git のブランチ名、fzf の一致部分 |

「選択中」と「追加・良好」はどちらも緑だと意味が混ざるため、前者をティールに分けてある。
反転表示の背景に使う色は、文字色 `#1f2022` に対して 4.5:1 以上のコントラストを確保すること。

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
- **シェルの `read` は Esc を拾えない。** プロンプトに入ったら Enter か ^C 以外で抜けられず
  行き止まりになる。名前の入力には空リストの `fzf --print-query` を使う
  （Esc / ^C なら 130 が返る。Enter は候補ゼロなので 1 が返るが、クエリは出力される）
- **`while ... done < file` の中の `read` はファイルから読む。** 確認プロンプトを出したい
  ときは `read -q ... < /dev/tty` と端末を明示する
- **ポップアップはコマンドが終わると即閉じるので、エラーメッセージは読めない。**
  異常終了する前にキー入力を待つこと
- **`--ansi` の色は選択行にも残るので、行の色分けと反転表示は両立しない。**
  `fg+` は色の付いていない部分にしか効かず、青 `#6A90CD` はティール `#5FA3A3` の上で
  1.1:1 になって読めなくなる。行ごとに色を付けるなら、選択中はポインタで示すこと
- **fzf の `start` イベントはリスト読み込み前に発火する。** 初期カーソルを動かしたいときは
  `load` を使う。ただし `load` は `reload` のたびに来るので、一度きりにしたいなら
  `load:down+unbind(load)` のように自分を外す
- **fzf にモードの概念はないが、`unbind` / `rebind` と `transform` で作れる。**
  通常モードでは文字キーを `:ignore` に潰し、`/` で `unbind(...)` して打てる状態に戻す。
  `rebind` は起動時に定義した内容しか復元できないので、同じキーをモードごとに
  違う動作にしたいときは `transform` で `$FZF_PROMPT`（= モード表示）を見て分岐する
- **`tmux set -wtu <target> <option>` は効かない。** getopt が `-t` の引数を `"u"` と
  読んでしまう。`set -w -u -t <target> <option>` と分けて書く
- **ペイン ID は tmux サーバごとの通番。** 状態をソケット名で分けずに置くと、検証用の
  サーバ (`-L test`) を動かしたときに互いの状態を「死んだペインの残骸」と見て消し合う
- **`window-status-format` の中で `#[fg=...]` を使うなら `#[push-default]` /
  `#[pop-default]` で囲む。** `#[default]` だと選択中の反転背景ごと消える。
  なお反転中の背景はティールなので、そこに青を乗せると 1.1:1 で読めない
  (選択中のウィンドウの印だけ文字色を `$BG_DARK` にしている)
- **`#{=/N/…:...}` は表示幅で数えるが、`tmux-switch` の awk 側はバイト数で数える。**
  日本語のウィンドウ名 (会話タイトル) が入ると列がずれるので、桁揃えは zsh の
  `${(mr:N:: :)str}` (m フラグ = 表示幅) で行う
- **画面の文字列で AI の状態を判定すると会話の本文に引っかかる。**
  `esc to interrupt` や `do you want to proceed?` は説明のために表示されることがあり、
  `capture-pane` を grep する方式では誤検出する (実際に無関係なペインが承認待ちに見えた)。
  状態は hooks から書かせること
- **choose-tree の tree mode のキーはハードコードで、`bind -T` では増やせない。**
  キーテーブルが存在するのは `copy-mode` / `copy-mode-vi` だけ。tree mode 内でリネームや
  新規作成をするには `:`（`%%` が選択中／tag 済みの対象に置換される）を使うしかない。
  拡張できないので choose-tree は使わず、`prefix + w` の fzf 版に一本化してある
  （プレビューは `--preview 'tmux capture-pane -ep -t {1}'` で代替できる）

## コミット

Conventional Commits（`feat(tmux): ...`）。subject は日本語で書く。
pre-commit が有効なので、行末空白や機密情報が混ざるとコミットは止まる。
