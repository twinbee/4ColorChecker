( load 'property.lsp )

; the list of colors

( setq color '(red blue green yellow orange cyan magenta ) )

; the map data sturcture

( setq the_map '((A C F E)(B C)(C A B D E F)(D E H I)(E A D I J K)
                 (F A C G H O)(G F O P Q)(H C D F I K O M N)(I D E H J K)
                 (J E I K)(K E H I J M L)(L K M P)(M H K L N P)(N H O M P)
                 (O F G H N P Q)(P G O N M L Q)(Q F G P L) )
)

; insert into a list based on length

( defun length_insert (e l) 
    ( cond
        ( ( null l) ( cons e l ) )
        ( ( > ( length ( car l ) ) ( length e ) ) ( cons e l ) )
        ( t ( cons ( car l ) ( length_insert e ( cdr l ) ) ) )
    )
)


; insert a list into a list of list soriting in assending order

( defun length_sort (l)
    ( cond
        ( ( null l ) l)
        ( t ( length_insert ( car l ) ( length_sort ( cdr l ) ) ) )
    )
)


; get the list of colors avaliable for one element

( defun get_color_list ( element_list color_list )
    ( cond
        ( ( null element_list ) color_list )
        ( t ( remove ( get (car element_list) 'color ) ( get_color_list ( cdr element_list ) color_list) ) )
    )
)

; pick a color for a single element

( defun do_element (l) 
    ( putprop ( car l ) 'color ( car ( get_color_list ( cdr l ) color ) ) )
)

; print an element and its color

( defun print_element (l)
    ( print ( cons ( car l) ( cons ( get ( car l ) 'color) () ) ) )
)

; apply a command to each element in a list return the new list

( defun for_each (l f )
    ( mapcar f l )
)

; this function retrieves a list of colors used

( defun get_used_colors ( l )
    ( cond 
        ( ( null l ) () )
        ( t ( cons ( cadar l ) ( get_used_colors ( cdr l ) ) ) )
    )
)


; choose a color of each element 
; the print the element color pairs

( defun map_colors ( a_map )
    ( for_each ( length_sort a_map ) 'do_element )
    ( cons 'colors ( cons 'used ( cons '-(  remove-duplicates ( get_used_colors ( for_each  a_map
    'print_element ) ) ) ) ) )
)    

; remove one list form a second not used

( defun remove_list (l1 l2) 
    ( cond
        ( (null l1) l2 )
        ( t ( remove_list ( cdr l1 ) ( remove ( car l1 ) l2 ) ) )
    )
 )

