#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

work_dir=$(cd `dirname $0`; pwd)
language_type=3

cd $work_dir

echo -e "Please select the language you need: \n 1.English \n 2.简体中文 \n 3.Türkçe"
read -p "Enter index[1]: " language;
if [ "$language" -eq "1" ]; then
  source ./translate/control-panel_en_US.transhell
elif [ "$language" -eq "2" ]; then
  source ./translate/control-panel_zh_CN.transhell
	language_type=12
elif [ "$language" -eq "3" ]; then
  source ./translate/control-panel_tr_TR.transhell
	language_type="UTF-8"
fi

## Check for updates
echo "${CheckUpdate}"
curl -s -o /dev/null http://159.135.192.192:10010/api/checkUpdate

if [ `command -v jq` ];then
    echo ''
else
    echo "${NeedInstallJq}"
    sudo apt update
    sudo apt install jq -y
fi
if [ `command -v curl` ];then
    echo ''
else
    echo "${NeedInstallCurl}"
    sudo apt update
    sudo apt install curl -y
fi

echo "-------------------------------------------------------------------"
echo "${HelpInfo}"
echo -e " ${SwapSyncMode}\n ${NetworkRestart}\n ${NetworkStop}\n ${ShowLog}\n ${ShowStatus}\n ${MigrateNode}\n ${ClearNode}\n ${LocalData}\n ${Other}"
read -p "Enter index: " helpType;
if [ "$helpType" == "1" ];then
	echo -e " ${NormalMode}\n ${QuickSync}\n"
	read -p "Enter index: " syncType;
	if [ "$syncType" == "1" ];then
	  mv ./prysm/beaconChain/run-normal.sh ./prysm/beaconChain/run-normal.sh_bak
	  wget -c https://pre-alpha-download.opside.network/update/run-normal-new.sh -O ./prysm/beaconChain/run-normal.sh
		mv ./prysm/beaconChain/run.sh ./prysm/beaconChain/run.sh_bak
		cp ./prysm/beaconChain/run-normal.sh ./prysm/beaconChain/run.sh
		chmod +x ./prysm/beaconChain/run.sh
		pkill beacon-chain
    echo "${Wait10Seconds}"
    sleep 10
		./start-beaconChain.sh
	elif [ "$syncType" == "2" ];then
	  mv ./prysm/beaconChain/run-checkpoint.sh ./prysm/beaconChain/run-checkpoint.sh_bak
	  wget -c https://pre-alpha-download.opside.network/update/run-checkpoint-new.sh -O ./prysm/beaconChain/run-checkpoint.sh
		mv ./prysm/beaconChain/run.sh ./prysm/beaconChain/run.sh_bak
		cp ./prysm/beaconChain/run-checkpoint.sh ./prysm/beaconChain/run.sh
		chmod +x ./prysm/beaconChain/run.sh
		pkill beacon-chain
    echo "${Wait10Seconds}"
    sleep 10
		./start-beaconChain.sh
	else
		echo "${NoneSelect}"
	fi
elif [ "$helpType" == "2" ];then
	echo -e " ${RestartAll}\n ${RestartGeth}\n ${RestartBeaconChain}\n ${RestartValidator}\n"
	read -p "Enter index: " restartType;
	if [ "$restartType" == "1" ];then
	  pkill geth
    pkill beacon-chain
    pkill validator
    echo "${Wait10Seconds}"
    sleep 10
		./start-geth.sh
		./start-beaconChain.sh
		./start-validator.sh
	elif [ "$restartType" == "2" ];then
	  pkill geth
    echo "${Wait10Seconds}"
    sleep 10
		./start-geth.sh
	elif [ "$restartType" == "3" ];then
    pkill beacon-chain
    echo "${Wait10Seconds}"
    sleep 10
		./start-beaconChain.sh
	elif [ "$restartType" == "4" ];then
    pkill validator
    echo "${Wait10Seconds}"
    sleep 10
		./start-validator.sh
	else
		echo "${NoneSelect}"
	fi
elif [ "$helpType" == "3" ];then
	echo -e " ${StopAll}\n ${StopGeth}\n ${StopBeaconChain}\n ${StopValidator}\n"
  read -p "Enter index: " stopType;
  if [ "$stopType" == "1" ];then
    pkill geth
    pkill beacon-chain
    pkill validator
    echo "${Wait10Seconds}"
    sleep 10
  elif [ "$stopType" == "2" ];then
    pkill geth
    echo "${Wait10Seconds}"
    sleep 10
  elif [ "$stopType" == "3" ];then
    pkill beacon-chain
    echo "${Wait10Seconds}"
    sleep 10
  elif [ "$stopType" == "4" ];then
    pkill validator
    echo "${Wait10Seconds}"
    sleep 10
  else
    echo "${NoneSelect}"
  fi
elif [ "$helpType" == "4" ];then
	echo -e " ${ShowLogGeth}\n ${ShowLogBeaconChain}\n ${ShowLogValidator}\n"
  read -p "Enter index: " showLogType;
  if [ "$showLogType" == "1" ];then
    ./show-geth-log.sh
  elif [ "$showLogType" == "2" ];then
    ./show-beaconChain-log.sh
  elif [ "$showLogType" == "3" ];then
    ./show-validator-log.sh
  else
    echo "${NoneSelect}"
  fi
