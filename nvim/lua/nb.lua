local M = {}

-- nbコマンドのプレフィックス
local NB_CMD = "NB_EDITOR=: NO_COLOR=1 nb"

-- nbのノートディレクトリパスを取得
function M.get_nb_dir()
  -- nbのディレクトリパスに合わせて変更してください
  return vim.fn.expand("~/.nb")
end

-- nbコマンドを実行
function M.run_cmd(args)
  local cmd = NB_CMD .. " " .. args
  local output = vim.fn.systemlist(cmd)
  if vim.v.shell_error ~= 0 then
    return nil
  end
  return output
end

-- リスト行をパースして構造化データを返す
-- 例: "[1] 📷️ image.png" -> { note_id = "1", name = "image.png", is_image = true }
-- 例: "[2] ノートタイトル" -> { note_id = "2", name = "ノートタイトル", is_image = false }
function M.parse_list_item(line)
  local note_id = line:match("^%[(.-)%]")
  if not note_id then
    return nil
  end

  local is_image = line:match("📷️") ~= nil
  local name
  if is_image then
    name = line:match("%[%d+%]%s*📷️%s*(.+)$")
  else
    name = line:match("%[%d+%]%s*(.+)$")
  end

  if not name then
    return nil
  end

  return {
    note_id = note_id,
    name = vim.trim(name),
    is_image = is_image,
    text = line,
  }
end

-- パース済みアイテム一覧を取得
function M.list_items()
  local output = M.run_cmd("list --no-color")
  if not output then
    return nil
  end

  local items = {}
  for _, line in ipairs(output) do
    local item = M.parse_list_item(line)
    if item then
      table.insert(items, item)
    end
  end
  return items
end

-- nbノートのタイトルを取得する関数（bufferline用）
function M.get_title(filepath)
  local nb_dir = M.get_nb_dir()
  if not filepath:match("^" .. nb_dir) then
    return nil
  end

  local file = io.open(filepath, "r")
  if not file then
    return nil
  end

  local first_line = file:read("*l")
  file:close()

  if first_line then
    return first_line:match("^#%s+(.+)")
  end
  return nil
end

-- ノートIDからファイルパスを取得
function M.get_note_path(note_id)
  local output = M.run_cmd("show --path " .. note_id)
  if output and output[1] then
    return vim.trim(output[1])
  end
  return ""
end

-- ノートを削除
function M.delete_note(note_id)
  local output = M.run_cmd("delete --force " .. note_id)
  return output ~= nil
end

-- ノートを追加してIDを返す
function M.add_note(title)
  local timestamp = os.date("%Y%m%d%H%M%S")
  local note_title = title and title ~= "" and title or os.date("%Y-%m-%d %H:%M:%S")
  local escaped_title = note_title:gsub('"', '\\"')
  local args = string.format('add --no-color --filename "%s.md" --title "%s"', timestamp, escaped_title)

  local output = M.run_cmd(args)
  if not output then
    return nil
  end

  -- 追加されたノートのIDを取得
  for _, line in ipairs(output) do
    local note_id = line:match("%[(%d+)%]")
    if note_id then
      return note_id
    end
  end
  return nil
end

return M
