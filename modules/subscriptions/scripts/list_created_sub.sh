echo '{"sub": "sub"}' > /tmp/sublist.json
sed -i '$s/}/,\n'\"$1\"':'\"$2\"'}/' /tmp/sublist.json