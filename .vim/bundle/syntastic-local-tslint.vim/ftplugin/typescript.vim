let s:tslint_path = system('PATH=$(npm bin):$PATH && which tslint')
let b:syntastic_typescript_tslint_exec = substitute(s:tslint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
