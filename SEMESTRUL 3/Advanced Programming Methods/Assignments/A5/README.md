
# ToyLanguage: Assignment A5

This project enhances the ToyLanguage interpreter by introducing support for concurrent programming. Below are the detailed modifications and features added to the project as part of Assignment A5.

## Repository
1. **List of Program States**:  
   - The repository manages a list of `PrgState` objects, each representing a thread. 
   - Initially, only one program (the main program) is introduced, and additional `PrgState`s are generated through `fork` statements.

2. **New Methods in Repository Interface**:  
   - `List<PrgState> getPrgList()` returns the list of program states.  
   - `void setPrgList(List<PrgState>)` replaces the current list of program states.  
   - The method `getCrtPrg()` has been removed.

3. **Updated Logging**:  
   - `void logPrgStateExec(PrgState)` logs the state of the provided `PrgState` into a text file.

## PrgState Class
4. **Completion Check**:  
   - Added `Boolean isNotCompleted()` to check if the execution stack is non-empty.

5. **Moved `oneStep` Method**:  
   - The `oneStep` method was moved from the Controller to the `PrgState` class and updated to:  
     ```java
     PrgState oneStep() throws MyException {
         if (exeStack.isEmpty()) throw new MyException("prgstate stack is empty");
         IStmt crtStmt = exeStack.pop();
         return crtStmt.execute(this);
     }
     ```

6. **Unique Program ID**:  
   - Added an `id` field to `PrgState` for identifying threads.  
   - Managed using a static synchronized method.

## IStmt Interface and `forkStmt` Class
7. **Fork Statement**:  
   - Added the `forkStmt` class to create a new thread for executing statements.  
   - The `execute` method creates a new `PrgState` with the following:  
     - A cloned `SymTable`.  
     - Shared `Heap`, `FileTable`, and `Out`.  
     - A unique `id`.  

8. **SymTable Cloning**:  
   - The new thread has an independent `SymTable` while sharing other resources with the parent.

## Controller Class
9. **Filter Completed Programs**:  
   - Added `List<PrgState> removeCompletedPrg(List<PrgState>)` to filter out completed programs:  
     ```java
     return inPrgList.stream()
         .filter(p -> p.isNotCompleted())
         .collect(Collectors.toList());
     ```

10. **Executor Service**:  
    - Introduced an `ExecutorService` to manage concurrent execution.

11. **One Step for All Programs**:  
    - Defined `void oneStepForAllPrg(List<PrgState>)` to execute one step for all threads:  
      ```java
      List<Callable<PrgState>> callList = prgList.stream()
          .map((PrgState p) -> (Callable<PrgState>)(() -> { return p.oneStep(); }))
          .collect(Collectors.toList());
      List<PrgState> newPrgList = executor.invokeAll(callList).stream()
          .map(future -> { try { return future.get(); } catch(...) { ... } })
          .filter(p -> p != null)
          .collect(Collectors.toList());
      prgList.addAll(newPrgList);
      ```

12. **Updated All Steps**:  
    - Replaced `allStep()` with a new implementation using multi-threading:  
      ```java
      void allStep() {
          executor = Executors.newFixedThreadPool(2);
          List<PrgState> prgList = removeCompletedPrg(repo.getPrgList());
          while (prgList.size() > 0) {
              oneStepForAllPrg(prgList);
              prgList = removeCompletedPrg(repo.getPrgList());
          }
          executor.shutdownNow();
          repo.setPrgList(prgList);
      }
      ```

## Garbage Collector
13. **Safe Garbage Collector**:  
    - Modified to consider shared `Heap` across multiple threads and individual `SymTables`. Example usage:  
      ```
      int v; Ref int a; v=10; new(a,22);
      fork(wH(a,30); v=32; print(v); print(rH(a)));
      print(v); print(rH(a));
      ```

14. **Final State Example**:  
    - At the end of the example:  
      ```
      Id=1
      SymTable_1={v->10, a->(1,int)}
      Id=10
      SymTable_10={v->32, a->(1,int)}
      Heap={1->30}
      Out={10,30,32,30}
      ```
