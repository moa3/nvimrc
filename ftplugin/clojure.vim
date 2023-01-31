if expand('%:p') =~# '^/home/moa3/dev/praditus/otus/'
    let b:ale_linters = ['clj-kondo']
    let b:ale_clojure_clj_kondo_use_global = 1
    " This is the path to the script above.
    " let b:ale_clojure_clj_kondo_executable = '/home/moa3/dev/praditus/otus/script/clj-lint'
    " /data matches the path in Docker.
    let b:ale_filename_mappings = {
    \ 'clj-kondo': [
    \   ['/home/moa3/dev/praditus/otus', '/otus'],
    \ ],
    \}
endif

