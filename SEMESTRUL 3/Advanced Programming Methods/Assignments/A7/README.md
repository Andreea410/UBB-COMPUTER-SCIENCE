# Interpreter with JavaFX GUI

This project extends the interpreter developed in Assignment A6 by adding a graphical user interface (GUI) implemented with JavaFX. The GUI allows users to interact with and execute programs in a more intuitive manner.

## Features

### Program Selection Window
- A **ListView** displays the list of available programs (`IStmt`) for execution.
- Users can select a program from the list to execute.

### Main Window
The main window provides a detailed view of the interpreter's state during execution:

1. **Number of PrgStates**  
   - A `TextField` displays the current count of `PrgState` instances.

2. **Heap Table**  
   - A `TableView` with two columns:
     - `Address`
     - `Value`

3. **Out List**  
   - A `ListView` showing the output of the executed program.

4. **File Table**  
   - A `ListView` displaying the open files.

5. **PrgState Identifiers**  
   - A `ListView` containing the IDs of all active `PrgState` instances.

6. **Symbol Table**  
   - A `TableView` with two columns:
     - `Variable Name`
     - `Value`
   - Displays the `SymTable` of the `PrgState` selected from the list of identifiers.

7. **Execution Stack**  
   - A `ListView` showing the `ExeStack` of the selected `PrgState`.
   - Items are displayed in order, with the first element representing the top of the stack.

8. **Run One Step Button**  
   - A button that executes one step of all `PrgState` instances (`oneStepForAllPrg`).
   - The button's handler updates all displayed information after each step.
   - A dedicated service wraps the repository and handles changes to the list of `PrgState` instances.

## Setup and Execution

## Usage
1. In the **Program Selection Window**, choose a program to execute.
2. In the **Main Window**:
   - View the current state of the interpreter in real time.
   - Use the "Run One Step" button to execute the program step-by-step.

## Project Structure
- `controller` - Handles user interactions and updates the view.
- `view` - Contains JavaFX components for the GUI.
- `model` - Represents the interpreter's internal state and logic.
- `repository` - Manages the storage of `PrgState` instances.
- `service` - Wraps the repository and notifies the GUI of changes.

