" 行末の半角スペースを一括削除
command! DeleteSpace call DeleteSpace()
function! DeleteSpace()
  execute("%s/ *$//g")
endfunction

" filetypeを変更する
command! -nargs=1 ChangeFileType call ChangeFileType(<f-args>)
function! ChangeFileType(filetype)
  execute("set filetype=".a:filetype)
endfunction

" カーソル上のsyntax情報を取得する
function! s:get_syn_id(transparent)
  let synid = synID(line("."), col("."), 1)
  if a:transparent
    return synIDtrans(synid)
  else
    return synid
  endif
endfunction

function! s:get_syn_attr(synid)
  let name = synIDattr(a:synid, "name")
  let ctermfg = synIDattr(a:synid, "fg", "cterm")
  let ctermbg = synIDattr(a:synid, "bg", "cterm")
  let guifg = synIDattr(a:synid, "fg", "gui")
  let guibg = synIDattr(a:synid, "bg", "gui")
  return {
        \ "name": name,
        \ "ctermfg": ctermfg,
        \ "ctermbg": ctermbg,
        \ "guifg": guifg,
        \ "guibg": guibg}
endfunction

command! SyntaxInfo call s:get_syn_info()
function! s:get_syn_info()
  let baseSyn = s:get_syn_attr(s:get_syn_id(0))
  echo "name: " . baseSyn.name .
        \ " ctermfg: " . baseSyn.ctermfg .
        \ " ctermbg: " . baseSyn.ctermbg .
        \ " guifg: " . baseSyn.guifg .
        \ " guibg: " . baseSyn.guibg
  let linkedSyn = s:get_syn_attr(s:get_syn_id(1))
  echo "link to"
  echo "name: " . linkedSyn.name .
        \ " ctermfg: " . linkedSyn.ctermfg .
        \ " ctermbg: " . linkedSyn.ctermbg .
        \ " guifg: " . linkedSyn.guifg .
        \ " guibg: " . linkedSyn.guibg
endfunction

" GlowをVimターミナル上で実行する
command! GlowOpen call GlowOpen()
function! GlowOpen()
  if !executable("glow")
    call s:echo_err("not found glow command.")
  endif

  echo "open markdown..."

  execute("T glow")
endfunction

" jqをVim上で実行
command! JsonFormatter call JsonFormatter()
function! JsonFormatter()
  if !executable("jq")
    call s:echo_err("not found jq command.")
  endif

  execute("%!jq '.'")
endfunction
