#!/bin/bash

#desc:update wen site

#auther:zhaocheng
#date:2018-3-20

WEB_DIR=/gotwo_data/sites/push-service
BACK_DIR=/gotwo_data/sites/push-service/backup/`date +%F_%H-%M`
GIT_DIR=/gotwo_data/probject_code/push-service
#check config
#grep constants $1 && echo "请注意，更新包含配置文件！！！" && exit

#pull code 从git上拉取代码
su - appdeploy -c "cd $GIT_DIR && git checkout master && git pull origin master"

#backup code
echo "begin backup...."
if [ $1 ]; then
    for j in `cat $1`
       do
       if [ ! -d `dirname ${BACK_DIR}/${j}` ]; then
           mkdir -p `dirname ${BACK_DIR}/${j}`
       fi

       cp -vr  $WEB_DIR/$j $BACK_DIR/$j
    done
else
#全量备份
    rsync -a --exclude 'runtime' --exclude 'upload' --exclude 'backend' $WEB_DIR $BACK_DIR
fi

echo "backup end...."

#update code
if [ $1 ]; then
    for i in `cat $1`
        do
         if [ ! -d `dirname ${WEB_DIR}/${i}` ]; then
           mkdir -pv `dirname ${WEB_DIR}/${i}`
        fi

       cp -vr  $GIT_DIR/$i $WEB_DIR/$i
    done

else
        cp -r $GIT_DIR/service/Config/*   $WEB_DIR/service/Config/
        cp -r $GIT_DIR/service/Handler/*  $WEB_DIR/service/Handler/
        cp -r $GIT_DIR/service/Model/*    $WEB_DIR/service/Model/
        cp -r $GIT_DIR/service/RpcClient/* $WEB_DIR/service/RpcClient/
        cp -r $GIT_DIR/service/vendor/*    $WEB_DIR/service/vendor/
        cp -r $GIT_DIR/service/Helper/*    $WEB_DIR/service/Helper/
        cp -r $GIT_DIR/service/Module/*    $WEB_DIR/service/Module/
        cp -r $GIT_DIR/service/sql/*       $WEB_DIR/service/sql/
        cp -r $GIT_DIR/service/Exception/* $WEB_DIR/service/Exception/
        cp -r $GIT_DIR/service/message.php $WEB_DIR/service/message.php
        cp -r $GIT_DIR/service/README.md   $WEB_DIR/service/README.md
        cp -r $GIT_DIR/service/start.php   $WEB_DIR/service/start.php
        cp -r $GIT_DIR/manager/assets/*    $WEB_DIR/manager/assets/
        cp -r $GIT_DIR/manager/commands/*  $WEB_DIR/manager/commands/
        cp -r $GIT_DIR/manager/config/*    $WEB_DIR/manager/config/
        cp -r $GIT_DIR/manager/controllers/* $WEB_DIR/manager/controllers/
        cp -r $GIT_DIR/manager/mail/*      $WEB_DIR/manager/mail/
        cp -r $GIT_DIR/manager/models/*    $WEB_DIR/manager/models/
        cp -r $GIT_DIR/manager/runtime/*   $WEB_DIR/manager/runtime/
        cp -r $GIT_DIR/manager/tests/*     $WEB_DIR/manager/tests/
        cp -r $GIT_DIR/manager/vendor/*    $WEB_DIR/manager/vendor/
        cp -r $GIT_DIR/manager/views/*     $WEB_DIR/manager/views/
        cp -r $GIT_DIR/manager/web/*       $WEB_DIR/manager/web/*
        cp -r $GIT_DIR/manager/codeception.yml $WEB_DIR/manager/codeception.yml
        cp -r $GIT_DIR/manager/composer.json $WEB_DIR/manager/composer.json
        cp -r $GIT_DIR/manager/LICENSE.md $WEB_DIR/manager/LICENSE.md
        cp -r $GIT_DIR/manager/README.md $WEB_DIR/manager/README.md
        cp -r $GIT_DIR/manager/requirements.php $WEB_DIR/manager/requirements.php
        cp -r $GIT_DIR/manager/yii $WEB_DIR/manager/yii
        cp -r $GIT_DIR/manager/yii.bat $WEB_DIR/manager/yii.bat

fi


echo "update success...."
                           
