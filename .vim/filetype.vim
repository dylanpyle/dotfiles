if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  au! BufNewFile,BufRead *.ejs setf html
  au! BufNewFile,BufRead *.jsx setf javascript
augroup END
