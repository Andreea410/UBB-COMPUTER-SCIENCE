class Undo:
    def __init__(self):
        self._history = []
        self._index = -1

    def undo(self):
        if self._index == -1:
            raise ValueError("No more undos!")
        self._history[self._index].undo()
        self._index -= 1

    def redo(self):
        if self._index == len(self._history)-1:
            raise ValueError("NO more redos!")
        self._index += 1
        self._history[self._index].redo()

    def record(self, operation):
        self._history = self._history[0:self._index+1]
        self._history.append(operation)
        self._index += 1

    def separate_last_op(self):
        last_elem = self._history[self._index]
        if self.normal_operation():
            fun_call_undo, fun_call_redo = last_elem.separate()
            return fun_call_undo, fun_call_redo
        else:
            operations = last_elem.separate()
            o1 = operations[0]
            o2 = operations[1]
            return o1, o2

    def normal_operation(self):
        last_elem = self._history[self._index]
        return isinstance(last_elem,Operation)

    def remove_last_element(self):
        self._history.remove(self._history[self._index])
        self._index -= 1

    def return_last_element(self):
        return self._history[self._index]

    def return_index(self):
        return int(self._index)


class CascadedOperation:
    """
    Represents a cascaded operation(where 1 user operation corresponds to more than 1 program operation)
    """
    def __init__(self, *operations):
        self._operations = operations

    def undo(self):
        for operation in self._operations:
            operation.undo()

    def redo(self):
        for operation in self._operations:
            operation.redo()

    def separate(self):
        sep = []
        for operation in self._operations:
            i = operation.separate()
            sep.append(i)
        return sep



class Operation:
    """
    Undo/Redo a program operation
    """
    def __init__(self, fun_call_undo, fun_call_redo):
        self._fun_call_undo = fun_call_undo
        self._fun_call_redo = fun_call_redo

    def undo(self):
        self._fun_call_undo()

    def redo(self):
        self._fun_call_redo()

    def separate(self):
        return self._fun_call_undo, self._fun_call_redo



class FunctionCall:
    """
    A function call with parameters
    """
    def __init__(self, function_reference,*function_parameters ):
        self._function_ref = function_reference
        self._function_params = function_parameters

    def call(self):
        return self._function_ref(*self._function_params)

    def __call__(self):
        return self.call()

    def function_ref(self):
        return self._function_ref


