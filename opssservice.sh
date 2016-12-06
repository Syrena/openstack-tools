#! /bin/bash


opt=$1
category=$2
service_list="$(cat openstack_service_list_native)"

case $opt in
  status)
           for ser in $service_list; do [[ $ser =~ $category ]] && sudo systemctl status $ser; done
           ;;
  restart)
           for ser in $service_list; do [[ $ser =~ $category ]] && sudo systemctl restart $ser; done
           ;;
  check)
           for ser in $service_list; do 
               [[ $ser =~ $category ]] && { 
                   ok=$(systemctl status $ser | grep "active (running)")
                   echo -e "\n$ser:$ok"
                   [ "x$ok" = "x" ] && echo $ser is not okay 
               }
           done
           ;;
esac

