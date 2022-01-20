Source_dir=StackExchangeMathDataset
pip install -r $Source_dir/requirements.txt --user
pip install libarchive --user
pip install bs4 --user

python3 $Source_dir/main/parse_formulas.py --dumps math_only --database output_mathml/math_only.db --threads 256 \
  -c no --offset 0 --totalformulas 30000 --output output_mathml/data.db

python3 $Source_dir/main/parse_formulas.py --dumps math_only --database output_mathml/math_only.db --threads 256 \
  -c no --offset 30000 --totalformulas 30000 --output output_mathml/data.db

python3 $Source_dir/main/parse_formulas.py --dumps math_only --database output_mathml/math_only.db --threads 256 \
  -c no --offset 60000 --totalformulas 30000 --output output_mathml/data.db

python3 $Source_dir/main/parse_formulas.py --dumps math_only --database output_mathml/math_only.db --threads 256 \
  -c no --offset 90000 --totalformulas 30000 --output output_mathml/data.db

python3 $Source_dir/main/parse_formulas.py --dumps math_only --database output_mathml/math_only.db --threads 256 \
  -c no --offset 120000 --totalformulas 30000 --output output_mathml/data.db

python3 $Source_dir/main/parse_formulas.py --dumps math_only --database output_mathml/math_only.db --threads 256 \
  -c no --offset 150000 --totalformulas 30000 --output output_mathml/data.db

python3 $Source_dir/main/parse_formulas.py --dumps math_only --database output_mathml/math_only.db --threads 256 \
  -c no --offset 180000 --totalformulas 30000 --output output_mathml/data.db

python3 $Source_dir/main/parse_formulas.py --dumps math_only --database output_mathml/math_only.db --threads 256 \
  -c no --offset 210000 --totalformulas 30000 --output output_mathml/data.db

python3 $Source_dir/main/parse_formulas.py --dumps math_only --database output_mathml/math_only.db --threads 256 \
  -c no --offset 240000 --totalformulas 30000 --output output_mathml/data.db

python3 $Source_dir/main/parse_formulas.py --dumps math_only --database output_mathml/math_only.db --threads 256 \
  -c no --offset 270000 --totalformulas 30000 --output output_mathml/data.db

python3 $Source_dir/main/parse_formulas.py --dumps math_only --database output_mathml/math_only.db --threads 256 \
  -c no --offset 300000 --totalformulas 30000 --output output_mathml/data.db