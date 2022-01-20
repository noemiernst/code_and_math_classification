# Formula Classification with code2seq and code2vec: 

With [code2seq](https://github.com/tech-srl/code2seq) and [code2vec](https://github.com/tech-srl/code2vec)

1. Build database with [StackExchangeMathDataset](https://github.com/noemiernst/StackExchangeMathDataset) `main.py` and parse formulas to their SLT and OPT representations with `parse_formulas.py` (See `script step_1_parse_formulas.sh`).
2. Write training files from Database with [StackExchangeMathDataset](https://github.com/noemiernst/StackExchangeMathDataset) `/classification_training_data/code2seq_preprocess_top_tags_noFRP` (See script `step_2_create.sh`) 
and preprocess with [code2seq](https://github.com/tech-srl/code2seq)/[code2vec](https://github.com/tech-srl/code2vec) (See script `step_2_format.sh`). 

3. 
    - Use [code2seq](https://github.com/tech-srl/code2seq) or [code2vec](https://github.com/tech-srl/code2vec) for training. (See script `step_3_train.sh`)
    - Use [code2class](https://github.com/noemiernst/code2class) for training. With another preprocessing step (See [code2class](https://github.com/noemiernst/code2class)/preprocess.sh) to create the specific dictionary.
      (More [here](../code2class_experiments/))
      
## Results

Results of my Experiments can be found [here](../results/)
