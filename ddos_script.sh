#!usr/bin/bash

echo -e "\e[1;31m"
center() {
  termwidth="$(tput cols)"
  padding="$(printf '%0.1s' ={1..500})"
  printf '%.*s %s %.*s\n' 0 "$(((termwidth-2-${#1})/2))" "$padding" "$1" 0 "$(((termwidth-1-${#1})/2))" "$padding"
}
echo -e "\e[1;31m"
center "***"
echo -e "\e[1;32m"
echo "server ip :  $(dig +short myip.opendns.com @resolver1.opendns.com)" | sed  -e :a -e 's/^.\{1,168\}$/ & /;ta'
echo "total no. of client till now - $(awk '{ print }' /var/log/httpd/access_log | sort | wc -l)" | sed  -e :a -e 's/^.\{1,168\}$/ & /;ta'
echo "total no. of client visited today - $(awk '{ print }' /var/log/httpd/access_log | grep $(date +%e/%b/%G) | sort | wc -l)" | sed  -e :a -e 's/^.\{1,168\}$/ & /;ta'
echo -e "\e[1;31m"
center "***"
echo ""
echo -e "\e[1;32m"
echo "Do you want to do the ddos check on webapp" | sed  -e :a -e 's/^.\{1,168\}$/ & /;ta'
echo "(yes/no)" | sed  -e :a -e 's/^.\{1,168\}$/ & /;ta'
read -p "                                                                                   " answer1
echo -e "\e[1;31m"
center "***"
echo ""
while [ True ]
do
echo -e "\e[1;32m"
if [ $answer1 == "yes" ]
then
        echo -e "\e[1;32m"
        echo "These ip's look suspicious as they are outside of range " | sed  -e :a -e 's/^.\{1,168\}$/ & /;ta'
        awk '{print}' /var/log/httpd/access_log | grep $(date +%e/%b/%G) | sort -r | uniq -c | sort -n > /ws1/ip.txt
        awk '{print $2}' /ws1/ip.txt | sort -r | uniq -c | sort -n > /ws1/ip1.txt
        awk '$1 >= 35{print $2}' /ws1/ip1.txt > /ws1/ip2.txt
        cat ip2.txt | sed  -e :a -e 's/^.\{1,168\}$/ & /;ta'
        echo -e "\e[1;31m"
        center "***"
        echo -e "\e[1;32m"
        echo "do you want to block these ip/s" | sed  -e :a -e 's/^.\{1,168\}$/ & /;ta'
        echo "yes/no" | sed  -e :a -e 's/^.\{1,168\}$/ & /;ta'
        read -p "                                                                                   " answer2
        echo -e "\e[1;31m"

        center "***"
        echo ""
        while [ True ]
        do
        if [ $answer2 == "yes" ]
        then
                echo -e "\e[1;32m"
                for i in $(cat ip2.txt)
                do

                        echo blocking  $i | sed  -e :a -e 's/^.\{1,168\}$/ & /;ta'
                        sudo firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='$i' reject" > /dev/null
                        sudo firewall-cmd --reload > /dev/null

                        echo sucessfully blocked $1 | sed  -e :a -e 's/^.\{1,168\}$/ & /;ta'
                done
                echo -e "\e[0m"
                exit
        elif [ $answer2 == "no" ]
        then
                echo "Thank you" | sed  -e :a -e 's/^.\{1,168\}$/ & /;ta'
                echo -e "\e[0m"
                exit
        else
                echo "please select yes/no" | sed  -e :a -e 's/^.\{1,168\}$/ & /;ta'
                echo "do you want to block these ip/s" | sed  -e :a -e 's/^.\{1,168\}$/ & /;ta'
                echo "yes/no" | sed  -e :a -e 's/^.\{1,168\}$/ & /;ta'
                read -p "                                                                                   " answer2
        fi
        done


elif [ $answer1 == "no" ]
then
        echo -e "\e[1;32m"
        echo "Thank you" | sed  -e :a -e 's/^.\{1,168\}$/ & /;ta'
        echo -e "\e[1;31m"
        center "***"
        echo ""
        echo -e "\e[0m"
        exit

else
        echo -e "\e[1;32m"
        echo "please select yes/no" | sed  -e :a -e 's/^.\{1,168\}$/ & /;ta'
        echo "Do you want to do the ddos check on webapp" | sed  -e :a -e 's/^.\{1,168\}$/ & /;ta'
        echo "(yes/no)" | sed  -e :a -e 's/^.\{1,168\}$/ & /;ta'
        read -p "                                                                                   " answer1
        echo -e "\e[1;31m"
        center "***"
        echo ""

fi
done