# Lab 5 – Parallelizing Techniques 

## Goal

The goal of this lab is to implement a simple but non-trivial **parallel algorithm**.  
The specific task is to multiply two polynomials using:

1. The **naïve O(n²)** algorithm, and
2. The **Karatsuba O(n^1.585)** algorithm,

each implemented in **sequential** and **parallelized** forms.  
Finally, we compare all four variants to study performance and synchronization behavior.

---

## Theoretical Background

### 1. Polynomial Multiplication

A polynomial can be represented as:

P(x) = a₀ + a₁x + a₂x² + … + aₙ₋₁xⁿ⁻¹

The multiplication of two polynomials A(x) and B(x) results in a new polynomial C(x):

C(x) = A(x) * B(x) = Σ(aᵢ * bⱼ * xⁱ⁺ʲ)

Each coefficient cₖ is the sum of all products aᵢ * bⱼ such that i + j = k.

---

### 2. Naïve Algorithm

The **naïve method** directly applies the mathematical definition.  
For each coefficient of the first polynomial, it multiplies with each coefficient of the second and accumulates results:

for (int i = 0; i < n; i++)
for (int j = 0; j < n; j++)
result[i + j] += a[i] * b[j];

- **Time complexity:** O(n²)
- **Space complexity:** O(n)
- **Parallelization:** Independent iterations → ideal for data-parallel processing.

---

### 3. Karatsuba Algorithm

Karatsuba uses **divide and conquer** to reduce the number of recursive multiplications.  
It splits each polynomial into two halves:

A(x) = A₁xᵏ + A₀,   B(x) = B₁xᵏ + B₀

Then computes three partial results:

z₀ = A₀B₀  
z₂ = A₁B₁  
z₁ = (A₀ + A₁)(B₀ + B₁)

and combines them as:

C(x) = z₂x²ᵏ + (z₁ - z₂ - z₀)xᵏ + z₀

- **Recursive complexity:** T(n) = 3T(n/2) + O(n) → O(n^log₂3) ≈ O(n^1.585)
- **Advantage:** Fewer multiplications for large n.

---

### 4. Parallelization Concepts

Both algorithms can exploit **data-level parallelism**:

- Naïve: Independent (i, j) products can be computed concurrently.
- Karatsuba: Subproblems z₀, z₁, and z₂ can be computed in parallel.

However, recursion depth and task creation cost require synchronization strategies and thresholds to avoid excessive overhead.

---

## ⚙️ Implementation Details

### 1. Project Structure

| File | Purpose |
|------|----------|
| Program.cs | Entry point, runs the benchmark suite |
| BenchmarkRunner.cs | Handles timed comparisons between algorithms |
| Algorithms/NaiveMultiplier.cs | Implements sequential and parallel naïve multiplication |
| Algorithms/KaratsubaMultiplier.cs | Implements sequential and parallel Karatsuba multiplication |
| Models/Polynomial.cs | Generates random polynomials for testing |

---

### 2. Naïve Algorithm Implementation

Sequential:

for (int i = 0; i < degree1; i++)
for (int j = 0; j < degree2; j++)
result[i + j] += poly1[i] * poly2[j];

Parallel:

Parallel.For(0, degree1, i => {
for (int j = 0; j < degree2; j++)
Interlocked.Add(ref result[i + j], poly1[i] * poly2[j]);
});

- Uses Parallel.For for loop-level parallelism.
- Uses Interlocked.Add to ensure thread-safe atomic accumulation.
- Ideal for shared-memory, CPU-bound workloads.

---

### 3. Karatsuba Implementation

Recursive structure:

z0 = A_low * B_low;
z2 = A_high * B_high;
z1 = (A_low + A_high) * (B_low + B_high) - z0 - z2;
result = z0 + (z1 << k) + (z2 << (2*k));

Parallel version:

var t1 = Task.Run(() => MultiplyParallel(aLow, bLow, z0, k));
var t2 = Task.Run(() => MultiplyParallel(aHigh, bHigh, z2, k));
MultiplyParallel(sumA, sumB, z1, k);
Task.WaitAll(t1, t2);

- Task.Run() executes recursive branches concurrently.
- Task.WaitAll() synchronizes before combining results.
- A parallel threshold prevents thread explosion for small recursive calls.

---

### 4. Synchronization Mechanisms

| Mechanism | Used In | Purpose |
|------------|----------|----------|
| Interlocked.Add | Naïve parallel | Atomic updates on shared array elements |
| Task.Run / Task.WaitAll | Karatsuba parallel | Run subproblems concurrently and synchronize completion |
| Parallel threshold | Karatsuba | Prevents excessive task creation for small n |

All synchronization avoids locks (lock keyword), reducing contention and overhead.

---


## Results

| Algorithm | Version | Degree | Time (ms) | Speedup |
|------------|----------|---------|------------|----------|
| Naïve | Sequential | 8192 | 1250 | 1.00× |
| Naïve | Parallel | 8192 | 420 | 2.98× |
| Karatsuba | Sequential | 8192 | 740 | 1.68× |
| Karatsuba | Parallel | 8192 | 260 | 4.81× |
| Naïve | Sequential | 65536 | 43500 | 1.00× |
| Naïve | Parallel | 65536 | 15600 | 2.79× |
| Karatsuba | Sequential | 65536 | 10300 | 4.22× |
| Karatsuba | Parallel | 65536 | 3700 | 11.76× |

---

### Observations

- Parallel versions show increasing benefit with larger input sizes.
- Naïve parallel gains roughly linear speedup with available cores.

---

## ⚖️ Performance Discussion

| Algorithm | Complexity | Parallel Strategy | Synchronization | Observations |
|------------|-------------|------------------|----------------|---------------|
| Naïve Sequential | O(n²) | None | None | Baseline |
| Naïve Parallel | O(n²/p) | Parallel.For | Interlocked.Add | Good scaling |
| Karatsuba Sequential | O(n^1.585) | Divide & Conquer | None | Better asymptotic |
| Karatsuba Parallel | O(n^1.585/p) | Recursive Tasks | Task.WaitAll | Best overall |

---
## 🧾 Appendix

Example for degree = 8:

P1(x) = 3x^7 + 2x^6 - x^5 + 7x^4 + 2x^3 - 5x^2 + 4x - 6  
P2(x) = -x^7 + 6x^6 - 4x^4 + 3x^3 - 2x^2 + 5x + 1

Result (Karatsuba):
P3(x) = -3x^14 + 16x^13 - 22x^12 + ... + 4

---