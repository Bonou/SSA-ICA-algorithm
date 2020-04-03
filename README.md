# SSA-ICA-algorithm
This is a demo of SSA-ICA algorithm.
## Notations
1. The main program is "main_SSA_ICA.m".
2. Calling relationship：
    - main_SSA_ICA.m
        - SSA_ICA.m
            - A01_Fast_ICA.m
            - A02_diag_average.m

    *main_SSA_ICA.m* only generates test data and results visualization, the algorithm used is  all implemented in *SSA_ICA.m*.
3. How to call *SSA_ICA.m* as a sub-function: *Sest = SSA_ICA(Yobs,Ns,M)*
    Parameter | Description |  Type  
    -|-|-
    Yobs | Observed single-channel signal, a row vector. | double |
    Ns   | How many independent source signals are mixed into Yobs. | int |
    M    | Decomposition coefficient, indicates the length of the decomposition, which must not exceed half of Yobs. | int |
    Sest | The output estimation matrix, each row of which is an estimated signal. | double |
4. Need to manual group since grouping process have not been complished. Using classical SSA, the grouping step can be performed based on the magnitude of eigenvalues of the covariance matrix C.
![1](/figures/1.gif)
5. The decomposition coefficient M should be appropriately large, but not more than half the signal length.

## Demonstration
> **Two independent signals:**
![2](/figures/1.jpg)

> **Obderved signal in single channel (by random mix matrix):**
![3](/figures/2.jpg)

> **Estimated results:**
![4](/figures/3.jpg)

## Reference
[1]  A. K. Maddirala and R. A. Shaik, “Separation of sources from single-channel   eeg   signals   using   independent   component   analysis,”IEEETransactions  on  Instrumentation  and  Measurement,  vol.  67,  no.  2,  pp.382–393, 2018.