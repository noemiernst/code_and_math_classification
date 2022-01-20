# Classification with code2class: 
## Process For Formulas

With [code2seq](https://github.com/tech-srl/code2seq) and [code2class](https://github.com/noemiernst/code2class)

1. Build database with [StackExchangeMathDataset](https://github.com/noemiernst/StackExchangeMathDataset) `main.py` and parse formulas to their SLT and OPT representations with `parse_formulas.py` (See `script step_1_parse_formulas.sh`).
2. Write training files from Database with [StackExchangeMathDataset](https://github.com/noemiernst/StackExchangeMathDataset) `/classification_training_data/path_options/c2s_preprocess_top_tags.py` 
and preprocess with [code2seq](https://github.com/tech-srl/code2seq). 
(See script `step_2_preprocess.sh`)
3. 
    - Use [code2seq](https://github.com/tech-srl/code2seq) or [code2vec](https://github.com/tech-srl/code2vec) for training.
      (More [here](https://gist.github.com/noemiernst/eecefed58b2612e69d3fdd2060c85711))
    - Use [code2class](https://github.com/noemiernst/code2class) for training. With another preprocessing step (See [code2class](https://github.com/noemiernst/code2class)/preprocess.sh) to create the specific dictionary.

## Parameters Used in Math Classification:

### Data:
- Number of Formulas: 500.000
- Max Path Length: 5
- Minimum Formula Length: 3 LaTeX Tokens
- Maximum Length: 100 LaTeX Tokens
- Number of Tags: top-50 Tags
- Maximum Contexts per Example: 200

### Training:
- Embedding Dim: 128
- Hidden Dim (of LSTM): 128
- Dropout Rate: 0.25
- Batch Size: 64
- Chunks: 10
- Max Length = Max Contexts per Example: 200
- Max Path Length: 5
- Number of Epochs: 60

(See file `hyperparameters_math_c2c.py` below for hyperparameters in code2class classification.)


## Parameters Used in Java Classification:

### Data:

Use Preprocessed Java Data from [code2seq](https://github.com/tech-srl/code2seq) and preprocess for [code2class](https://github.com/noemiernst/code2class).

### Training:
- Embedding Dim: 128
- Hidden Dim (of LSTM): 128
- Dropout Rate: 0.25
- Batch Size: 64
- Chunks: 10
- Max Length = Max Contexts per Example: 200
- Max Path Length: 8
- Number of Epochs: 20

(See file `hyperparameters_java_c2c.py` below for hyperparameters in code2class classification.)

## Results

Results of my Experiments can be found [here](https://gist.github.com/noemiernst/f12e312d539e0291abe6e14b82b25f76)
