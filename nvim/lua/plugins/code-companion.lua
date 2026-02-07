return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "ravitemer/mcphub.nvim",
  },
  opts = function(_, opts)
    local base_opts = {
      strategies = {
        chat = {
          adapter = "anthropic",
          roles = {
            llm = function(adapter)
              return "CodeCompanion (" .. adapter.formatted_name .. ")"
            end,
          },
        },
        inline = {
          adapter = "anthropic",
        },
      },
      adapters = {
        anthropic = function()
          return require("codecompanion.adapters").extend("anthropic", {
            env = {
              api_key = "cmd: gpg --quiet --decrypt ~/.gpg/.anthropic-api-key.gpg",
            },
            schema = {
              model = {
                default = "claude-3-7-sonnet-20250219",
              },
            },
          })
        end,
      },
      opts = {
        language = "Japanese"
      },
      extensions = {
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            show_result_in_chat = true,  -- Show mcp tool results in chat
            make_vars = true,            -- Convert resources to #variables
            make_slash_commands = true,  -- Add prompts as /slash commands
          }
        }
      },
      display = {
        chat = {
          auto_scroll = false,
          show_header_separator = true,
        },
      },
      prompt_library = {
        ["CopilotExplain"] = {
          strategy = "chat",
          description = "コードの説明をお願いする",
          prompts = {
            {
              role = "system",
              content = "あなたはコードの設計思想やアーキテクチャを重視する優秀なエンジニアです。"
            },
            {
              role = "user",
              content = "コードを日本語で説明してください"
            }
          },
        },
        ["CopilotReview"] = {
          strategy = "chat",
          description = "コードのレビューをお願いする",
          prompts = {
            {
              role = "system",
              content = "あなたは経験豊富なシニアエンジニアです。"
            },
            {
              role = "user",
              content = [[
コードをレビューしてください
**コンテキスト**
- 言語:

**レビュー観点**
1. セキュリティ脆弱性の有無
2. パフォーマンス上の問題
3. エラーハンドリングの適切性
4. コードの可読性・保守性

**出力形式**
- 優先度（高/中/低）を明記
- 具体的な改善提案を含める
- 可能であれば修正後のコード例を提示

**レビュー対象コード**
]]
            }
          },
        },
        ["CopilotFix"] = {
          strategy = "chat",
          description = "コードの修正をお願いする",
          prompts = {
            {
              role = "system",
              content = "あなたは優秀なエンジニアです。",
            },
            {
              role = "user",
              content = "このコードには問題があります。バグを修正したコードを表示してください。説明は日本語でお願いします"
            }
          },
        },
        ["CopilotOptimize"] = {
          strategy = "inline",
          description = "コードの最適化をお願いする",
          prompts = {
            {
              role = "system",
              content = "あなたは優秀なエンジニアです。",
            },
            {
              role = "user",
              content = "選択したコードを最適化し、パフォーマンスと可読性を向上させてください。説明は日本語でお願いします"
            }
          },
        },
        ["CopilotDocs"] = {
          strategy = "inline",
          description = "コードのドキュメント作成をお願いする",
          prompts = {
            {
              role = "system",
              content = "あなたは優秀なエンジニアです。",
            },
            {
              role = "user",
              content = "選択したコードに関するドキュメントコメントを日本語で生成してください"
            }
          },
        },
        ["CopilotTests"] = {
          strategy = "inline",
          description = "テストコード作成をお願いする",
          prompts = {
            {
              role = "system",
              content = "あなたは優秀なエンジニアです。",
            },
            {
              role = "user",
              content = "選択したコードの詳細なユニットテストを書いてください。説明は不要です"
            }
          },
        },
        ["CopilotFixDiagnostic"] = {
          strategy = "inline",
          description = "コードの診断結果に従って問題の修正をお願いする",
          prompts = {
            {
              role = "system",
              content = "あなたは優秀なエンジニアです。",
            },
            {
              role = "user",
              content = "コードの診断結果に従って問題を修正してください。修正内容の説明は日本語でお願いします"
            }
          },
        },
        -- ["CopilotCommit"] = {
        --   strategy = "inline",
        --   description = "コミットメッセージの作成をお願いする",
        --   prompts = {
        --     {
        --       role = "user",
        --       content = "実装差分に対するコミットメッセージを日本語で記述してください"
        --     }
        --   },
        -- }
        ["CopilotCommitStaged"] = {
          strategy = "inline",
          description = "ステージ済みのコミットメッセージの作成をお願いする",
          prompts = {
            {
              role = "user",
              content = "ステージ済みの変更に対するコミットメッセージを日本語で記述してください"
            }
          },
        }
      }
    }
    -- default -> 環境に依存しない設定 -> 環境に依存する設定 の順にマージ
    return vim.tbl_deep_extend("force", opts, base_opts, require("envs.code-companion").opts)
  end,
  keys = {
    {
      "<leader>cf",
      ":CodeCompanion<CR>",
      mode = { "n", "v" },
      silent = true,
    },
    {
      "<leader>cc",
      ":CodeCompanionChat<CR>",
      mode = { "n", "v" },
      silent = true,
    },
    {
      "<leader>ca",
      ":CodeCompanionAction<CR>",
      mode = { "n", "v" },
      silent = true,
    },
  },
}
