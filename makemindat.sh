#!/bin/sh

HOME=/ihdd/ubuntu
ODATA=$HOME/t4c22data
#ODATA=$HOME/mindataorig
DATA=$HOME/mindata
mkdir $DATA
mkdir $DATA/road_graph
mkdir $DATA/road_graph/melbourne

cp $ODATA/road_graph/melbourne/road_graph_edges.parquet $DATA/road_graph/melbourne/road_graph_edges.parquet
cp $ODATA/road_graph/melbourne/road_graph_nodes.parquet $DATA/road_graph/melbourne/road_graph_nodes.parquet

mkdir $DATA/train
mkdir $DATA/train/melbourne
mkdir $DATA/train/melbourne/input
cp $ODATA/train/melbourne/input/* $DATA/train/melbourne/input

mkdir $DATA/speed_classes
mkdir $DATA/speed_classes/melbourne
cp $ODATA/speed_classes/melbourne/* $DATA/speed_classes/melbourne/

