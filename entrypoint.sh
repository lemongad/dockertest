#!/usr/bin/env bash
UUID=${UUID:-'f0177922-2dcc-4c0f-819c-7b74b7bbbfac'}
VMPATH=${VMPATH:-'vm123456'}
VLPATH=${VLPATH:-'vl123456'}
URL=${URL:-'www.aifure.com'}
paths=/app/web
#pwd=$(echo $UUID|cut -c1-8)
if [[ "${PW}" == "88888888" ]]; then
if [ ! -d "${paths}" ]; then

  mkdir -m 777 ${paths}

fi

# Argo 固定域名隧道的两个参数,这个可以填 Json 内容或 Token 内容，获取方式看 https://github.com/fscarmen2/X-for-Glitch
  if [[ -n "${SPACE_HOST}" ]]; then
  SPACE_HOST=$(echo ${SPACE_HOST} | sed 's@https://@@g')
  SPACE_HOST=${SPACE_HOST}
  elif [[ -n "${DOMAIN}" ]]; then
  SPACE_HOST=${DOMAIN}
  else
  SPACE_HOST="你的域名"
  fi
v4=$(curl -s4m6 api64.ipify.org -k)
v4l=`curl -sm6 --user-agent "${UA_Browser}" http://ip-api.com/json/$v4?lang=en-US -k | cut -f2 -d"," | cut -f4 -d '"'`
#其他默认参数，无需更改
PORT=${PORT:-'7860'}
NEZHA_PORT=${NEZHA_PORT:-'443'}
NEZHA_TLS=${NEZHA_TLS:-'1'}
TLS=${NEZHA_TLS:+'--tls'}
NM1=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 5)
NM2=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 5)
NM3=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 5)
NM4=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 8)
[ -s /app/cff ] && mv -f /app/cff /app/${NM1} && chmod +x /app/${NM1} && echo "${NM3}" >> /app/${NM1}
[ -s /app/nez ] && mv -f /app/nez /app/${NM3} && chmod +x /app/${NM3} && echo "${NM3}" >> /app/${NM3}
[ -s /app/kano ] && mv -f /app/kano /app/${NM2} && chmod +x /app/${NM2} && echo "${NM3}" >> /app/${NM2}
#以上是全部参数设置，下面为程序处理部分
#sed -i "s#\${SPACE_HOST}#${SPACE_HOST}#g" /app/index.html
#sed -i "s#\${v4}#${v4}#g" /app/index.html
#sed -i "s#\${v4l}#${v4l}#g" /app/index.html
#sed -i "s#\${VMPATH}#${VMPATH}#g" /app/jiedian.html
#cp -r /app/jiedian.html ${paths}/jiedian.html 
#mv /app/index.html ${paths}/index.html

if [[ -z "${URL_BOT}" ]]; then
  cat > ${paths}/${NM3}.json << EOF
  
{
        "log": {
                "access": "/dev/null",
                "error": "/dev/null",
                "loglevel": "warning"
        },
        "inbounds": [{
                        "port": 8001,
                        "listen": "0.0.0.0",
                        "protocol": "vmess",
                        "settings": {
                                "clients": [{
                                        "id": "${UUID}",
                                        "alterId": 0
                                }]
                        },
                        "streamSettings": {
                                "network": "ws",
                                "wsSettings": {
                                        "path": "/${VMPATH}"
                                }
                        }
                },
                {
                        "port": 8002,
                        "listen": "0.0.0.0",
                        "protocol": "vless",
                        "settings": {
                                "clients": [{
                                        "id": "${UUID}"
                                }],
                                "decryption": "none"
                        },
                        "streamSettings": {
                                "network": "ws",
                                "wsSettings": {
                                        "path": "/${VLPATH}"
                                }
                        }
                }
        ],
    "dns":{
        "servers":[
            "https+local://8.8.8.8/dns-query"
        ]
    },
    "outbounds":[
        {
            "protocol":"freedom"
        },
        {
            "tag":"WARP",
            "protocol":"wireguard",
            "settings":{
                "secretKey":"cKE7LmCF61IhqqABGhvJ44jWXp8fKymcMAEVAzbDF2k=",
                "address":[
                    "172.16.0.2/32",
                    "fd01:5ca1:ab1e:823e:e094:eb1c:ff87:1fab/128"
                ],
                "peers":[
                    {
                        "publicKey":"bmXOC+F1FxEMF9dyiK2H5/1SUtzH0JuVo51h2wPfgyo=",
                        "endpoint":"162.159.193.10:2408"
                    }
                ]
            }
        }
    ],
    "routing":{
        "domainStrategy":"AsIs",
        "rules":[
            {
                "type":"field",
                "domain":[
                    "domain:openai.com",
                    "domain:ai.com"
                ],
                "outboundTag":"WARP"
            }
        ]
    }
}

EOF

