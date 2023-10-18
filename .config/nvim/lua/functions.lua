local nvim_create_user_command = vim.api.nvim_create_user_command

-- 半角スペースを全て削除
nvim_create_user_command("DeleteHalfSpaces", function()
	vim.cmd([[
  execute("%s/ *$//g")
]])
end, {})

-- jqをVim上で実行
nvim_create_user_command("JsonFormatter", function()
	vim.cmd([[
  if !executable('jq')
    call s:echo_err("not found jq command.")
  endif

  execute("%!jq '.'")
]])
end, {})

-- xmlを整形
nvim_create_user_command("XmlFormatter", function()
	vim.cmd([[
  execute("%s/></>\r</g | filetype indent on | setf xml | normal gg=G")
]])
end, {})

-- Glowをvim上で実行する
nvim_create_user_command("Glow", function()
	vim.cmd([[
  if !executable('glow')
    call s:echo_err("not found glow command.")
  endif

  execute('vs | wincmd j | resize 100 | terminal glow')
]])
end, {})

-- タブラインのカスタマイズ
-- タブをのファイル名 + ファイルフォーマットののアイコンの形式に変更する
vim.cmd([[
  function MyTabLine()
    let s = ''
    for i in range(tabpagenr('$'))
      " select the highlighting
      if i + 1 == tabpagenr()
        let s .= '%#TabLineSel#'
      else
        let s .= '%#TabLine#'
      endif
      " set the tab page number (for mouse clicks)
      let s .= '%' . (i + 1) . 'T'
      " the label is made by MyTabLabel()
      let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
      if i + 1 == tabpagenr()
        let s .= '%#TabLineSep#'
      elseif i + 2 == tabpagenr()
        let s .= '%#TabLineSep2#'
      else
        let s .= ''
      endif
    endfor

    " after the last tab fill with TabLineFill and reset tab page nr
    let s .= '%#TabLineFill#%T'

    " right-align the label to close the current tab page
    if tabpagenr('$') > 1
      let s .= '%=%#TabLine#%999X'
    endif
    return s
  endfunction

  function MyTabLabel(n)
    let buflist = tabpagebuflist(a:n)
    let winnr = tabpagewinnr(a:n)
    let name = bufname(buflist[winnr - 1])
    let icon = WebDevIconsGetFileTypeSymbol(name)
    let result = printf('%s %s ', name, icon)
    let label = fnamemodify(result, ':t')
    return len(label) == 0 ? '[No Name]' : label
  endfunction

  set tabline=%!MyTabLine()
]])
