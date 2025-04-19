#!/bin/bash
read CONT_PATH
if grep -qF SYS_ADMIN $CONT_PATH/hostconfig.json; then
        echo 'Warning: SYS_ADMIN cap enabled, container may control host file system'
fi
if grep -qF SYS_PTRACE $CONT_PATH/hostconfig.json; then
        echo 'Warning: SYS_PTRACE cap enabled, container may control host processes'
fi
if grep -qF SYS_MODULE $CONT_PATH/hostconfig.json; then
        echo 'Warning: SYS_MODULE cap enabled, container may control host kernel modules'
fi
if grep -qF DAC_READ_SEARCH $CONT_PATH/hostconfig.json; then
        echo 'Warning: DAC_READ_SEARCH cap enabled, container may read host files'
fi
if grep -qF DAC_OVERRIDE $CONT_PATH/hostconfig.json; then
        echo 'Warning: DAC_OVERRIDE cap enabled, container may change host files'
fi
if grep -qF docker.sock: $CONT_PATH/hostconfig.json; then
        echo 'Warning: docker.sock is mounted, container may create vulnerable containers'
fi
if grep -qF apparmor=unconfined $CONT_PATH/hostconfig.json; then
        echo 'Warning: AppArmor security module disabled, container may cause threat to the host'
fi
        echo 'Users in docker group can create any container, including vulnerable:'
cat /etc/group| grep docker| sed -e "s/:/ /g"| awk '{print $4}'

