<%@page language="java" import="java.sql.*,java.util.*"%>
<%!
  public static void randomStats(String teamname)throws Exception{
  
    Class.forName("com.mysql.jdbc.Driver");
    Connection con= DriverManager.getConnection("jdbc:mysql://localhost/jlj","jlj","fanball");
    Statement instruction = con.createStatement();
    ResultSet temp= instruction.executeQuery("select * from teamroster t where t.teamname='"+teamname+"'");
    temp.next();
    for(int i=2;i<16;++i){
    String getName=temp.getString(i);
    determineRandom(getName,i);
    }
    con.close();
  }
  
  private static void determineRandom(String name,int i)throws Exception{
  
  if(i==2)
    qbstats(name);
  else if(i==3 || i==4)
    rbstats(name);
  else if(i==5||i==6||i==7)
    wrstats(name);
  else if(i==8)
    testats(name);
  else if(i==9)
    defstats(name);
  else if(i==10)
    kstats(name);
  }
  
 //all below is RANDOMIZE STATS

  private static void qbstats(String name)throws Exception
    {
      
        //Stats for a QB
        int qbTD;
        int qbYards;
        int qbInt;
        
        //Points for QB
        int qbTDpnts;
        int qbYardspnts;
        int qbIntpnts;
        
        //Total points for QB
        int qbtotal;
        
        
         Random generator = new Random();
        
        //Determine stats for all QBs and the points for those stats
         
            qbTD = generator.nextInt(5);
            qbYards = generator.nextInt(325);
            qbInt = generator.nextInt(3);
            
            qbTDpnts = qbTD * 6;
            qbYardspnts = (qbYards/25) * 1;
            qbIntpnts = qbInt * (-2);
            
            qbtotal = qbTDpnts + qbYardspnts + qbIntpnts;
 
            updateWeekStatsQB(qbTD, qbYards, qbInt, qbtotal,name);
    }
    
    
    
    private static void rbstats(String name)throws Exception
    {

        //Stats for a RB
        int rbTD;
        int rbYards;
        int rbFumbles;
        
        //Points for RB
        int rbTDpnts;
        int rbYardspnts;
        int rbFumblespnts;
        
        //Total points for RB
        int rbtotal;
        
        
         Random generator = new Random();
        
        //Determine stats for all RBs and the points for those stats

            rbTD = generator.nextInt(5);
            rbYards = generator.nextInt(120);
            rbFumbles = generator.nextInt(1);
            
            rbTDpnts = rbTD * 6;
            rbYardspnts = (rbYards/10) * 1;
            rbFumblespnts = rbFumbles * (-2);
            
            rbtotal = rbTDpnts + rbYardspnts + rbFumblespnts;

            updateWeekStatsRB(rbTD, rbYards, rbFumbles, rbtotal,name);
    }
    
    
    
    private static void wrstats(String name)throws Exception
    {

        //Stats for a WR
        int wrTD;
        int wrYards;
        
        //Points for WR
        int wrTDpnts;
        int wrYardspnts;
        
        //Total points for WR
        int wrtotal;
        
        
        Random generator = new Random();
        
        //Determine stats for all WRs and the points for those stats

            wrTD = generator.nextInt(3);
            wrYards = generator.nextInt(100);
            
            wrTDpnts = wrTD * 6;
            wrYardspnts = (wrYards/10) * 1;
            
            wrtotal = wrTDpnts + wrYardspnts;

            updateWeekStatsWR(wrTD, wrYards, wrtotal,name);
    }
    
    
    
    private static void testats(String name)throws Exception
    {

        //Stats for a TE
        int teTD;
        int teYards;
        
        //Points for TE
        int teTDpnts;
        int teYardspnts;
        
        //Total points for TE
        int tetotal;
        
        
        Random generator = new Random();
        

            teTD = generator.nextInt(2);
            teYards = generator.nextInt(80);
            
            teTDpnts = teTD * 6;
            teYardspnts = (teYards/10) * 1;
            
            tetotal = teTDpnts + teYardspnts;

            updateWeekStatsTE(teTD, teYards, tetotal,name);
 
    }
    
    
    
    private static void defstats(String name)throws Exception
    {

        //Stats for a DEF
        int pntsallowed;
        int turnovers;
        int sacks;
        int defTD;
        
        //Points for DEF
        int pntsallowedpnts=0;
        int turnoverspnts;
        int sackspnts;
        int defTDpnts;
        
        //Total points for DEF
        int deftotal;
        
        
        Random generator = new Random();
        
        //Determine stats for all DEFs and the points for those stats
            turnovers = generator.nextInt(3);
            sacks = generator.nextInt(3);
            defTD = generator.nextInt(1);
            pntsallowed = generator.nextInt(43) + 2;
            
            turnoverspnts = turnovers * 2;
            sackspnts = sacks * 2;
            defTDpnts = defTD * 6;
            
            if(pntsallowed < 10)
            {
                pntsallowedpnts = 4;
            }
            if(pntsallowed >= 10 && pntsallowed < 20)
            {
                pntsallowedpnts = 2;
            }
            if(pntsallowed >= 20 && pntsallowed < 30)
            {
                pntsallowedpnts = 0;
            }
            if(pntsallowed >= 30 && pntsallowed < 40)
            {
                pntsallowedpnts = -2;
            }
            if(pntsallowed >= 40)
            {
                pntsallowedpnts = -4;
            }
       
            deftotal = turnoverspnts + sackspnts + defTDpnts + pntsallowedpnts;

            updateWeekStatsDEF(turnovers, sacks, defTD, pntsallowed, deftotal,name);

    }
    
    
    
    private static void kstats(String name)throws Exception
    {

        //Stats for K
        int lessfourtyFG;
        int greatfourtyFG;
        int lessFGmiss;
        int greatFGmiss;
        int PAT;
        int missPAT;
        
        //Points for K
        int lessfourtyFGpnts;
        int greatfourtyFGpnts;
        int lessFGmisspnts;
        int greatFGmisspnts;
        int PATpnts;
        int missPATpnts;
        
        //Total points for K
        int ktotal;
        
        
        Random generator = new Random();

            lessfourtyFG = generator.nextInt(2);
            greatfourtyFG = generator.nextInt(1);
            lessFGmiss = generator.nextInt(1);
            greatFGmiss = generator.nextInt(1);
            PAT = generator.nextInt(4);
            missPAT = generator.nextInt(1);
            
            lessfourtyFGpnts = lessfourtyFG * 3;
            greatfourtyFGpnts = greatfourtyFG * 4;
            lessFGmisspnts = lessFGmiss * (-2);
            greatFGmisspnts = greatFGmiss * (-1);
            PATpnts = PAT * 1;
            missPATpnts = missPAT * (-1);
            
            ktotal = lessfourtyFGpnts+ greatfourtyFGpnts + lessFGmisspnts + greatFGmisspnts + PATpnts + missPATpnts;

            updateWeekStatsK(lessfourtyFG, greatfourtyFG, lessFGmiss, greatFGmiss, PAT, missPAT, ktotal,name);

    }
    
    
    
    
    //UPDATE WEEKLY STATS FOR PLAYERS
    
    private static void updateWeekStatsQB(int td, int yds, int intcp, int points,String playerName)throws Exception
    {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/jlj","jlj","fanball");
        Statement instruction = conn.createStatement();
        //NEED TO FIGURE OUT HOW TO UPDATE ROW BY ROW
        instruction.executeUpdate("UPDATE weeklystats w SET w.passTD="+td+",w.passYards="+yds+",w.interceptions="+intcp+",w.calpoints="+points+" WHERE w.name='"+playerName+"'" );
        conn.close();
    }
    
    private static void updateWeekStatsRB(int td, int yds, int fmbl, int points,String playerName)throws Exception
    {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/jlj","jlj","fanball");
        Statement instruction = conn.createStatement();
        //NEED TO FIGURE OUT HOW TO UPDATE ROW BY ROW
        instruction.executeUpdate("UPDATE weeklystats w SET w.rushTD="+td+",w.rushYards="+yds+",w.fumbles="+fmbl+",w.calpoints="+points+" WHERE w.name='"+playerName+"'");
        conn.close();
    }
    
    private static void updateWeekStatsWR(int td, int yds, int points,String playerName)throws Exception
    {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/jlj","jlj","fanball");
        Statement instruction = conn.createStatement();
        //NEED TO FIGURE OUT HOW TO UPDATE ROW BY ROW
        instruction.executeUpdate("UPDATE weeklystats w SET w.receivingTD="+td+",w.receivingYards="+yds+",w.calpoints="+points+" WHERE w.name='"+playerName+"'");
        conn.close();
    }
    
    private static void updateWeekStatsTE(int td, int yds, int points,String playerName)throws Exception
    {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/jlj","jlj","fanball");
        Statement instruction = conn.createStatement();
        //NEED TO FIGURE OUT HOW TO UPDATE ROW BY ROW
        instruction.executeUpdate("UPDATE weeklystats w SET w.receivingTD="+td+",w.receivingYards="+yds+",w.calpoints="+points+" WHERE w.name='"+playerName+"'");
        conn.close();
    }
    
    private static void updateWeekStatsDEF(int to, int sack, int td, int allow, int points,String playerName)throws Exception
    {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/jlj","jlj","fanball");
        Statement instruction = conn.createStatement();
        //NEED TO FIGURE OUT HOW TO UPDATE ROW BY ROW
        instruction.executeUpdate("UPDATE weeklystats w SET w.turnovers="+to+",w.sacks="+sack+",w.defensiveTD="+td+",w.pointsallowed="+allow+", calpoints="+points+" where w.name='"+playerName+"'");
        conn.close();
    }
    
    private static void updateWeekStatsK(int l40, int g40, int ml40, int mg40, int pat, int mpat, int points,String playerName)throws Exception
    {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/jlj","jlj","fanball");
        Statement instruction = conn.createStatement();
        //NEED TO FIGURE OUT HOW TO UPDATE ROW BY ROW
        instruction.executeUpdate("UPDATE weeklystats w SET w.fieldgoalless40="+l40+",w.fieldgoalgreater40="+g40+",w.missedfieldgoaless40="+ml40+",w.missedfieldgoalgreater40="+mg40+",w.PAT="+pat+",w.missedPAT="+mpat+",w.calpoints="+points+" WHERE w.name='"+playerName+"'");
        conn.close();
    }
    
