#!/usr/bin/sh

(cd ${1}; ls | grep -v key | xargs -n1 -I {} sh -c "echo -n {} ' '; openssl x509 -enddate -noout -in {}")
