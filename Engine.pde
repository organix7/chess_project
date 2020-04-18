class Engine extends Thread{
  
  private String fileName = "stockfish_11.exe";
  private ArrayList<String> possibleMoves = new ArrayList();
  private String bestMove = null;
  private boolean mode;
  private String moves;
  private Move move;
  
  Engine(String moves, boolean mode, Move move){
    this.move = move;
    this.moves = moves;
    this.mode = mode;
    move.setEngineIsOn(true);
    start();
  }
  
  public void run(){
    if (mode)
      getMoveAvailable();
    else
      getBestMove();
  }
  
  public void getMoveAvailable(){
   try {
    Process p = launch(dataPath(fileName));
    BufferedReader out = new BufferedReader(new InputStreamReader(p.getInputStream()));
    BufferedWriter in = new BufferedWriter(new OutputStreamWriter(p.getOutputStream())); 
      if(!moves.equals("")){
        in.write("position startpos moves " + moves);
        in.newLine();
      }      
      in.write("go perft 1");
      in.flush();
      in.close();
      possibleMoves.clear();
      String read=null;
      while((read = out.readLine()) != null)
        if(read.length() >= 4 && !read.contains("Stockfish 11") && !read.contains("Nodes") && !possibleMoves.contains(read.substring(0,4)))
          possibleMoves.add(read.substring(0,4));
     }
    catch (Exception ex) {
      ex.printStackTrace();
    }
    move.setMoveAvailable(possibleMoves);
    if(move.getMoveAvailable().isEmpty() && isCheckMate())
      move.setResultGame("You Lose");
    else if(move.getMoveAvailable().isEmpty())
      move.setResultGame("Draw");
    move.setEngineIsOn(false);
  }
  
  public void getBestMove(){
    try {
      Process p = launch(dataPath(fileName));
      BufferedReader out = new BufferedReader(new InputStreamReader(p.getInputStream()));
      BufferedWriter in = new BufferedWriter(new OutputStreamWriter(p.getOutputStream())); 
      in.write("position startpos moves " + moves);
      in.newLine();      
      in.write("go movetime 200");
      in.newLine();      
      in.flush();
      sleep(200);
      in.close();
      String read=null;
      while((read = out.readLine()) != null)
        if(read.contains("bestmove"))
          if(read.split(" ")[1].length() == 4)
            bestMove = read.split(" ")[1];
          else if(read.split(" ")[1].length() == 5)
           bestMove = read.split(" ")[1];
 //     println("bestmove :" + bestMove);
      out.close();
     }
    catch (Exception ex) {
      ex.printStackTrace();
    }
    move.setBestMove(bestMove);
    if(bestMove == null && isCheckMate())
      move.setResultGame("You Win");
    else if(bestMove == null )
      move.setResultGame("Draw");
    else{
      move.engineMove();
      move.setEngineIsOn(false);
    }
  }
  
  public Boolean isCheckMate(){
     try {
      Process p = launch(dataPath(fileName));
      BufferedReader out = new BufferedReader(new InputStreamReader(p.getInputStream()));
      BufferedWriter in = new BufferedWriter(new OutputStreamWriter(p.getOutputStream())); 
      in.write("position startpos moves " + moves);
      in.newLine();      
      in.write("eval");
      in.newLine();      
      in.flush();
      in.close();
      String read=null;
      while((read = out.readLine()) != null)
        if(read.contains("in check"))
          return true;
      out.close();
     }
    catch (Exception ex) {
      ex.printStackTrace();
    }
    return false;
  }
}
