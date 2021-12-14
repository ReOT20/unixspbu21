# /bin/bash

file="/etc/group"
group=

if [ "$1" == -f ]
then
	shift
	file=$1
	shift
fi

group=$1
shift

if [ "$1" == -f ]
then
	shift
	file=$1
	shift
fi

if [ -z $group ]
then
	echo  "Не указана группа" >&2
	exit 2
fi

if  ! [ -f "$file" ]
then
	echo  "Не найден файл" >&2
	exit 2
fi
users=`grep "$group": "$file"`
users="${users#*:*:*:}"
current="${users%,*}"
users="${users#*,}"
echo  "$current"
while ! [ "$users" == "$current" ]
do
	current="${users%,*}"
	users="${users#*,}"
	echo "$current"
done
exit 0
