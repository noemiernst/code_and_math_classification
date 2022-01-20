Source_dir=StackExchangeMathDataset
pip install -r $Source_dir/requirements.txt --user
pip install libarchive --user
pip install bs4 --user
pip install numpy --user


##########
echo ""
echo "Writing raw training data"

# for writing files with different path representations. Multiclass and with the least and most frequent class
python $Source_dir/classification_training_data/path_options/c2s_preprocess_top_tags.py --dumps math_only --database ../output_mathml/math_only.db \
  --output data_raw --minlength 3 --maxlength 100 --context 200 --path 5 --top_tags 50 --seed 9999 --num_formulas 500000


##########

echo ""
echo "Preprocess training data with c2s Preprocess"

# give files a new name
NAME=math_top50_500k_9999
# raw file name format given out by running the c2s_preprocess_top_tag according to parameters
NAME_RAW=math_top50_9999
DATA_DIR=data_raw/${NAME_RAW}
NEW_DIR=data/${NAME}
MAX_DATA_CONTEXTS=1000
MAX_CONTEXTS=200
SUBTOKEN_VOCAB_SIZE=186277
TARGET_VOCAB_SIZE=26347
NUM_THREADS=64
PYTHON=python3

code2seq_Source_dir=code2seq

mkdir -p data
mkdir -p ${NEW_DIR}

####


echo "Preprocess Mixed SLT and OPT data"

NAME1=mixed_slt_opt
SUBSET1=${DATA_DIR}/${NAME1}
TRAIN_DATA_FILE=${SUBSET1}/train
VAL_DATA_FILE=${SUBSET1}/val
TEST_DATA_FILE=${SUBSET1}/test

mkdir -p ${NEW_DIR}/${NAME1}

TARGET_HISTOGRAM_FILE=${NEW_DIR}/${NAME1}/${NAME1}.histo.tgt.c2s
SOURCE_SUBTOKEN_HISTOGRAM=${NEW_DIR}/${NAME1}/${NAME1}.histo.ori.c2s
NODE_HISTOGRAM_FILE=${NEW_DIR}/${NAME1}/${NAME1}.histo.node.c2s

echo "Creating histograms from the training data 1"
cat ${TRAIN_DATA_FILE} | cut -d' ' -f1 | tr '|' '\n' | awk '{n[$0]++} END {for (i in n) print i,n[i]}' > ${TARGET_HISTOGRAM_FILE}
cat ${TRAIN_DATA_FILE} | cut -d' ' -f2- | tr ' ' '\n' | cut -d',' -f1,3 | tr ',|' '\n' | awk '{n[$0]++} END {for (i in n) print i,n[i]}' > ${SOURCE_SUBTOKEN_HISTOGRAM}
cat ${TRAIN_DATA_FILE} | cut -d' ' -f2- | tr ' ' '\n' | cut -d',' -f2 | tr '|' '\n' | awk '{n[$0]++} END {for (i in n) print i,n[i]}' > ${NODE_HISTOGRAM_FILE}

python $code2seq_Source_dir/preprocess.py --train_data ${TRAIN_DATA_FILE} --test_data ${TEST_DATA_FILE} --val_data ${VAL_DATA_FILE} \
  --max_contexts ${MAX_CONTEXTS} --max_data_contexts ${MAX_DATA_CONTEXTS} --subtoken_vocab_size ${SUBTOKEN_VOCAB_SIZE} \
  --target_vocab_size ${TARGET_VOCAB_SIZE} --subtoken_histogram ${SOURCE_SUBTOKEN_HISTOGRAM} \
  --node_histogram ${NODE_HISTOGRAM_FILE} --target_histogram ${TARGET_HISTOGRAM_FILE} --output_name ${NEW_DIR}/${NAME1}/${NAME1}


####

echo "Preprocess OPT Nodes Only Data"

NAME2=opt_nodes_only
SUBSET2=${DATA_DIR}/${NAME2}
TRAIN_DATA_FILE=${SUBSET2}/train
VAL_DATA_FILE=${SUBSET2}/val
TEST_DATA_FILE=${SUBSET2}/test

mkdir -p ${NEW_DIR}/${NAME2}

TARGET_HISTOGRAM_FILE=${NEW_DIR}/${NAME2}/${NAME2}.histo.tgt.c2s
SOURCE_SUBTOKEN_HISTOGRAM=${NEW_DIR}/${NAME2}/${NAME2}.histo.ori.c2s
NODE_HISTOGRAM_FILE=${NEW_DIR}/${NAME2}/${NAME2}.histo.node.c2s

echo "Creating histograms from the training data 2"
cat ${TRAIN_DATA_FILE} | cut -d' ' -f1 | tr '|' '\n' | awk '{n[$0]++} END {for (i in n) print i,n[i]}' > ${TARGET_HISTOGRAM_FILE}
cat ${TRAIN_DATA_FILE} | cut -d' ' -f2- | tr ' ' '\n' | cut -d',' -f1,3 | tr ',|' '\n' | awk '{n[$0]++} END {for (i in n) print i,n[i]}' > ${SOURCE_SUBTOKEN_HISTOGRAM}
cat ${TRAIN_DATA_FILE} | cut -d' ' -f2- | tr ' ' '\n' | cut -d',' -f2 | tr '|' '\n' | awk '{n[$0]++} END {for (i in n) print i,n[i]}' > ${NODE_HISTOGRAM_FILE}

