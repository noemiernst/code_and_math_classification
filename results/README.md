
# Java Classification Results

code2class: https://github.com/noemiernst/code2class

### code2class
|Data | Iterations | P@1 | R@1| F1@1| P@3 | R@3| F1@3| P@5 | R@5| F1@5| 
--- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- 
|java-med      | 12 | 0.554 | 0.199 | 0.291 |   0.334 | 0.361 | 0.344   |    0.226 | 0.406 | 0.288 |
|java-small    | 20 | 0.464 | 0.167 | 0.244 |   0.222 | 0.241 | 0.23   |    0.148 | 0.269 | 0.19 |


### code2seq

!!! code2seq metrics for prediction of tokens in sequence -> the labels/classes !!!

no evaluation @1/@3/@5...
<img width="742" alt="Bildschirmfoto 2022-01-17 um 10 17 07" src="https://user-images.githubusercontent.com/27736903/149745501-506631e7-3ac7-4190-970e-3ba3d8a158bd.png">

Taken from [code2seq: Generating Sequences from Structured Representations of Code](https://openreview.net/pdf?id=H1gKYo09tX).

# Math Classification Results

- Number of Tags limited to 50 most frequent Tags
- Limited Dataset to 500,000 Formulas picked randomly with a seed (same Formulas for each level of frequent Tags). Train, Test, Val split to 80%, 10%, 10%.
- Formulas from Posts (Questions and Answers) only

Average Tags per formula after removing all formulas without one of the most frequent Tags as well as the non-frequent Tags from each formula:
|Tags|Questions| Avg. Tags/ Question  |
---|---|---
|50 |500,000| 1.580 |

## Multiclass Classification

- Process for code2vec and code2seq: https://gist.github.com/noemiernst/eecefed58b2612e69d3fdd2060c85711
- Process for code2class: https://gist.github.com/noemiernst/e5ef7abee5f781c76bb132c333a0ecce

### Fasttext

of LaTeX formulas

|Method |Tags | Training Time| P@1 | R@1| F1@1| P@3 | R@3| F1@3| P@5 | R@5| F1@5|
--- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ---
|fasttext|50 |24h | 0.381 | 0.242 | 0.296 | 0.243 | 0.464 | 0.319 |    0.18  | 0.573 | 0.274 |

### code2vec
|Method |Tags | Iterations | P@1 | R@1| F1@1| P@3 | R@3| F1@3| P@5 | R@5| F1@5|
--- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- 
|code2vec OPT|50 | 30 | 0.337 | 0.242 | 0.282 | 0.219 | 0.447 | 0.294 |    0.165 | 0.553 | 0.254 |
|code2vec SLT|50 | 30 | 0.348 | 0.251 | 0.292 | 0.227 | 0.463 | 0.305 |    0.170 | 0.568 | 0.262 |

### code2seq

length max 5 without Beam

|Method |Tags | Iterations | P@1 | R@1| F1@1| P@3 | R@3| F1@3| P@5 | R@5| F1@5| 
--- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ---
|code2seq OPT       |50 | 30 | 0.3447 | 0.2467 | 0.2760 |   0.2232 | 0.4574 | 0.2874 |    0.1679 | 0.5609 | 0.2492 |
|code2seq SLT       |50 | 30 | 0.3514 | 0.2517 | 0.2815 |   0.2258 | 0.4632 | 0.2910 |    0.1693 | 0.5664 | 0.2514 |
|mixed_slt_opt      |50 | 30 | 0.3533 | 0.2536 | 0.2833 |   0.2270 | 0.4663 | 0.2926 |    0.1702 | 0.5703 | 0.2527 |
|opt_nodes_only     |50 | 30 | 0.3578 | 0.2569 | 0.2870 |   0.2284 | 0.4699 | 0.2945 |    0.1712 | 0.5737 | 0.2542 |
|opt_nodes_and_edges|50 | 30 | 0.3568 | 0.2565 | 0.2864 |   0.2289 | 0.4708 | 0.2951 |    0.1709 | 0.5729 | 0.2538 |
|slt_nodes_and_edges|50 | 30 | 0.3502 | 0.2519 | 0.2812 |   0.2257 | 0.4645 | 0.2911 |    0.1695 | 0.5682 | 0.2517 |


### code2class

length max 5

|Method |Tags | Iterations | P@1 | R@1| F1@1| P@3 | R@3| F1@3| P@5 | R@5| F1@5| 
--- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ---
|mixed_slt_opt      |50 | 60 | 0.351 | 0.223 | 0.273 |   0.229 | 0.436 | 0.3   |    0.171 | 0.544 | 0.261 |
|opt_nodes_only     |50 | 60 | 0.341 | 0.217 | 0.265 |   0.223 | 0.425 | 0.293 |    0.168 | 0.533 | 0.255 |
|opt_nodes_and_edges|50 | 60 | 0.351 | 0.223 | 0.273 |   0.229 | 0.435 | 0.3   |    0.171 | 0.543 | 0.26  |
|slt_nodes_and_edges|50 | 60 | 0.341 | 0.217 | 0.265 |   0.224 | 0.428 | 0.294 |    0.169 | 0.536 | 0.257 |

![Unknown](https://user-images.githubusercontent.com/27736903/149752363-1e404cdc-a7ff-4d61-93cc-c7aa2be87616.jpg)
