( defun putprop ( the_symbol the_property value )
    ( setf ( get the_symbol the_property ) value )
)
