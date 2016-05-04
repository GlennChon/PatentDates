/*
Glenn Chon
Data Visualization
Assignment 5
Automation Project
GCPatentInfo
*/

import java.util.regex.*;

int patentCount;
String[] patentNums;

PrintWriter patentInfo;

void setup(){
  setupPatentNums();
  createDataFile();
}

void setupPatentNums(){
  patentNums = loadStrings("patentNums.tsv");//load patentNums.tsv into array
  patentCount = patentNums.length;//get number of patents
  //println(patentNums[0], patentNums[133088]);//test to see if all numbers are in patentNums[]
  //println(patentCount);
}

void createDataFile(){//gets details for each patent number
  //string base for patent number based search
  String base = "http://patft.uspto.gov/netacgi/nph-Parser?Sect1=PTO1&Sect2"
  +"=HITOFF&d=PALL&p=1&u=%2Fnetahtml%2FPTO%2Fsrchnum.htm&r=1&f=G&l=50&s1=";
  
  patentInfo = createWriter("patentInfo.tsv");//writer
  for (int i = 0; i < patentCount; i++){
    if (i%100 == 0){ //display progress every 100 pages
      println(i);
    }
    parsePatentData(loadStrings(base + patentNums[i] + ".PN.&OS=PN/" + patentNums[i] + "&RS=PN/" + patentNums[i]));
  }
  patentInfo.flush();//flush buffer
  patentInfo.close();//close
  println("file has been written");
  
}


void parsePatentData(String[] lines){
  String filedDate = "";
  int match = 0;
  Pattern date = Pattern.compile("\\s*<b>(\\w*\\s\\d*,\\s\\d{4})</b></TD></TR>");
  
  for (int i = 0; i < lines.length && match != 1; i++){
    Matcher m = date.matcher(lines[i]);
    
    if(m.matches()){
      match = 1;
      //println("found");
      filedDate = m.group(1);
      
      //println(filedDate);//check to see if I got the date.
      patentInfo.println(filedDate);
    }
  }
}


    
  
  
  