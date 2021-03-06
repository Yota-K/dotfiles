nnoremap <silent><C-n> :CocCommand explorer<CR>

" キーマッピング周りの設定
" MEMO: ディレクトリアイコンにホバーした状態で、sを押すと
" ホバーしたディレクトリを起点にしてファイラーを開き直せる
call coc#config("explorer",{
  \"icon.enableNerdfont":1,
  \"keyMappingMode":"none",
  \"keyMappings.global":{
  \"h": "collapse",
  \"l": ["expandable?", "expand", "open"],
  \"k": "nodePrev",
  \"j": "nodeNext",
  \"o": "open",
  \"i":"open:split",
  \"S":"open:split:plain",
  \"s":"open:vsplit",
  \"t":"open:tab",
  \"d":"delete",
  \"D":"deleteForever",
  \"a":"addFile",
  \"A":"addDirectory",
  \"r":"rename",
  \"q":"quit",
  \"/":"search",
  \"R": "refresh",
  \"yy": "copyFile",
  \"dd": "cutFile",
  \"p": "pasteFile",
  \"G": ["wait", "gotoParent"],
  \},
  \})
