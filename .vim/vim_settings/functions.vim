" grepをラップした関数
command! -nargs=+ GrepWrap call GrepWrap(<f-args>)
function! GrepWrap(name, extension)
  execute("grep -r " .a:name. " *." .a:extension)
endfunction

" 検索にヒットした単語の数を表示
" command! -nargs=1 SCount call SCount(<f-args>)
" function! SCount(name)
"   try
"     execute("%s/" .a:name. "//gn")
"   catch
"     echo '一致するワードはありません' 
"   endtry
" endfunction

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

command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor
