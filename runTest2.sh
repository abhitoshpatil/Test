scriptName=Test.jmx
time=$(date "+%Y.%m.%d-%H.%M")
#cd ./${platform}/
results=PerfTest_Results_$time
mkdir ./$results
mkdir ./HTMLReport_$time
nohup sh apache-jmeter-5.5-SNAPSHOT/bin/jmeter.sh -Jjmeter.save.saveservice.output_format=csv -n -t ./$scriptName -f -l ./Test_$time.jtl -e -o ./HTMLReport_$time > ./$results/nohup.txt 2>&1
sh apache-jmeter-5.5-SNAPSHOT/bin/JMeterPluginsCMD.sh --generate-csv ./Aggregate_$time.csv --input-jtl ./Test_$time.jtl --plugin-type AggregateReport
#cut -d',' -f1,2,3,5,8,9,10 Temp_$time.csv > Temp2_$time.csv
#head -n1 Temp2_$time.csv && tail -n+2 Temp2_$time.csv | sort >> Temp3_$time.csv
#awk -F: '/^\\[TC]/{print $1}' Temp3_$time.csv >> Aggregate_$time.csv
#sed -i '1s/.*/ Label,Samples#,Average,90%,Min,Max,Error%/' Aggregate_$time.csv
mv ./HTMLReport_$time ./$results
mv ./Test_$time.jtl ./$results
mv ./jmeter.log ./$results
#mv ./GrafanaResults.txt ./$results
mv ./Aggregate_$time.csv ./$results
mv ./Test.properties ./$results
#rm ./Temp*.csv
echo "Test Finished. Find test results in folder $results"