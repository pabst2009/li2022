#!/usr/bin/sh

# https://github.com/iarai/NeurIPS2022-traffic4cast

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/share/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/share/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/usr/share/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/usr/share/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

#conda info --envs
conda activate t4c22
CUDA="cu113"

#python -m pip install -r install-extras-torch-geometric.txt -f https://data.pyg.org/whl/torch-1.11.0+${CUDA}.html
#python t4c22/misc/check_torch_geometric_setup.py

#export -p  | grep PYTHON
export PYTHONPATH="."
#python t4c22/prepare_training_data_cc.py -d ../t4c22/data/merged > t4c22/tmp1.txt 2>&1
#python t4c22/prepare_training_data_eta.py -d ../t4c22/data/merged > t4c22/tmp2.txt 2>&1
#python t4c22/prepare_training_check_labels.py -d ../t4c22/data/merged > t4c22/tmp3.txt 2>&1

#cd data
#jupyter execute data_preprocess.ipynb


if false; then
#if true; then
  python -u tool/chkdata.py ../t4c22/data/merged/train/melbourne/cluster_input/counters_2020-06-02.parquet
  exit
fi

#if true; then
if false; then
  # screen run.sh
  ip2p.sh model/cluster.ipynb > model/cluster.py
  cd model
  rm tmp.txt
  python -u cluster.py > tmp.txt 2>&1
  echo done >> tmp.txt
  exit
fi

#if false; then
if true; then
  cd model
  rm tmp1.txt
  python -u GNN_model_train.py
  #python -u GNN_model_train.py > tmp1.txt 2>&1
  #python -u GNN_model_test.py >> tmp1.txt 2>&1
  #python -u submission_cc.py >> tmp1.txt 2>&1 
  #python -u submission_eta.py >> tmp1.txt 2>&1 
  echo done >> tmp1.txt
  exit
fi

jupyter notebook --port 8080
