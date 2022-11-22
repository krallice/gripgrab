 #!/usr/bin/env bash

mkdir -p ./.ignore 

echo ".ignore/" >> .gitignore 
echo "${OPENVPNCONFIG}" > ./.ignore/openvpn.config 

nohup sudo /bin/sh -c " openvpn --log ./.ignore/openvpn.log --config ./.ignore/openvpn.config &" 