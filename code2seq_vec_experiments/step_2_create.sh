Source_dir=StackExchangeMathDataset
pip install -r $Source_dir/requirements.txt --user
pip install libarchive --user
pip install bs4 --user
pip install numpy --user

model=code2seq

# for code2vec:
#model=code2vec

python $Source_dir/classification_training_data/${model}_preprocess_top_tags_noFRP.py --dumps ../math_only --output classification_data/opt50_noFRP_max5/ \
	--database output_mathml/math_only.db --minlength 3 --context 200 --path 5 --top_tags 50 --opt --seed 9987 --num_formulas 500000

python $Source_dir/classification_training_data/${model}_preprocess_top_tags_noFRP.py --dumps ../math_only --output classification_data/slt50_noFRP_max5/ \
	--database output_mathml/math_only.db --minlength 3 --context 200 --path 5 --top_tags 50 --slt --seed 9987 --num_formulas 500000