fi

   cat > ${paths}/jiedian.sh << ABC
#!/usr/bin/env bash
  if [[ -n "\${DOMAIN}" ]]; then
  DOMAIN=\${DOMAIN}
  else
  DOMAIN="套CF的域名"
  fi
export_list() {
  VMESS="{ \"v\": \"2\", \"ps\": \"Argo-Vmess\", \"add\": \"cdn.chigua.tk\", \"port\": \"443\", \"id\": \"${UUID}\", \"aid\": \"0\", \"scy\": \"none\", \"net\": \"ws\", \"type\": \"none\", \"host\": \"\${DOMAIN}\", \"path\": \"/${VMPATH}?ed=2048\", \"tls\": \"tls\", \"sni\": \"\${DOMAIN}\", \"alpn\": \"\" }"
    cat > ${paths}/index.html << EOF
<!DOCTYPE html>
<html>
<head>
  <title>节点查看</title>
</head>
<body>
  <h1>Configurations</h1>

  <h2>V2-rayN</h2>
  <pre>
vmess://\$(echo \$VMESS | base64 -w0)
  </pre>
  <pre id="v2rayn-vmess">
vless://${UUID}@cdn.chigua.tk:443?encryption=none&security=tls&sni=\${DOMAIN}&type=ws&host=\${DOMAIN}&path=%2F${VLPATH}%3Fed%3D2048#Argo-Vless
  </pre>

  <h2>小火箭</h2>
  <pre>
vless://${UUID}@cdn.chigua.tk:443?encryption=none&security=tls&type=ws&host=\${DOMAIN}&path=/${VMPATH}?ed=2048&sni=\${DOMAIN}#Argo-Vless
  </pre>
  <pre id="shadowrocket-vmess">
vmess://$(echo "none:${UUID}@cdn.chigua.tk:443" | base64 -w0)?remarks=Argo-Vmess&obfsParam=\${DOMAIN}&path=/${VLPATH}?ed=2048&obfs=websocket&tls=1&peer=\${DOMAIN}&alterId=0
  </pre>

  <h2>Clash</h2>
  <pre>
- {name: Argo-Vless, type: vless, server: cdn.chigua.tk, port: 443, uuid: ${UUID}, tls: true, servername: \${DOMAIN}, skip-cert-verify: false, network: ws, ws-opts: {path: /${VMPATH}?ed=2048, headers: { Host: \${DOMAIN}}}, udp: true}
  </pre>
  <pre>
- {name: Argo-Vmess, type: vmess, server: cdn.chigua.tk, port: 443, uuid: ${UUID}, alterId: 0, cipher: none, tls: true, skip-cert-verify: true, network: ws, ws-opts: {path: /${VLPATH}?ed=2048, headers: {Host: \${DOMAIN}}}, udp: true}
  </pre>

</body>
</html>

EOF

   cat > ${paths}/${UUID}.list << EOF
***********************************************************
                                 节点复制
-----------------------------------------------------------
vless://${UUID}@cdn.chigua.tk:443?encryption=none&security=tls&sni=\${DOMAIN}&type=ws&host=\${DOMAIN}&path=%2F${VLPATH}%3Fed%3D2048#Argo-Vless
-----------------------------------------------------------
vmess://\$(echo \$VMESS | base64 -w0)
----------------------------
***********************************************************
EOF

}

export_list

ABC
chmod +x ${paths}/jiedian.sh

${paths}/jiedian.sh

# ${NM3}

if [[ -n "${NEZHA_SERVER}" && -n "${NEZHA_KEY}" ]]; then
  if [[ -n "${URL_NEZHA}" ]]; then
curl -LJo /tmp/nezha-nez https://${URL_NEZHA}
[ -s /tmp/nezha-nez ] && mv -f /tmp/nezha-nez /app/${NM3}
chmod +x /app/${NM3}
fi
[ -s /app/${NM3} ] && nohup /app/${NM3} -s ${NEZHA_SERVER}:${NEZHA_PORT} -p ${NEZHA_KEY} ${TLS}  >/dev/null 2>&1 &

fi

# ${NM1}
  if [[ -n "${TOK}" ]]; then

TOK=$(echo ${TOK} | sed 's/.*install //g')
  cat > ${paths}/argo.sh << ABC
#!/usr/bin/env bash
TOK=${TOK}
DOMAIN=${DOMAIN}

[[ "\$TOK" =~ TunnelSecret ]] && echo "\$TOK" | sed 's@{@{"@g;s@[,:]@"\0"@g;s@}@"}@g' > ${paths}/tunnel.json && echo -e "tunnel: \$(sed "s@.*TunnelID:\(.*\)}@\1@g" <<< "\$TOK")\ncredentials-file: ${paths}/tunnel.json" > ${paths}/tunnel.yml && nohup /app/${NM1} tunnel --edge-ip-version auto --config ${paths}/tunnel.yml --url http://localhost:${PORT} run >/dev/null 2>&1 &