public static boolean compareWin(String username, String otherUserName)
    throws Exception{
    
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/jlj","jlj","fanball");
        Statement instruction = conn.createStatement();
        //NEED TO FIGURE OUT HOW TO UPDATE ROW BY ROW
        ResultSet resultA = instruction.executeQuery("select w.name,w.calpoints from weeklystats w where w.name IN (select p.name from players p where p.owner='"+username+"'");
        ResultSet resultB = instruction.executeQuery("select w.name,w.calpoints from weeklystats w where w.name IN (select p.name from players p where p.owner='"+otherUserName+"'");
        double calpointA=0;
        double calpointB=0;
        while(resultA.next()){
        
          calpointA+=resultA.getDouble(2);
        }
        
        while(resultB.next()){
        
          calpointB+=resultB.getDouble(2);
        }
        
        
        conn.close();
        if(calpointA<calpointB)
          return true;//true means this user wins
        else 
          return false;//false means other wins
    }//a new method to compare the winner between this user and the other user, remember the other input is username instead of teamname

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
    
  //calculate all the winner in each week.
  public static void calWin(int thisWeek)throws Exception{
  
    Class.forName("com.mysql.jdbc.Driver");
    Connection con= DriverManager.getConnection("jdbc:mysql://localhost/jlj","jlj","fanball");
    Statement instruction = con.createStatement();
    ResultSet resultS = instruction.executeQuery("select s.username,s.week"+thisWeek+" from schedule s");
    int totalTeam=calTotalInPlayUser();

    ArrayList<String> firstSet=new ArrayList<String>();
    ArrayList<String> secondSet=new ArrayList<String>();
    Set<String> containSet=new HashSet<String>();
    while(resultS.next()){
     firstSet.add(resultS.getString(1));
     secondSet.add(resultS.getString(2));
    }
    if(firstSet.size()!=0){
    int index=0;
    while(index<firstSet.size()){
    
      String first=firstSet.get(index);
      String second=secondSet.get(index);
      if(containSet.contains(first) || containSet.contains(second)){
       
        containSet.add(first);
        containSet.add(second);
        index++;
        continue;
      }
      else {
      ResultSet resultA = instruction.executeQuery("select distinct w.name,w.calpoints from weeklystats w where w.name IN (select p.name from players p where p.owner='"+first+"')");
      double calpointA=0;
       while(resultA.next()){
        
         calpointA+=resultA.getDouble(2);
      }
      ResultSet resultB = instruction.executeQuery("select distinct w.name,w.calpoints from weeklystats w where w.name IN (select p.name from players p where p.owner='"+second+"')");
      double calpointB=0;
      
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
      containSet.add(first);
      containSet.add(second);
      index++;
      }
    }
    }
    con.close();
  }//calculate the winner of specific roster
  
  public static void calRank()throws Exception{
  
    Class.forName("com.mysql.jdbc.Driver");
    Connection con= DriverManager.getConnection("jdbc:mysql://localhost/jlj","jlj","fanball");
    Statement instruction = con.createStatement();
    ResultSet resultAt = instruction.executeQuery("select u.username from user u order by u.lossdata,u.rank");
    ArrayList<String> tempSet=new ArrayList<String>();
    while(resultAt.next()){
    
      tempSet.add(resultAt.getString(1));
    }
    int index=0;
    int rankIndex=1;
    instruction.executeUpdate("update user u SET u.rank=null");
    if(tempSet.size()!=0){
    while(index<tempSet.size()){
      String temp=tempSet.get(index);;
      instruction.executeUpdate("update user u SET u.rank="+rankIndex+" where u.username='"+temp+"'");
      rankIndex++;
      index++;
    }
    }
    con.close();
  }
  
  public static int calTotalInPlayUser()throws Exception{
  
    Class.forName("com.mysql.jdbc.Driver");
    Connection con= DriverManager.getConnection("jdbc:mysql://localhost/jlj","jlj","fanball");
    Statement instruction = con.createStatement();
    ResultSet resultT = instruction.executeQuery("select s.username from schedule s");
    int totalTeam=0;
    while(resultT.next()){
    totalTeam++;
    }
    con.close();
    return totalTeam;
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
