Source_dir=code2seq
suffix=c2s

# for code2vec:
#Source_dir=code2vec    or whatever the location of the source dir is
#suffix=c2v

tag=50
type=slt

DATASET_NAME=${type}${tag}_noFRP_max5
data_dir=classification_data/${type}${tag}_noFRP_max5
TRAIN_DIR=${data_dir}
VAL_DIR=${data_dir}
TEST_DIR=${data_dir}
MAX_DATA_CONTEXTS=1000
MAX_CONTEXTS=200
SUBTOKEN_VOCAB_SIZE=186277
TARGET_VOCAB_SIZE=26347
NUM_THREADS=64
PYTHON=python3
###########################################################

TRAIN_DATA_FILE=${TRAIN_DIR}/train
VAL_DATA_FILE=${VAL_DIR}/validation
TEST_DATA_FILE=${TEST_DIR}/test


mkdir -p classification_data
mkdir -p classification_data/${DATASET_NAME}


TARGET_HISTOGRAM_FILE=classification_data/${DATASET_NAME}/${DATASET_NAME}.histo.tgt.${suffix}
SOURCE_SUBTOKEN_HISTOGRAM=classification_data/${DATASET_NAME}/${DATASET_NAME}.histo.ori.${suffix}
NODE_HISTOGRAM_FILE=classification_data/${DATASET_NAME}/${DATASET_NAME}.histo.node.${suffix}

echo "Creating histograms from the training data"
cat ${TRAIN_DATA_FILE} | cut -d' ' -f1 | tr '|' '\n' | awk '{n[$0]++} END {for (i in n) print i,n[i]}' > ${TARGET_HISTOGRAM_FILE}
cat ${TRAIN_DATA_FILE} | cut -d' ' -f2- | tr ' ' '\n' | cut -d',' -f1,3 | tr ',|' '\n' | awk '{n[$0]++} END {for (i in n) print i,n[i]}' > ${SOURCE_SUBTOKEN_HISTOGRAM}
cat ${TRAIN_DATA_FILE} | cut -d' ' -f2- | tr ' ' '\n' | cut -d',' -f2 | tr '|' '\n' | awk '{n[$0]++} END {for (i in n) print i,n[i]}' > ${NODE_HISTOGRAM_FILE}

${PYTHON} ${Source_dir}/preprocess.py --train_data ${TRAIN_DATA_FILE} --test_data ${TEST_DATA_FILE} --val_data ${VAL_DATA_FILE} \
  --max_contexts ${MAX_CONTEXTS} --max_data_contexts ${MAX_DATA_CONTEXTS} --subtoken_vocab_size ${SUBTOKEN_VOCAB_SIZE} \
  --target_vocab_size ${TARGET_VOCAB_SIZE} --subtoken_histogram ${SOURCE_SUBTOKEN_HISTOGRAM} \
  --node_histogram ${NODE_HISTOGRAM_FILE} --target_histogram ${TARGET_HISTOGRAM_FILE} --output_name classification_data/${DATASET_NAME}/${DATASET_NAME}