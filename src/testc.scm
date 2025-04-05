(define memories
'(
    (memory DirectPage (address (#x0 . #xff))
        (section registers))

    (memory RAM (address (#x0100 . #x7fff))
        (section stack))
    (block stack (size #x100)) ; machine stack size
 
    (memory ANY (address (#x000400 . #x007fff))
        (section reset switch data_init_table compactcode cfar cnear inear))

    (memory MEMRAM (address (#x002000 . #x007fff))
        (section znear near heap))
    (block heap (size #x1000)) ; heap size

    (base-address _DirectPageStart DirectPage 0)
    (base-address _NearBaseAddress MEMRAM 0)
))