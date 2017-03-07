#!/bin/bash
if [[ -z "$TOKEN" ]] || [[ -z "$SECRET" ]] || \
   [[ -z "$ENDPOINT"]]; then
   ehco "No config of Arukas.io"
   echo "Not checking the status of cantainers"
   addr="none"
   port="none"
else
   raw="curl -s -u $TOKEN:$SECRET https://app.arukas.io/api/containers -H 'Content-Type: application/vnd.api+json' -H 'Accept: application/vnd.api+json'"
   json=`$raw | jq ".data[]?.attributes | select(.end_point==\"$Endpoint\")
   addr=`echo $json | jq .host | tr -d '""' `
   port=`echo $json | jq .service_port `
fi
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
swakscmd="swaks --server $server -au $from -ap $password --from $from --to $to -tls --h-Subject hi --body Addr:$addr \\n Port:$port "
#swakscmd="swaks -4 --tls-optional --server $server --from $from --to $to"
$swakscmd
exit 2
#seq $swakscmd | $runs

