#!/bin/bash

BOT_NAME=""
STRATEGY_NAME=""
CONFIG_FILE_NAME=""
ROOT_PATH="/home/your_name"

NFI_REPO_PATH="${ROOT_PATH}/freqtrade_strategy/NFI/NostalgiaForInfinity"
MY_REPO_PATH="${ROOT_PATH}/freqtrade_strategy/MyRepo/freqtrade_strategy"

# The strategy file path
STRATEGY_PATH="${NFI_REPO_PATH}/${STRATEGY_NAME}"
# NFI Dockerfile path
DK_FILE_PATH="${MY_REPO_PATH}/NFI_Dockerfile/Dockerfile"
# NFI docker-compose.xml file path
DKCP_FILE_PATH="${MY_REPO_PATH}/NFI_Dockerfile/docker-compose.yml"
# The Config file path
CONFIG_FILE_PATH="${MY_REPO_PATH}/config_files/${CONFIG_FILE_NAME}"
# Freqtrade bot path
FT_PATH="${ROOT_PATH}/freqtrade_bots"

# Create the freqtrade folder
mkdir ${FT_PATH}/${BOT_NAME}

# Copy the Dockerfile, docker-compose.xml file
cp ${DK_FILE_PATH} ${FT_PATH}/${BOT_NAME}
cp ${DKCP_FILE_PATH} ${FT_PATH}/${BOT_NAME}

# CD to the ft_bot folder
cd ${FT_PATH}/${BOT_NAME}

# Build the ft_trade images
docker-compose down > /dev/null &&
docker-compose build --pull > /dev/null &&
docker-compose run --rm freqtrade create-userdir --userdir user_data > /dev/null

# Copy the config file
cp ${CONFIG_FILE_PATH} ${FT_PATH}/${BOT_NAME}/user_data
# Copy the strategy file
cp ${STRATEGY_PATH} ${FT_PATH}/${BOT_NAME}/user_data/strategies
