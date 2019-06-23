# bars83_infra
bars83 Infra repository
1) Remote internal server SSH in one command
ssh -A -t user@35.209.46.30 ssh someinternalhost
2) Create alias for command "ssh someinternalhost"
cat ~/.ssh/config
	Host someinternalhost
	ProxyCommand ssh -A user@35.209.46.30 -W %h:%p
bastion_IP = 35.209.46.30
someinternalhost_IP = 10.128.0.5

testapp_IP = 35.222.171.118
testapp_port = 9292
