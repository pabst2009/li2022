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
#python t4c22/prepare_training_data_cc.py -d ../t4c22/data/merged >& tmp1.txt
#python t4c22/prepare_training_data_eta.py -d ../t4c22/data/merged >& tmp2.txt
#python t4c22/prepare_training_check_labels.py -d ../t4c22/data/merged >& tmp3.txt

#cd data
#run data_preprocess.ipynb
jupyter notebook --port 8080

