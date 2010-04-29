<%@page language="java" import="java.sql.*,java.util.*"%>
<%!
  public void randomStats(String teamname)throws Exception{
  
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
  
  private void determineRandom(String name,int i)throws Exception{
  
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

  private void qbstats(String name)throws Exception
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
    
    
    
    private void rbstats(String name)throws Exception
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
    
    
    
    private void wrstats(String name)throws Exception
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
    
    
    
    private void testats(String name)throws Exception
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
    
    
    
    private void defstats(String name)throws Exception
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
    
    
    
    private void kstats(String name)throws Exception
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
    
    public void updateWeekStatsQB(int td, int yds, int intcp, int points,String playerName)throws Exception
    {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/jlj","jlj","fanball");
        Statement instruction = conn.createStatement();
        //NEED TO FIGURE OUT HOW TO UPDATE ROW BY ROW
        instruction.executeUpdate("UPDATE weeklystats w SET w.passTD="+td+",w.passYards="+yds+",w.interceptions="+intcp+",w.calpoints="+points+" WHERE w.name='"+playerName+"'" );
        conn.close();
    }
    
    public void updateWeekStatsRB(int td, int yds, int fmbl, int points,String playerName)throws Exception
    {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/jlj","jlj","fanball");
        Statement instruction = conn.createStatement();
        //NEED TO FIGURE OUT HOW TO UPDATE ROW BY ROW
        instruction.executeUpdate("UPDATE weeklystats w SET w.rushTD="+td+",w.rushYards="+yds+",w.fumbles="+fmbl+",w.calpoints="+points+" WHERE w.name='"+playerName+"'");
        conn.close();
    }
    
    public void updateWeekStatsWR(int td, int yds, int points,String playerName)throws Exception
    {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/jlj","jlj","fanball");
        Statement instruction = conn.createStatement();
        //NEED TO FIGURE OUT HOW TO UPDATE ROW BY ROW
        instruction.executeUpdate("UPDATE weeklystats w SET w.receivingTD="+td+",w.receivingYards="+yds+",w.calpoints="+points+" WHERE w.name='"+playerName+"'");
        conn.close();
    }
    
    public void updateWeekStatsTE(int td, int yds, int points,String playerName)throws Exception
    {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/jlj","jlj","fanball");
        Statement instruction = conn.createStatement();
        //NEED TO FIGURE OUT HOW TO UPDATE ROW BY ROW
        instruction.executeUpdate("UPDATE weeklystats w SET w.receivingTD="+td+",w.receivingYards="+yds+",w.calpoints="+points+" WHERE w.name='"+playerName+"'");
        conn.close();
    }
    
    public void updateWeekStatsDEF(int to, int sack, int td, int allow, int points,String playerName)throws Exception
    {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/jlj","jlj","fanball");
        Statement instruction = conn.createStatement();
        //NEED TO FIGURE OUT HOW TO UPDATE ROW BY ROW
        instruction.executeUpdate("UPDATE weeklystats w SET w.turnovers="+to+",w.sacks="+sack+",w.defensiveTD="+td+",w.pointsallowed="+allow+", calpoints="+points+" w.name='"+playerName+"'");
        conn.close();
    }
    
    public void updateWeekStatsK(int l40, int g40, int ml40, int mg40, int pat, int mpat, int points,String playerName)throws Exception
    {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/jlj","jlj","fanball");
        Statement instruction = conn.createStatement();
        //NEED TO FIGURE OUT HOW TO UPDATE ROW BY ROW
        instruction.executeUpdate("UPDATE weeklystats w SET w.fieldgoalless40="+l40+",w.fieldgoalgreater40="+g40+",w.missedfieldgoaless40="+ml40+",w.missedfieldgoalgreater40="+mg40+",w.PAT="+pat+",w.missPAT="+mpat+",w.calpoints="+points+" WHERE w.name='"+playerName+"'");
        conn.close();
    }
    
public boolean compareWin(String username, String otherUserName)
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
%>