python $code2seq_Source_dir/preprocess.py --train_data ${TRAIN_DATA_FILE} --test_data ${TEST_DATA_FILE} --val_data ${VAL_DATA_FILE} \
  --max_contexts ${MAX_CONTEXTS} --max_data_contexts ${MAX_DATA_CONTEXTS} --subtoken_vocab_size ${SUBTOKEN_VOCAB_SIZE} \
  --target_vocab_size ${TARGET_VOCAB_SIZE} --subtoken_histogram ${SOURCE_SUBTOKEN_HISTOGRAM} \
  --node_histogram ${NODE_HISTOGRAM_FILE} --target_histogram ${TARGET_HISTOGRAM_FILE} --output_name ${NEW_DIR}/${NAME2}/${NAME2}


####

echo "Preprocess OPT Nodes and Edges Data"

NAME3=opt_nodes_and_edges
SUBSET3=${DATA_DIR}/${NAME3}
TRAIN_DATA_FILE=${SUBSET3}/train
VAL_DATA_FILE=${SUBSET3}/val
TEST_DATA_FILE=${SUBSET3}/test

mkdir -p ${NEW_DIR}/${NAME3}

TARGET_HISTOGRAM_FILE=${NEW_DIR}/${NAME3}/${NAME3}.histo.tgt.c2s
SOURCE_SUBTOKEN_HISTOGRAM=${NEW_DIR}/${NAME3}/${NAME3}.histo.ori.c2s
NODE_HISTOGRAM_FILE=${NEW_DIR}/${NAME3}/${NAME3}.histo.node.c2s

echo "Creating histograms from the training data 3"
cat ${TRAIN_DATA_FILE} | cut -d' ' -f1 | tr '|' '\n' | awk '{n[$0]++} END {for (i in n) print i,n[i]}' > ${TARGET_HISTOGRAM_FILE}
cat ${TRAIN_DATA_FILE} | cut -d' ' -f2- | tr ' ' '\n' | cut -d',' -f1,3 | tr ',|' '\n' | awk '{n[$0]++} END {for (i in n) print i,n[i]}' > ${SOURCE_SUBTOKEN_HISTOGRAM}
cat ${TRAIN_DATA_FILE} | cut -d' ' -f2- | tr ' ' '\n' | cut -d',' -f2 | tr '|' '\n' | awk '{n[$0]++} END {for (i in n) print i,n[i]}' > ${NODE_HISTOGRAM_FILE}

python $code2seq_Source_dir/preprocess.py --train_data ${TRAIN_DATA_FILE} --test_data ${TEST_DATA_FILE} --val_data ${VAL_DATA_FILE} \
  --max_contexts ${MAX_CONTEXTS} --max_data_contexts ${MAX_DATA_CONTEXTS} --subtoken_vocab_size ${SUBTOKEN_VOCAB_SIZE} \
  --target_vocab_size ${TARGET_VOCAB_SIZE} --subtoken_histogram ${SOURCE_SUBTOKEN_HISTOGRAM} \
  --node_histogram ${NODE_HISTOGRAM_FILE} --target_histogram ${TARGET_HISTOGRAM_FILE} --output_name ${NEW_DIR}/${NAME3}/${NAME3}


####

echo "Preprocess SLT Nodes and Edges Data"

NAME4=slt_nodes_and_edges
SUBSET4=${DATA_DIR}/${NAME4}
TRAIN_DATA_FILE=${SUBSET4}/train
VAL_DATA_FILE=${SUBSET4}/val
TEST_DATA_FILE=${SUBSET4}/test

mkdir -p ${NEW_DIR}/${NAME4}

TARGET_HISTOGRAM_FILE=${NEW_DIR}/${NAME4}/${NAME4}.histo.tgt.c2s
SOURCE_SUBTOKEN_HISTOGRAM=${NEW_DIR}/${NAME4}/${NAME4}.histo.ori.c2s
NODE_HISTOGRAM_FILE=${NEW_DIR}/${NAME4}/${NAME4}.histo.node.c2s

echo "Creating histograms from the training data 4"
cat ${TRAIN_DATA_FILE} | cut -d' ' -f1 | tr '|' '\n' | awk '{n[$0]++} END {for (i in n) print i,n[i]}' > ${TARGET_HISTOGRAM_FILE}
cat ${TRAIN_DATA_FILE} | cut -d' ' -f2- | tr ' ' '\n' | cut -d',' -f1,3 | tr ',|' '\n' | awk '{n[$0]++} END {for (i in n) print i,n[i]}' > ${SOURCE_SUBTOKEN_HISTOGRAM}
cat ${TRAIN_DATA_FILE} | cut -d' ' -f2- | tr ' ' '\n' | cut -d',' -f2 | tr '|' '\n' | awk '{n[$0]++} END {for (i in n) print i,n[i]}' > ${NODE_HISTOGRAM_FILE}

python $code2seq_Source_dir/preprocess.py --train_data ${TRAIN_DATA_FILE} --test_data ${TEST_DATA_FILE} --val_data ${VAL_DATA_FILE} \
  --max_contexts ${MAX_CONTEXTS} --max_data_contexts ${MAX_DATA_CONTEXTS} --subtoken_vocab_size ${SUBTOKEN_VOCAB_SIZE} \
  --target_vocab_size ${TARGET_VOCAB_SIZE} --subtoken_histogram ${SOURCE_SUBTOKEN_HISTOGRAM} \
  --node_histogram ${NODE_HISTOGRAM_FILE} --target_histogram ${TARGET_HISTOGRAM_FILE} --output_name ${NEW_DIR}/${NAME4}/${NAME4}
