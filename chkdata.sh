#!/usr/bin/sh

ANACONDA=/ihdd/anaconda3
LI2022=/home/ubuntu/li2022
HOME=/ihdd/ubuntu
DATA=$HOME/t4c22data
DATA=$HOME/mindata
PATH=$ANACONDA/bin:.:$PATH
PREP=true; PY=true # ihdd
#PREP=false; PY=false 
echo $PATH

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
cd tool

python -u chkdata.py /ihdd/ubuntu/t4c22data/road_graph/melbourne/road_graph_nodes.parquet 
#'counter_info num_assigned'
#python -u chkdata.py /ihdd/ubuntu/t4c22data/road_graph/melbourne/road_graph_edges.parquet
#'length_meters counter_distance' 
#'importance lanes tunnel length_meters' 
#'parsed_maxspeed speed_kph highway oneway'
#python -u chkdata.py /ihdd/ubuntu/t4c22data/train/melbourne/input/counters_2020-07-30.parquet; 

#python -u chkdata.py /ihdd/ubuntu/t4c22data/road_graph/melbourne/cell_mapping.parquet 
#python -u chkdata.py /ihdd/ubuntu/t4c22data/road_graph/melbourne/road_graph_supersegments.parquet 

#python -u chkdata.py /ihdd/ubuntu/t4c22data/loop_counter/melbourne/counters_daily_by_node.parquet; 
#python -u chkdata.py /ihdd/ubuntu/t4c22data/train/melbourne/cluster_input/counters_2020-07-30.parquet; 