[[ "\$TOK" =~ ^[A-Z0-9a-z=]{120,250}$ ]] && nohup /app/${NM1} tunnel --edge-ip-version auto run --token ${TOK} >/dev/null 2>&1 &

ABC

chmod +x ${paths}/argo.sh && ${paths}/argo.sh

fi

# ${NM2}
if [[ -n "${URL_BOT}" ]]; then
curl -LJo /tmp/sbot https://${URL_BOT}
[ -s /tmp/sbot ] && mv -f /tmp/sbot /app/${NM2} && chmod +x /app/${NM2}

nohup /app/${NM2} >/dev/null 2>&1 &

else


nohup /app/${NM2} -c ${paths}/${NM3}.json  >/dev/null 2>&1 &


fi

# nginx

sed -i 's#\${UUID}#'"${UUID}}"'#g' /app/nginx.conf
sed -i 's#7860#'"${PORT}"'#g' /app/nginx.conf
sed -i 's#vm123456#'"${VMPATH}"'#g' /app/nginx.conf
sed -i 's#vl123456#'"${VLPATH}"'#g' /app/nginx.conf
sed -i 's#\/app\/web#'"${paths}"'#g' /app/nginx.conf
sed -i 's#\${URL}#'"${URL}"'#g' /app/nginx.conf
cp -r /app/nginx.conf /etc/nginx/nginx.conf

nohup /usr/sbin/nginx -g 'daemon off;' >/dev/null 2>&1 &


# 显示信息
echo "                                      "

echo "***********************************************************"
echo "                           host : ${SPACE_HOST}                     "
echo "                                 "
echo "                           App is running                     "
echo "                                 "
echo "                           IP : $v4, Location： $v4l                     "
echo "***********************************************************"
echo "                                      "
echo "                                      "
cat ${paths}/${UUID}.list
echo "                                      "
echo "                                      "
echo "                                      "
sleep 5
# shouhu
   cat > ${paths}/${NM4} << ABC
#!/usr/bin/env bash

function check_bot(){
count1=\$(ps -ef |grep \$1 |grep -v "grep" |wc -l)
#echo \$count1
 if [ 0 == \$count1 ];then
 echo "检测到bot未运行，请检查变量设置，注意大小写，程序将尝试重新启动"
 
if [[ -n "\${URL_BOT}" ]]; then
nohup /app/${NM2} >/dev/null 2>&1 &
else
nohup /app/${NM2} -c ${paths}/${NM3}.json  >/dev/null 2>&1 &
fi

fi
}
function check_cf(){
count2=\$(ps -ef |grep \$1 |grep -v "grep" |wc -l)
#echo \$count2
 if [ 0 == \$count2 ];then
 echo "检测到cf未运行，请检查变量设置，注意大小写，程序将尝试重新启动"
${paths}/argo.sh

fi
}
function check_nez(){
count3=\$(ps -ef |grep \$1 |grep -v "grep" |wc -l)
#echo \$count3
 if [ 0 == \$count3 ];then
 echo "检测到nez未运行，请检查变量设置，注意大小写，程序将尝试重新启动"
 
nohup /app/${NM3} -s ${NEZHA_SERVER}:${NEZHA_PORT} -p ${NEZHA_KEY} ${TLS}  >/dev/null 2>&1 &

fi
}
function check_ngx(){
count4=\$(ps -ef |grep \$1 |grep -v "grep" |wc -l)
#echo \$count4
 if [ 0 == \$count4 ];then
 echo "检测到nginx未运行，请检查变量设置，注意大小写，程序将尝试重新启动"
 
nohup /usr/sbin/nginx -g 'daemon off;' >/dev/null 2>&1 &

fi
}

while true; do
 sleep 10
 [ -s /app/${NM2} ] && check_bot /app/${NM2}

 sleep 10

 if [[ -n "\${TOK}" ]]; then
 check_cf /app/${NM1} tunnel
 sleep 10
 fi
 if [[ -n "\${NEZHA_SERVER}" && -n "\${NEZHA_KEY}" ]]; then
 [ -s /app/${NM3} ] && check_nez /app/${NM3} -s
 sleep 10
 fi
 check_ngx /usr/sbin/nginx -g
 sleep 30
done

ABC

chmod +x ${paths}/${NM4}

   cat > /app/${NM2}.conf << EOF
[supervisord]
nodaemon=true
logfile=/var/log/supervisord.log
pidfile=/run/supervisord.pid

[program:${NM4}]
command=${paths}/${NM4}
stdout_logfile=/dev/stdout
stdout_logfile_maxbytes=0
redirect_stderr=true
autorestart=true
startretries=0

EOF
supervisord -n -c /app/${NM2}.conf
echo "                                      "
echo "                                      "
fi
