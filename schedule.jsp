<%@page language="java" import="java.sql.*,java.util.*,java.io.*"%>
<%!
  public static boolean makeSchedule()throws Exception{//make the schedule for our schedule table

    Class.forName("com.mysql.jdbc.Driver");
    Connection con= DriverManager.getConnection("jdbc:mysql://localhost/jlj","jlj","fanball");
    Statement instruction = con.createStatement();
    instruction.executeUpdate("update user u set u.modes=1 where u.modes=0");
    ResultSet resultat = instruction.executeQuery("SELECT u.username from user u order by u.rank");
    ArrayList<String> userResult=new ArrayList<String>();
    while(resultat.next()){
      userResult.add(resultat.getString(1));}
    int n=userResult.size();
    
    if(n==0)
      return false;
    
    int[][] matchTable;
    if(userResult.size()%2!=0){
      n++;
      matchTable=doSchedule(n);
    }
    else
      matchTable=doSchedule(n);
    
    instruction.executeUpdate("DROP TABLE IF EXISTS schedule");
    String excuteString="CREATE TABLE schedule ( username CHAR(20) NOT NULL, ";
    for(int i=0;i<2*(n-1);++i)
        excuteString+="week"+(i+1)+" CHAR(20), ";
    
    excuteString+="PRIMARY KEY (username), FOREIGN KEY (username) REFERENCES user (username))";
    instruction.executeUpdate(excuteString);
    
    if(userResult.size()%2!=0){
      
      for(int i=0;i<n-1;++i){
        String theString="INSERT INTO schedule VALUES ('"+userResult.get(i)+"'";
        int index=0;
        for(int j=0;j<n-1;++j){
           if(matchTable[i][j]==userResult.size())
             theString+=", 'break'";
           else
             theString+=", '"+userResult.get(matchTable[i][j])+"'";
           index=j;
         }
        for(int j=index;j<n-1+index;j++){
        
           if(matchTable[i][j-index]==userResult.size())
             theString+=", 'break'";
           else
             theString+=", '"+userResult.get(matchTable[i][j-index])+"'";
        }
         theString+=")";
         instruction.executeUpdate(theString);
        }
      }
    else {
      
      for(int i=0;i<n;++i){
        String theString="INSERT INTO schedule VALUES ('"+userResult.get(i)+"'";
        int index=0;
        for(int j=0;j<n-1;++j){
             theString+=",'"+userResult.get(matchTable[i][j])+"'";
             index=j;
         }
        for(int j=index;j<n-1+index;++j){
             theString+=",'"+userResult.get(matchTable[i][j-index])+"'";
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
%>
