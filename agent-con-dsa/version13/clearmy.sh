#! /bin/bash


#清除服务器端的文件夹重建
clearway(){
	{
		#echo $1,$2
		echo "清除$1服务器上的残留文档，并创建$2到$[$2+7]的文档"
		#$1，is the server ip
		#$2，is the start of the 目录
		scp everyclear.sh yiqing@$1:~ #需要打印一次密码
		sleep 2
		ssh -t -t yiqing@$1 "bash everyclear.sh $2" #需要打印一次密码
	} 

}

#清除网关端的文件夹重建
cleargate(){
	for ((i=1; i<=56; i ++))  
	do  
    	rm -fr $i/; mkdir $i ;
	done  
}


#main
ARRAY=($(awk '{print $0}' pinglist.txt))
count=1
for i in ${ARRAY[*]}
do
	{
		clearway $i $count
	} &
	sleep 10 &
	wait $!
	count=$[ $count + 8 ]
done

{
	cleargate 

} &
sleep 5 &
wait $!

{
	killall -u yiqing
} & 




#ssh yiqing@143.89.191.114 
#cd pingmesh/


