# Fill this vars
#CISCO_USER=anonymous
#CISCO_HOST=vpn.cisco.com
#CISCO_NAME=ciscovpn # name of the secret in MacOS keychain

cisco-save-password() {
echo -n "Type cisco password for $CISCO_USER to store it to keychain: "
read;
security add-generic-password -a "$CISCO_USER" -s "$CISCO_NAME" -w "$REPLY"
}

alias get-pwd="security find-generic-password -a "$CISCO_USER" -s "$CISCO_NAME" -w"
cisco-connect() {
server="vpn.preprod.incountry.com"
login="$CISCO_USER"
password=$(security find-generic-password -a "$CISCO_USER" -s "$CISCO_NAME" -w)
mode=${1:-start}
if [[ ${mode} == "start" ]]; then
echo -n "Enter your TOTP token: "
read;
/opt/cisco/anyconnect/bin/vpn -s connect ${server} <<EOF
1
${login}
${password},$REPLY
y
exit
EOF
elif [[ ${mode} == "stop" ]]; then
    /opt/cisco/anyconnect/bin/vpn disconnect
fi
}
alias cisco-disconnect="/opt/cisco/anyconnect/bin/vpn -s disconnect"
alias cisco-state="/opt/cisco/anyconnect/bin/vpn state"
