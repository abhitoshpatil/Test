#Declare Variables
time=$(date "+%Y.%m.%d-%H.%M")
ScriptName=Test.jmx
#ToEmail=abhitosh.qa@gmail.com
#htmlName=htmlreport_$time
#jtlName=jtl_$time.jtl
results=PerfTest_results_$time
#Download JMeter
#java -version
#curl http://mirror.cc.columbia.edu/pub/software/apache/jmeter/binaries/apache-jmeter-5.3.tgz -o apache-jmeter-5.3.tgz;
#tar -xvzf apache-jmeter-5.3.tgz;
#Create Test Directories
cd apache-jmeter-5.5-SNAPSHOT/bin;
mkdir ../../$results
mkdir ../../$results/HTMLReport
mkdir ../../$results/Errors
mkdir ../../$results/InputData
mkdir ../../$results/OutputData
#Execute Performance Test
nohup sh jmeter.sh -Jjmeter.save.saveservice.output_format=xml -Jjmeter.save.saveservice.output_format=csv -n -t ../../$ScriptName -l ../../$results/Test.jtl -e -o ../../$results/HTMLReport > ../../$results/nohup.txt 2>&1
##Collect Test Artifacts
mv jmeter.log ../../$results
#mv ../../PerfError_* ../../$results/Errors
#mv ../../Input_*.csv ../../$results/InputData
#mv ../../Output_*.csv ../../$results/OutputData
cp ../../$results/Test.jtl ../../$results/AggregateReport.csv
mv ../../$results/HTMLReport/index.html ../../$results/HTMLReport/PerfTestReport.html
#Mail The Results
#mailx -a ../../$results/HTMLReport/PerfTestReport.html -s "Performance Testing Report" $ToEmail < /dev/null