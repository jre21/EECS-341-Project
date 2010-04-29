<%@page language="java" import="java.sql.*,java.util.*,java.io.*"%>
<%!
  public static void startGame()throws Exception{
  
    Class.forName("com.mysql.jdbc.Driver");
    Connection con= DriverManager.getConnection("jdbc:mysql://localhost/jlj","jlj","fanball");
    Statement instruction = con.createStatement();
    instruction.executeUpdate("update user u set u.modes=1 where u.modes=0");// change all the user exist now to the modes 1 which is play mode
    makeSchedule();
    File file=new File("start.html");
    PrintWriter output=new PrintWriter(file);
    output.print("");//put html code here and if you wish put the output.print() as more as possible
    
    output.close();
     con.close();
  }
  
  public static boolean makeSchedule()throws Exception{//make the schedule for our schedule table

    Class.forName("com.mysql.jdbc.Driver");
    Connection con= DriverManager.getConnection("jdbc:mysql://localhost/jlj","jlj","fanball");
    Statement instruction = con.createStatement();
    ResultSet resultat = instruction.executeQuery("SELECT u.username from user u order by u.lossdata");
    resultat.next();
    ArrayList<String> userResult=new ArrayList<String>();
    while(resultat.next()){
      userResult.add(resultat.getString(1));}
    int n=userResult.size();
    
    if(n==0)
      return false;
    
    int [][] matchTable;
    if(userResult.size()%2!=0){
      n++;
      matchTable=doSchedule(n);
    }
    else
      matchTable=doSchedule(n);
    
    instruction.executeUpdate("DROP TABLE IF EXISTS schedule");
    String excuteString="CREATE TABLE schedule ( username CHAR(20) NOT NULL, ";
    for(int i=0;i<n;++i)
        excuteString+="week"+(i+1)+" CHAR(20), ";
    
    excuteString+="PRIMARY KEY (username), FOREIGN KEY (username) REFERENCES user (username))";
    instruction.executeUpdate(excuteString);
    
    if(userResult.size()!=n){
      
      for(int i=0;i<n;++i){
        String theString="INSERT INTO schedule VALUES ("+userResult.get(i);
        for(int j=0;j<n-1;++j){
           if(matchTable[i][j]==userResult.size())
             theString+=",break";
           else
             theString+=","+userResult.get(matchTable[i][j]);
         }
         theString+=")";
         instruction.executeUpdate(theString);
        }
      }
    else {
      
      for(int i=0;i<n;++i){
        String theString="INSERT INTO schedule VALUES ("+userResult.get(i);
        for(int j=0;j<n-1;++j){
             theString+=","+userResult.get(matchTable[i][j]);
         }
         theString+=")";
         instruction.executeUpdate(theString);
        }
    }
    con.close();
    return true;
  }
 
  private static int[][] doSchedule(int n){
    
    if(n==2){
      int[][] theTable=new int[2][1];
      theTable[0][0]=1;
      theTable[1][0]=0;
       return theTable;
    }
    
    int[][] matchSet=new int[n-1][n];
    for(int i=0;i<n-1;++i)
      matchSet[i][0]=n-1;
    matchSet[0][1]=0;
    
    int factor=1;
    for(int i=2;i<n;i=i+2){
      matchSet[0][i]=factor;
      factor++;
    }
    for(int i=n-1;i>=3;i=i-2){
      matchSet[0][i]=factor;
        factor++;
    }
    
    ArrayList<Factor_jsp> mySet=new ArrayList<Factor_jsp>();

    for(int k=1;k<n-1;++k){
    for(int i=n-2;i>1;i=i-2){
       mySet.add(new Factor_jsp(matchSet[k-1][i-1],matchSet[k-1][i]));
    }
     matchSet[k][1]=matchSet[k-1][n-1];
     for(int i=2;i<n;i=i+2){
       matchSet[k][i]=mySet.get(0).one;
       matchSet[k][i+1]=mySet.get(0).two;
       mySet.remove(0);
     }
     mySet.clear();
    }
    
    int[][] matchTable=new int[n][n-1];
    
    for(int i=0;i<n-1;++i)
      for(int j=0;j<n;j=j+2){
         matchTable[matchSet[i][j]][i]=matchSet[i][j+1];
         matchTable[matchSet[i][j+1]][i]=matchSet[i][j];
      }

    return matchTable;
  }

  public static void updateWeekStats(String name,double passTD,double passyards,double interceptions,double rushTD,double rushyards,double fumbles,double receivingTD,double receivingyards,double pointsallowed,double turnovers,double sacks,double defensiveTD,double fl40,double fg40,double ml40,double mg40,double pat,double mpat)throws Exception{
  
    Class.forName("com.mysql.jdbc.Driver");
    Connection con= DriverManager.getConnection("jdbc:mysql://localhost/jlj","jlj","fanball");
    Statement instruction = con.createStatement();
    double total=passTD+passyards+interceptions+rushTD+rushyards+fumbles+receivingTD+receivingyards+pointsallowed+turnovers+sacks+defensiveTD+fl40+fg40+ml40+mg40+pat+mpat;
    instruction.executeUpdate("UPDATE weeklystats w SET passTD="+passTD+",passyards="+passyards+",interceptions="+interceptions+",rushTD="+rushTD+",rushyards="+rushyards+",fumbles="+fumbles+",receivingTD="+receivingTD+",receivingyards="+receivingyards+",pointsallowed="+pointsallowed+",turnovers="+turnovers+",sacks="+sacks+",defensiveTD="+defensiveTD+",fieldgoalless40="+fl40+",fieldgoalgreater40="+fg40+",missedfieldgoaless40="+ml40+",missedfieldgoalgreater40="+mg40+",PAT="+pat+",missedPAT="+mpat+",calpoints="+total+" where w.name='"+name+"'");//
    con.close();
  }
  
  public static void startNextWeek(int thisWeek)throws Exception{
  
    Class.forName("com.mysql.jdbc.Driver");
    Connection con= DriverManager.getConnection("jdbc:mysql://localhost/jlj","jlj","fanball");
    Statement instruction = con.createStatement();
    instruction.executeUpdate("update totalstats t,weeklystats w set t.passTD=t.passTD+w.passTD,t.passyards=t.passyards+w.passyards,t.interceptions=t.interceptions+w.interceptions,t.rushTD=t.rushTD+w.rushTD,t.rushyards=t.rushyards+w.rushyards,t.fumbles=t.fumbles+w.fumbles,t.receivingTD=t.receivingTD+w.receivingTD,t.receivingyards=t.receivingyards+w.receivingyards,t.pointsallowed=t.pointsallowed+w.pointsallowed,t.turnovers=t.turnovers+w.turnovers,t.sacks=t.sacks+w.sacks,t.defensiveTD=t.defensiveTD+w.defensiveTD,t.fieldgoalless40=t.fieldgoalless40+w.fieldgoalless40,t.fieldgoalgreater40=t.fieldgoalgreater40+w.fieldgoalgreater40,t.missedfieldgoaless40=t.missedfieldgoaless40+w.missedfieldgoaless40,t.missedfieldgoalgreater40=t.missedfieldgoalgreater40+w.missedfieldgoalgreater40,t.PAT=t.PAT+w.PAT,t.missedPAT=t.missedPAT+w.missedPAT,t.calpoints=t.calpoints+w.calpoints where t.name=w.name");
    calWin(thisWeek);
    calRank();
    con.close();
  }
  
  public static void setInjury(String name,String types)throws Exception{
  
    Class.forName("com.mysql.jdbc.Driver");
    Connection con= DriverManager.getConnection("jdbc:mysql://localhost/jlj","jlj","fanball");
    Statement instruction = con.createStatement();
    instruction.executeUpdate("update players p set p.injury='"+types+"' where p.name='"+name+"'");
    con.close();
  }
  
  //to let the system to determine which people will go first in the selection
  public static ResultSet determineSelection()throws Exception{
  
    Class.forName("com.mysql.jdbc.Driver");
    Connection con= DriverManager.getConnection("jdbc:mysql://localhost/jlj","jlj","fanball");
    Statement instruction = con.createStatement();
    ResultSet resultat = instruction.executeQuery("select u.username from user u oreder by lossdata");
    con.close();
    return resultat;
  }
  
  //calculate all the winner in each week.
  public static void calWin(int thisWeek)throws Exception{
  
    Class.forName("com.mysql.jdbc.Driver");
    Connection con= DriverManager.getConnection("jdbc:mysql://localhost/jlj?user=root");
    Statement instruction = con.createStatement();
    ResultSet resultS = instruction.executeQuery("select s.username,s.week"+thisWeek+" from schedule");
    ResultSet resultT = instruction.executeQuery("select * from schedule");
    int totalTeam=(resultT.getMetaData().getColumnCount()-1)/2;
    while(resultS.next()){
    
      String first=resultS.getString(1);
      String second=resultS.getString(2);
      ResultSet resultA = instruction.executeQuery("select distinct w.name,w.calpoints from weeklystats w where w.name IN (select p.name from players p where p.owner='"+first+"'");
      ResultSet resultB = instruction.executeQuery("select distinct w.name,w.calpoints from weeklystats w where w.name IN (select p.name from players p where p.owner='"+second+"'");
      double calpointA=0;
      double calpointB=0;
      while(resultA.next()){
        
         calpointA+=resultA.getDouble(2);
      }
       
      while(resultB.next()){
        
        calpointB+=resultB.getDouble(2);
      }
      
      if(thisWeek>totalTeam){
      
        if(calpointA>=calpointB){
        
          instruction.executeUpdate("update user u SET u.windata=u.windata+1 where u.username='"+first+"'");
          instruction.executeUpdate("update user u SET u.lossdata=u.lossdata+1 where u.username='"+second+"'");
        }
        else {
        
          instruction.executeUpdate("update user u SET u.windata=u.windata+1 where u.username='"+second+"'");
          instruction.executeUpdate("update user u SET u.lossdata=u.lossdata+1 where u.username='"+first+"'");
        }
      }
      else {
      
        if(calpointA>calpointB){
        
          instruction.executeUpdate("update user u SET u.windata=u.windata+1 where u.username='"+first+"'");
          instruction.executeUpdate("update user u SET u.lossdata=u.lossdata+1 where u.username='"+second+"'");
        }
        else {
        
          instruction.executeUpdate("update user u SET u.windata=u.windata+1 where u.username='"+second+"'");
          instruction.executeUpdate("update user u SET u.lossdata=u.lossdata+1 where u.username='"+first+"'");
        }
      }
    }
    
    con.close();
  }//calculate the winner of specific roster
  
  public static void calRank()throws Exception{
  
    Class.forName("com.mysql.jdbc.Driver");
    Connection con= DriverManager.getConnection("jdbc:mysql://localhost/jlj?user=root");
    Statement instruction = con.createStatement();
    ResultSet resultAt = instruction.executeQuery("select u.username from user u order by u.windata,u.rank");
    int rankIndex=1;
    instruction.executeUpdate("update user u SET u.rank=null");
    while(resultAt.next()){
      String temp=resultAt.getString(1);
      instruction.executeUpdate("update user u SET u.rank="+rankIndex+" where u.username='"+temp+"'");
      rankIndex++;
    }
    con.close();
  }
  
  public static void randomInjuryStatus()throws Exception{
  
    Class.forName("com.mysql.jdbc.Driver");
    Connection con= DriverManager.getConnection("jdbc:mysql://localhost/jlj","jlj","fanball");
    Statement instruction = con.createStatement();
    ResultSet resultat = instruction.executeQuery("SELECT name from player");
    while(resultat.next()){
    
      String temp=resultat.getString(1);
      double dick=Math.random()*10;
      if(dick<1){
      
        ResultSet tempResult=instruction.executeQuery("SELECT p.name,p.injurystate from player p where p.name='"+temp+"'");
        tempResult.next();
        if(tempResult.getString(2).equals("Q"))
          instruction.executeUpdate("update player p SET p.injurystate='O' where p.name='"+temp+"'");
        else 
          instruction.executeUpdate("update player p SET p.injurystate='Q' where p.name='"+temp+"'");
      }
    }
    
    con.close();
  }//random assign injury to each people
%>
