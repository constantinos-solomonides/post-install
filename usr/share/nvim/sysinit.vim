for conf_file in ['/etc/vim/vimrc.external_defaults', '/etc/vim/vimrc.personal' ]
    if filereadable(conf_file)
      exec printf("source %s", conf_file)
    endif
endfor

