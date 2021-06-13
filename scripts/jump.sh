#!/bin/bash
SshConfig=~/.ssh/config

case $1 in
    --add-jump)
        JumpName=$2
        JumpHostname=$3
        Username=$4
        IdentityFile=$5
    ;;
    --add-server)
        ServerName=$2
        ServerHostname=$3
        Username=$4
        IdentityFile=$5
        JumpName=$6
    ;;
    --get-server)
        JumpName=$2
    ;;
    --delete-jump)
        JumpName=$2
    ;;
    --delete-server)
        ServerName=$2
    ;;
esac

help()
{
    cat <<- EOF
    Desc: jump-tool is used for managing ssh config.
    Usage:
        jump [-h or --help]
           [--add-jump JumpName JumpHostname Username IdentityFile]
           [--add-server ServerName ServerHostname Username IdentityFile JumpName]
           [--get-jump]
           [--get-server JumpName]
           [--delete-jump JumpName]
           [--delete-server ServerName]

    Example:
        jump -h
        jump --add-jump jump-ore 10.1.4.26 chenyi.cai ~/.ssh/id_rsa
        jump --add-server ansible_02 10.2.5.8 chenyi.cai ~/.ssh/id_rsa jump-ore
        jump --get-jump
        jump --get-server jump-ore
        jump --delete-jump jump-ore
        jump --delete-server ansible_02
EOF
}

JumpTemplate=`cat <<- EOF
#JumpName: $2
\nHost $2
\n\tHostname $3
\n\tUser $4
\n\tIdentityFile $5\n
EOF
`

ServerTemplate=`cat <<- EOF
#ServerName: $2
\nHost $2
\n\tHostname $3
\n\tUser $4
\n\tIdentityFile $5
\n\tProxyCommand ssh -W %h:%p $6\n
EOF
`

case $1 in
    -h|--help)
        help
    ;;
    --add-jump)
        echo ${JumpTemplate} >> ${SshConfig}
    ;;
    --add-server)
        echo ${ServerTemplate} >> ${SshConfig}
    ;;
    --get-jump)
        grep "^#JumpName" ~/.ssh/config | awk -F " " '{print $2}'
    ;;
    --get-server)
        grep "${JumpName}$" -B 5 ~/.ssh/config | head -n 1 | awk -F " " '{print $2}'
    ;;
    --delete-jump)
        sed -i "" "/#JumpName: ${JumpName}/,+5d" ~/.ssh/config 
    ;;
    --delete-server)
        sed -i "" "/#ServerName: ${ServerName}/,+6d" ~/.ssh/config 
    ;;
    *)
        help
    ;;
esac

