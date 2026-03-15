# プロンプト前の空行を無効化
function _pure_prompt_beginning
end

# プロンプトシンボルを3色表示（エラー時は全て赤）
function _pure_prompt_symbol \
    --description 'Print prompt symbol with 3 colors' \
    --argument-names exit_code
    set --local command_succeed 0
    if set --query exit_code; and test "$exit_code" -ne $command_succeed
        echo (set_color --bold red)"❯❯❯"
    else
        echo (set_color --bold f55f17)"❯"(set_color --bold 1afea3)"❯"(set_color --bold 20d6fd)"❯"
    end
end

# ブランチ名の前にNerd Fontアイコンを表示
function _pure_prompt_git_branch
    set --local git_branch (_pure_parse_git_branch)
    if test -z "$git_branch"
        return
    end
    set --local branch_icon (printf '\ue65b')
    echo (set_color yellow)"$branch_icon $git_branch"
end

# ディレクトリ名の前にNerd Fontフォルダアイコンを表示
function _pure_prompt_current_folder --argument-names current_prompt_width
    if test -z "$current_prompt_width"; return 1; end
    set --local current_folder (_pure_parse_directory (math $COLUMNS - $current_prompt_width - 1))
    set --local current_folder_color (_pure_set_color $pure_color_current_directory)
    set --local folder_icon (printf '\uf07b')
    echo "$current_folder_color$folder_icon  $current_folder"
end

# gitステータスをstarshipデフォルトのシンボルで個別表示
# ! = unstaged, + = staged, ? = untracked
function _pure_prompt_git_dirty
    set --local result ""
    if not command git diff --ignore-submodules --no-ext-diff --quiet --exit-code 2>/dev/null
        set result "$result"(set_color yellow)"!"
    end
    if command git rev-list --max-count=1 HEAD -- >/dev/null 2>&1
        if not command git diff-index --ignore-submodules --cached --quiet HEAD -- 2>/dev/null
            set result "$result"(set_color green)"+"
        end
    else
        if not command git diff --staged --ignore-submodules --no-ext-diff --quiet --exit-code 2>/dev/null
            set result "$result"(set_color green)"+"
        end
    end
    if command git ls-files --others --exclude-standard --directory --no-empty-directory --error-unmatch -- ':/*' >/dev/null 2>&1
        set result "$result"(set_color red)"?"
    end
    echo "$result"
end
