#!/bin/zsh
#
# Claude Code のステータスライン。stdin にセッション情報の JSON が渡される。
# 仕様: https://code.claude.com/docs/en/statusline
#
# 色は .tmux.conf のパレットに揃える。
#   青 = 情報 / 緑 = 余裕 / 黄 = 注意 / 赤 = 危険
#
# NOTE: イベントごと (300ms デバウンス) に実行されるので、git のような遅いコマンドは呼ばない。
#       カレントディレクトリと git の状態は tmux のフッター側が表示するため、
#       ここでは Claude Code しか知らない情報 (モデル・コンテキスト・コスト) に絞る。

emulate -L zsh

local BLUE=$'\033[38;2;106;144;205m'
local GREEN=$'\033[38;2;52;168;83m'
local YELLOW=$'\033[38;2;251;188;4m'
local RED=$'\033[38;2;234;67;53m'
local NORMAL=$'\033[38;2;154;158;171m'
local DIM=$'\033[38;2;95;99;104m'
local RESET=$'\033[0m'

# jq は 1 回だけ呼び、1 行 1 値で受け取る
local -a fields
fields=("${(@f)$(jq -r '[
  (.model.display_name // "?"),
  (((.workspace.project_dir // .cwd // "") | split("/") | last) // ""),
  ((.context_window.used_percentage // 0) | floor),
  (.cost.total_cost_usd // 0),
  (.cost.total_lines_added // 0),
  (.cost.total_lines_removed // 0)
] | .[]' 2>/dev/null)}")

# jq が失敗した (JSON が壊れている等) 場合は何も出さない
(( ${#fields} >= 6 )) || exit 0

local model=$fields[1] project=$fields[2] cost=$fields[4]
local -i pct=$fields[3] added=$fields[5] removed=$fields[6]

# コンテキスト使用率。残りが少なくなるほど強い色にする
local ctx_color=$GREEN
(( pct >= 70 )) && ctx_color=$YELLOW
(( pct >= 85 )) && ctx_color=$RED

local -i filled=$(( pct / 10 ))
(( filled > 10 )) && filled=10
local bar=""
repeat $filled bar+="█"
repeat $(( 10 - filled )) bar+="░"

local out="${BLUE}${model}${RESET}"
[[ -n $project ]] && out+="  ${NORMAL}${project}${RESET}"
out+="  ${ctx_color}${bar} ${pct}%${RESET}"
out+="  ${DIM}$(printf '$%.2f' $cost)${RESET}"
# 何も編集していないうちは行数を出さない
local changes=""
(( added > 0 ))   && changes+=" ${GREEN}+${added}${RESET}"
(( removed > 0 )) && changes+=" ${RED}-${removed}${RESET}"
[[ -n $changes ]] && out+=" $changes"

print -r -- "$out"
