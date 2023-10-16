#!/usr/bin/sh

# https://github.com/iarai/NeurIPS2022-traffic4cast

ANACONDA=/ihdd/anaconda3
LI2022=/home/ubuntu/li2022
HOME=/ihdd/ubuntu
DATA=$HOME/t4c22data
#DATA=$HOME/mindata
PATH=$ANACONDA/bin:.:$PATH
PREP=true; PY=true # ihdd
PY=false
#PREP=false; PY=false 
echo $PATH

if true ; then
  git pull
  git commit -am "aws"
  git push
fi

# initial & ihdd
#if [ $PY -o $PREP ] ; then
if $PY ; then
  conda env update -f environment.yaml
  cd $HOME
fi

if $PREP; then
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

if false ; then
cd tool
python -u chkgpu.py; exit
fi

#if [ $PY -o $PREP ] ; then
if $PY ; then
#if false ; then
  python -m pip install wandb torch_geometric
fi

if $PREP; then
  # error
  #python -m pip install -r install-extras-torch-geometric.txt -f https://data.pyg.org/whl/torch-1.11.0+${CUDA}.html
  python t4c22/misc/check_torch_geometric_setup.py

  echo prepare1
  date
  #export -p  | grep PYTHON
  export PYTHONPATH="."
  rm t4c22/tmp*.txt
  python t4c22/prepare_training_data_cc.py -d $DATA > t4c22/tmp1.txt 2>&1
  echo prepare2
  date
  #python t4c22/prepare_training_data_eta.py -d $DATA > t4c22/tmp2.txt 2>&1
  #echo prepare3
  #date
  #python t4c22/prepare_training_check_labels.py -d $DATA > t4c22/tmp3.txt 2>&1
  #echo preparedone
  #date

  ip2p.sh data/data_preprocess.ipynb > data/data_preprocess.py
  cd data
  rm tmp.txt
  echo preproc
  date
  python -u data_preprocess.py > tmp.txt 2>&1
  echo preprocdone
  date
  cd ..
fi

exit

if $PREP; then
  # screen run.sh
  echo cluster
  date
  ip2p.sh model/cluster.ipynb > model/cluster.py
  cd model
  rm tmpc.txt
  python -u cluster.py > tmpc.txt 2>&1
  echo clusterdone
  date
  cd ..
fi

if $PREP; then
  echo chkdata
  date
  python -u tool/chkdata.py $DATA/train/melbourne/cluster_input/counters_2020-06-02.parquet
  echo road_edge
  python -u tool/chkdata.py $DATA/road_graph/melbourne/road_graph_edges.parquet 'importance oneway tunnel lanes'
  echo chkdataend
  date
fi

#if false; then
if true; then
  echo model
  cd model
  rm tmptrain.txt tmptest.txt tmpsub.txt
  #date; python -u GNN_model_train.py 1 1 1 5; date; exit
  #date; python -u GNN_model_test.py; date; exit
  echo train
  date
  # epoch=3, runs=1, filt=1(0:none, 1:10days, 2:month, 3:3months), batchsize=1
  python -u GNN_model_train.py 1 1 1 1 # wandb c7d55c35b47f6617be89004f3da57bb17578312b
  #python -u GNN_model_train.py 3 1 1 1 > tmptrain.txt 2>&1 # T4
  #python -u GNN_model_train.py 30 1 0 2 > tmptrain.txt 2>&1 # A10
  echo test
  date
  #python -u GNN_model_test.py >> tmptest.txt 2>&1
  #python -u submission_cc.py > tmpsub.txt 2>&1 
  #python -u submission_eta.py >> tmpsub.txt 2>&1 
  echo done
  cd ..
  #python -u tool/chkdata.py $DATA/submission/ensemble_cc_result/melbourne/labels/cc_labels_test.parquet
  exit
fi

jupyter notebook --port 8080
