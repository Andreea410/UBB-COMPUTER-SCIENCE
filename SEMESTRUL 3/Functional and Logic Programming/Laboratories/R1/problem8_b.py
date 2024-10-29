#. Substitute in a list, all occurrence of a value e with a value e1.

def substitute_occurences(node,e,e1):
    if node is None:
        return
    if node.e == e:
        node.e = e1
    substitute_occurences(node.urm,e,e1)
