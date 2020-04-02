# SSA-ICA-algorithm
This is a demo of SSA-ICA algorithm.
## Notations
- The main program is "main_SSA_ICA.m".
- Need to manual group since grouping process have not been complished. Using classical SSA, the grouping step can be performed based on the magnitude of eigenvalues of the covariance matrix C.
![1](/figures/1.gif)
- The decomposition coefficient M should be appropriately large, but not more than half the signal length.
## Demonstration
> **Two independent signals:**
![2](/figures/1.jpg)

> **Obderved signal in single channel (by random mix matrix):**
![3](/figures/2.jpg)

> **Estimated results:**
![4](/figures/3.jpg)

## Reference
[1]  A. K. Maddirala and R. A. Shaik, “Separation of sources from single-channel   eeg   signals   using   independent   component   analysis,”IEEETransactions  on  Instrumentation  and  Measurement,  vol.  67,  no.  2,  pp.382–393, 2018.