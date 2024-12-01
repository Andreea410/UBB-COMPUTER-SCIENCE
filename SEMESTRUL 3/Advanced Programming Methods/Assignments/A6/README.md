
# ToyLanguage Interpreter with Type Checker

This repository extends the ToyLanguage Interpreter from Assignment A5 by implementing a **Type Checker** as outlined in Assignment A6. The Type Checker ensures that ToyLanguage programs are type-safe before execution, using the rules discussed in Lecture 8.

---

## Features

### 1. **Type Checker Implementation**
The Type Checker validates the types of expressions and statements in a ToyLanguage program, ensuring that:
- Expressions follow type rules (e.g., arithmetic operations involve integers).
- Statements are type-safe (e.g., assignments match declared types).

### 2. **Expression Type Checking**
The `Exp` interface now includes a new method:
```java
Type typecheck(MyIDictionary<String, Type> typeEnv) throws MyException;
```
Each expression class implements this method:
- **ValueExp**: Returns the type of the stored value.
- **VarExp**: Looks up the variable's type in the type environment.
- **ArithExp**: Ensures both operands are integers.
- **LogicExp**: Ensures both operands are booleans.
- **RelationalExp**: Ensures operands are of compatible types.
- **RHExp**: Ensures the referenced value is of `RefType` and returns its inner type.

### 3. **Statement Type Checking**
The `IStmt` interface includes the following method:
```java
MyIDictionary<String, Type> typecheck(MyIDictionary<String, Type> typeEnv) throws MyException;
```
Each statement class implements this method:
- **VarDeclStmt**: Adds a new variable with its type to the type environment.
- **AssignStmt**: Checks that the variable's type matches the expression's type.
- **CompStmt**: Type checks both components sequentially.
- **PrintStmt**: Validates the expression to be printed.
- **IfStmt**: Ensures the condition is a boolean and type checks the `then` and `else` branches.
- **NewStmt**: Verifies that the variable's type matches the referenced expression's type.
- **ForkStmt**: Clones the type environment and checks the forked statement.
- **WhileStmt**: Validates the loop condition and body.

### 4. **Execution Guard**
The type checker is called before creating a `PrgState`. A program will only execute if it passes the type-checking phase. Otherwise, an appropriate exception is raised.

---

