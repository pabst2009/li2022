#!/usr/bin/sh

# https://github.com/iarai/NeurIPS2022-traffic4cast

ANACONDA=/ihdd/anaconda3
LI2022=/home/ubuntu/li2022
HOME=/ihdd/ubuntu
DATA=$HOME/t4c22data
PATH=$ANACONDA/bin:.:$PATH
echo $PATH

if true; then
#if false; then
  conda env update -f environment.yaml
  cd $HOME
  mkdir $DATA
  cd $DATA
  wget http://bigtmp.mathema-tech.com/data/MELBOURNE_2022.zip
  wget http://bigtmp.mathema-tech.com/data/T4C_INPUTS_2022.zip
  wget http://bigtmp.mathema-tech.com/data/T4C_INPUTS_ETA_2022.zip
  unzip MELBOURNE_2022.zip
  unzip T4C_INPUTS_2022.zip
  unzip T4C_INPUTS_ETA_2022.zip
  rm MELBOURNE_2022.zip
  rm T4C_INPUTS_2022.zip
  rm T4C_INPUTS_ETA_2022.zip
  cd ..
fi


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$($ANACONDA'/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$ANACONDA/etc/profile.d/conda.sh" ]; then
        . "$ANACONDA/etc/profile.d/conda.sh"
    else
        export PATH="$ANACONDA/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

#conda info --envs
conda activate t4c22
CUDA="cu122"
#CUDA="cu113"

cd $LI2022

if true; then
#if false; then
  #python -m pip install -r install-extras-torch-geometric.txt -f https://data.pyg.org/whl/torch-1.11.0+${CUDA}.html
  python t4c22/misc/check_torch_geometric_setup.py

  echo prepare1
  date
  #export -p  | grep PYTHON
  export PYTHONPATH="."
  python t4c22/prepare_training_data_cc.py -d $DATA > t4c22/tmp1.txt 2>&1
  echo prepare2
  date
  python t4c22/prepare_training_data_eta.py -d $DATA > t4c22/tmp2.txt 2>&1
  echo prepare3
  date
  python t4c22/prepare_training_check_labels.py -d $DATA > t4c22/tmp3.txt 2>&1
  echo prepareend
  date
fi

#cd data
#jupyter execute data_preprocess.ipynb

if true; then
#if false; then
  # screen run.sh
  echo cluster
  date
  ip2p.sh model/cluster.ipynb > model/cluster.py
  cd model
  rm tmp.txt
  python -u cluster.py > tmp.txt 2>&1
  echo clusterdone
  date
  cd ..
fi

#if false; then
if true; then
  echo chkdata
  date
  python -u tool/chkdata.py $DATA/train/melbourne/cluster_input/counters_2020-06-02.parquet
  echo chkdataend
  date
fi

#if false; then
if true; then
  echo model
  cd model
  rm tmp1.txt
  #python -u GNN_model_train.py
  echo train
  date
  python -u GNN_model_train.py > tmp1.txt 2>&1
  echo test
  date
  #python -u GNN_model_test.py >> tmp1.txt 2>&1
  #python -u submission_cc.py >> tmp1.txt 2>&1 
  #python -u submission_eta.py >> tmp1.txt 2>&1 
  echo done >> tmp1.txt
  cd ..
  exit
fi

jupyter notebook --port 8080
