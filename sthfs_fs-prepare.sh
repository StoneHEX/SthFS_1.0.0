#!/bin/bash

echo "#### Creating Stonehex fs ####"
CURRENT=`pwd`
ROOTFS_PATH=$CURRENT/output/target
REVENTON_PKG=SthRevVar_i.mx8m_1.0.0
STHFS_PKG=SthFS_1.0.0
DTB=imx8mm-var-som-symphony.dtb
OVERLAY_PATH=${BR2_DL_DIR}/${STHFS_PKG}/overlay

if [ ! -d ${BR2_DL_DIR}/${REVENTON_PKG} ]; then
        echo "**** ${REVENTON_PKG} cloning   ****"
        pushd ${BR2_DL_DIR} > /dev/null 2>&1
        git clone https://github.com/StoneHEX/${REVENTON_PKG}.git
        popd > /dev/null 2>&1
else
        echo "**** ${REVENTON_PKG} present,updating  ****"
        pushd ${BR2_DL_DIR}/${REVENTON_PKG} > /dev/null 2>&1
        git pull
        popd > /dev/null 2>&1
fi

if [ ! -d ${BR2_DL_DIR}/${STHFS_PKG} ]; then
        echo "**** ${STHFS_PKG} cloning   ****"
        pushd ${BR2_DL_DIR} > /dev/null 2>&1
        git clone https://github.com/StoneHEX/${STHFS_PKG}.git
        popd > /dev/null 2>&1
else
        echo "**** ${STHFS_PKG} present,updating  ****"
        pushd ${BR2_DL_DIR}/${STHFS_PKG} > /dev/null 2>&1
        git pull
        popd > /dev/null 2>&1
fi
rm -rf output/build/${REVENTON_PKG} output/build/${STHFS_PKG}
cp -a ${BR2_DL_DIR}/${REVENTON_PKG} output/build/.
cp -a ${BR2_DL_DIR}/${STHFS_PKG} output/build/.

cp -a ${OVERLAY_PATH}/* ${ROOTFS_PATH}
IP=`hostname -I | awk '{print $1}'`
echo "REFERENCE_SERVER=${IP}" > ${ROOTFS_PATH}/etc/sysconfig/system_vars
echo "BOOT_DEVICE=mmcblk1p1" >> ${ROOTFS_PATH}/etc/sysconfig/system_vars
echo "KERNEL=Image" >> ${ROOTFS_PATH}/etc/sysconfig/system_vars
echo "DTB=${DTB}" >> ${ROOTFS_PATH}/etc/sysconfig/system_vars
echo "BOOTSCRIPT=boot.scr" >> ${ROOTFS_PATH}/etc/sysconfig/system_vars
echo "FS=uInitrd" >> ${ROOTFS_PATH}/etc/sysconfig/system_vars

echo "#### Stonehex fs done ####"

