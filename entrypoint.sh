#!/bin/bash
swaks --from ${FROM_THIS_MAIL} --to ${TO_THIS_MAIL} --server ${SMTPSERVER} -au ${FROM_THIS_MAIL} -ap ${MAIL_PASSWORD} --body iamthe best --h-Subject 12345&nohup /usr/local/bin/net_speeder venet0 "ip" >/dev/null 2>&1 &
/usr/local/bin/ssserver "$@" 