elif [ "$helpType" == "5" ];then
	echo -e " ${IsSynced}\n ${ShowPeerCount}\n ${ShowHealthStatus}\n"
  read -p "Enter index: " showStatusType;
  if [ "$showStatusType" == "1" ];then
    localBlockHeight=$(curl -s http://127.0.0.1:8545 -X POST -H "Content-Type: application/json" --data '{"jsonrpc":"2.0","method":"eth_blockNumber","params":[],"id":0}' | jq ".result")
    remoteBlockHeight=$(curl -s https://pre-alpha-us-http-geth.opside.network -X POST -H "Content-Type: application/json" --data '{"jsonrpc":"2.0","method":"eth_blockNumber","params":[],"id":0}' | jq ".result")

    localBlockHeightNum=${localBlockHeight:3:-1}
    remoteBlockHeightNum=${remoteBlockHeight:3:-1}
    ((localBlockHeightNum=16#$localBlockHeightNum));
    ((remoteBlockHeightNum=16#$remoteBlockHeightNum));
    echo "${LocalBlockHeight}$localBlockHeightNum"
    echo "${RemoteBlockHeight}$remoteBlockHeightNum"
    diffBlockHeight=$(expr $remoteBlockHeightNum - $localBlockHeightNum)
    echo "${DiffBlockHeight}$diffBlockHeight"
    if [ $diffBlockHeight -gt 10 ]
    then
       echo "${HeightNotHealth}"
    else
       echo "${HeightHealth}"
    fi
  elif [ "$showStatusType" == "2" ];then
    beaconChainPeerCount=$(curl -s http://127.0.0.1:3500/eth/v1/node/peer_count | jq ".data.connected")
    beaconChainPeerCountNum=${beaconChainPeerCount:1:-1}
    gethPeerCount=$(curl -s http://127.0.0.1:8545 -X POST -H "Content-Type: application/json" --data '{"jsonrpc":"2.0","method":"net_peerCount","params":[],"id":0}' | jq ".result")
    gethPeerCountNum=${gethPeerCount:3:-1}
    ((gethPeerCountNum=16#$gethPeerCountNum));
    echo "beaconChain peer count: $beaconChainPeerCountNum"
    echo "geth peer count: $gethPeerCountNum"
  elif [ "$showStatusType" == "3" ];then
    http_info=$(curl -s http://127.0.0.1:3500/eth/v1/node/health)
    if [ "$http_info" == "" ];then
      echo "${HealthStatus}"
    else
      echo "$http_info"
    fi
  else
    echo "${NoneSelect}"
  fi
elif [ "$helpType" == "6" ];then
	echo "${WaitingForSupport}"
elif [ "$helpType" == "7" ];then
	echo "${ClearConfirm}"
	read -p "${ClearConfirmInfo}: " clearConfirm;
	if [ "$clearConfirm" == "yes" ];then
	  pkill geth
    pkill beacon-chain
    pkill validator
    echo "${Wait10Seconds}"
    sleep 10
	  rm -rf ./geth/data
	  rm -rf ./prysm/beaconChain/data/*
    echo "${ClearContinueInfo}"
	fi
elif [ "$helpType" == "8" ];then
  echo -e " ${LocalDataValidatorPubKey}\n"
  read -p "Enter index: " localDataType;
  if [ "$localDataType" == "1" ];then
    ./prysm/validator/validator accounts list --wallet-dir ./prysm/validator/config/wallet --wallet-password-file ./prysm/validator/config/wallet/wallet_pass.txt
  else
    echo "${NoneSelect}"
  fi
elif [ "$helpType" == "9" ];then
	echo -e " ${ControlPanelUpdate}\n ${GethConfigUpdate}\n"
  read -p "Enter index: " updateType;
  if [ "$updateType" == "1" ];then
    mv ./control-panel.sh ./control-panel.sh_bak
    mv ./translate/control-panel_en_US.transhell ./translate/control-panel_en_US.transhell_bak
    mv ./translate/control-panel_zh_CN.transhell ./translate/control-panel_zh_CN.transhell_bak
    wget -c https://pre-alpha-download.opside.network/update/translate/control-panel_en_US.transhell -O ./translate/control-panel_en_US.transhell
    wget -c https://pre-alpha-download.opside.network/update/translate/control-panel_zh_CN.transhell -O ./translate/control-panel_zh_CN.transhell
    wget -c https://pre-alpha-download.opside.network/update/control-panel-new.sh -O ./control-panel.sh
    echo "${WaitingForRestartControlPanel}"
    chmod +x ./control-panel.sh
    ./control-panel.sh
  elif [ "$updateType" == "2" ];then
    mv ./geth/config/config.toml ./geth/config/config.toml_bak
    wget -c https://pre-alpha-download.opside.network/update/geth-config-new.toml -O ./geth/config/config.toml
    pkill geth
    echo "${WaitingForRestartGeth}"
    sleep 10
    ./start-geth.sh
  else
    echo "${NoneSelect}"
  fi
else
	echo "${NoneSelect}"
fi
