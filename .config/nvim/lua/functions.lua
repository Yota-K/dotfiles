local nvim_create_user_command = vim.api.nvim_create_user_command

-- 半角スペースを全て削除
nvim_create_user_command('DeleteHalfSpaces', function() 
vim.cmd[[
  execute("%s/ *$//g")
]] end, {})

-- jqをVim上で実行
nvim_create_user_command('JsonFormatter', function() 
vim.cmd[[
  if !executable("jq")
    call s:echo_err("not found jq command.")
  endif

  execute("%!jq '.'")
]] end, {})
