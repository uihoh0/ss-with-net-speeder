#!/bin/bash

if [[ -z "$FROM_THIS_MAIL" ]] || [[ -z "$SMTPSERVER" ]] || [[ -z "$TO_THIS_MAIL" ]] || \
   [[ -z "$MAIL_PASSWORD" ]]; then
    echo "SERVER, FROM, TO, RUNS, or JOBS are missing"
    echo "Usage: docker run -h <fqdn> -e SERVER=smtp.example.com -e FROM=me@example.com -e TO=you@example.com -e RUNS=100 -e JOBS=3 <imageId>"
    exit 1
else
    server=$SMTPSERVER
    from=$FROM_THIS_MAIL
    to=$TO_THIS_MAIL
    password=$MAIL_PASSWORD
    #jobs=$JOBS
fi
runs="nohup /usr/local/bin/net_speeder venet0 "ip" >/dev/null 2>&1 & /usr/local/bin/ssserver \"$@\" "
swakscmd="swaks --from $from --to $to --server $server -au $from -ap $password --body iamthe best --h-Subject 1"
#swakscmd="swaks -4 --tls-optional --server $server --from $from --to $to"

seq $swakscmd | $runs :::


