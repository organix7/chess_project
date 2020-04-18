class Move{
   
  private String moves="", moveFrom, moveTo,bestMove =null, resultGame = null;
  private Square[][] squares;
  private Square squareFrom, squareTo;
  private Board board;
  private int xFrom,yFrom,xTo,yTo;
  private ArrayList <String> moveAvailable;
  private boolean engineIsOn = false;
  private Piece pieceCaptured;

  Move(Board board,Square[][] squares){
   this.squares = squares;
   this.board = board;
   new Engine(moves,true,this);
  }
  
  public void moveFrom(Piece draggedPiece){
    xFrom = draggedPiece.getSquare().getX();
    yFrom = draggedPiece.getSquare().getY();
    moveFrom = String.valueOf(draggedPiece.getSquare().getColumn()) + Integer.toString(draggedPiece.getSquare().getRow());
    squareFrom = draggedPiece.getSquare();
  }
  
  public boolean moveTo(Piece draggedPiece){ 
     for(int row = 0; row < 8; row++)
      for(int col = 0; col < 8; col++){
        if(mouseX > squares[row][col].getX() && mouseY > squares[row][col].getY() && 
        mouseX < squares[row][col].getX()+100 && mouseY < squares[row][col].getY()+100 ){
          xTo = squares[row][col].getX();
          yTo = squares[row][col].getY();
          moveTo = String.valueOf(squares[row][col].getColumn()) + Integer.toString(squares[row][col].getRow());
          squareTo = squares[row][col];
        }
      }
    if(!engineIsOn && isValidMove()){
      squareFrom.nullPiece();
      takePiece(squareTo);
      enPassant(draggedPiece,squareFrom,squareTo);
      squareTo.setPiece(draggedPiece);
      castlingCheck(draggedPiece,moveFrom, moveTo);  
      return true;
    }
    else
      draggedPiece.getPieceImg().setPosition(xFrom,yFrom);
    return false;
  }
  
  public void takePiece(Square squareTo){
    if(squareTo.getPiece()!=null){ // take piece
       pieceCaptured = squareTo.getPiece(); 
       board.getAllPieces().remove(squareTo.getPiece());
    }
  }
  
  private boolean isValidMove(){
    if(mouseX > squares[7][0].getX() && mouseY > squares[7][0].getY() && 
        mouseX < squares[0][7].getX()+100 && mouseY < squares[0][7].getY()+100)
      for(String move : moveAvailable)
        if(move.equals(moveFrom+moveTo)){
          moves+= moveFrom+moveTo+" ";
          return true;
        }
    return false;
  }
  
  public void castlingCheck(Piece piece,String moveFrom, String moveTo){
     if(piece.getPieceType()=='K')
      {
        switch(moveFrom+moveTo){
          case "e1g1":
              squares[0][5].setPiece(squares[0][7].getPiece());
              squares[0][7].nullPiece();
              break;
          case "e1c1":
              squares[0][3].setPiece(squares[0][0].getPiece());
              squares[0][0].nullPiece();
              break;
          case "e8g8":
              squares[7][5].setPiece(squares[7][7].getPiece());
              squares[7][7].nullPiece();
              break;
          case "e8c8":
              squares[7][3].setPiece(squares[7][0].getPiece());
              squares[7][0].nullPiece();
              break;
        }
      }
  }
  
  public void enPassant(Piece draggedPiece,Square squareFrom ,Square squareTo){
    if(draggedPiece instanceof Pawn && squareFrom.getColumn() != squareTo.getColumn() && squareTo.getPiece() == null)
        for(int i = 0; i < board.getAllPieces().size(); i++)
          if(draggedPiece.getPieceColor() == 'W' && board.getAllPieces().get(i).getSquare().getRow()+1 == squareTo.getRow() 
             && squareTo.getColumn() == board.getAllPieces().get(i).getSquare().getColumn()){
            board.getAllPieces().get(i).getSquare().nullPiece();
            board.getAllPieces().remove(i);
          }
          else if(draggedPiece.getPieceColor() == 'B' && board.getAllPieces().get(i).getSquare().getRow()-1 == squareTo.getRow() 
                 && squareTo.getColumn() == board.getAllPieces().get(i).getSquare().getColumn()){
            board.getAllPieces().get(i).getSquare().nullPiece();
            board.getAllPieces().remove(i);
          }
  }
  
  public boolean pawnPromotion(Piece draggedPiece){
    if(draggedPiece instanceof Pawn)
     if(squareTo.getRow() == 1 || squareTo.getRow() == 8){
       board.setShowPromotionPiece(true); 
       return false;
     }
     return true;
  }
  
  public void pawnPromotionEngine(Piece draggedPiece,Square squareTo,char piecePromotionType){
    if(draggedPiece instanceof Pawn){
        if(squareTo.getRow() == 1 || squareTo.getRow() == 8)
          choosePromotion(draggedPiece,squareTo,piecePromotionType,'B');
    }
  }
  
  public void choosePromotion(Piece draggedPiece, Square squareTo, char pieceType, char PieceColor){
    switch(pieceType){
        case 'q':
          for(int i = 0; i < board.getAllPieces().size(); i++)
            if(board.getAllPieces().get(i) == draggedPiece){
              board.getAllPieces().set(i,new Queen(PieceColor));
              squareTo.setPiece(board.getAllPieces().get(i));
            }
          break;
        case 'r':
           for(int i = 0; i < board.getAllPieces().size(); i++)
            if(board.getAllPieces().get(i) == squareTo.getPiece()){
              board.getAllPieces().set(i,new Rook(PieceColor));
              squareTo.setPiece(board.getAllPieces().get(i));
            }
          break;
        case 'n':
           for(int i = 0; i < board.getAllPieces().size(); i++)
            if(board.getAllPieces().get(i) == squareTo.getPiece()){
              board.getAllPieces().set(i,new Knight(PieceColor));
              squareTo.setPiece(board.getAllPieces().get(i));
             }
          break;
        case 'b':
           for(int i = 0; i < board.getAllPieces().size(); i++)
            if(board.getAllPieces().get(i) == squareTo.getPiece()){
              board.getAllPieces().set(i,new Bishop(PieceColor));
              squareTo.setPiece(board.getAllPieces().get(i));
            }
          break;
          
        default: break;
   }
  }
  
  
  public void engineMove(){
    Piece draggedPiece = null;
    Square squareFrom = null;
    Square squareTo = null;
    String moveFrom = bestMove.substring(0,2);
    String moveTo = bestMove.substring(2,4);
    
    for(Piece piece : board.getAllPieces())
      if((String.valueOf(piece.getSquare().getColumn())+Integer.toString(piece.getSquare().getRow())).equals(moveFrom)){
         draggedPiece = piece;
         squareFrom = piece.getSquare();
      }
        
     for(int row = 0; row < 8; row++)
      for(int col = 0; col < 8; col++)
        if((String.valueOf(squares[row][col].getColumn())+Integer.toString(squares[row][col].getRow())).equals(moveTo))
            squareTo = squares[row][col];     
    squareFrom.nullPiece();
    takePiece(squareTo); 
    enPassant(draggedPiece,squareFrom,squareTo);
    squareTo.setPiece(draggedPiece);
    castlingCheck(draggedPiece,moveFrom, moveTo);
    pawnPromotionEngine(draggedPiece,squareTo,bestMove.charAt(bestMove.length()-1));
    board.setMoveOppenentFrom(squareFrom);
    board.setMoveOppenentTo(squareTo);
    moves+= bestMove+" ";
    new Engine(moves,true,this);
    bestMove = null;
  }
  
  public void setEngineIsOn(boolean engineIsOn){
    this.engineIsOn = engineIsOn;
  }
  
  public void setMoveAvailable(ArrayList <String> moveAvailable){
     this.moveAvailable = moveAvailable;
  }
  
  public ArrayList <String> getMoveAvailable(){
     return moveAvailable;
  }
  
  public void setBestMove(String bestMove){
    this.bestMove = bestMove;
  }
  
  public void showPossibleMove(){ 
    boolean bool;
    ArrayList <String> ar = new ArrayList();
    if(moveAvailable!=null)
      for(int i = 0; i < moveAvailable.size(); i++){
        bool=true;
        if(ar.contains(moveAvailable.get(i).substring(0,2)))
          bool=false;  
        ar.add(moveAvailable.get(i).substring(0,2));
        if(moveAvailable.get(i).substring(0,2).equals(moveFrom))
         for(int sqRow = 0; sqRow < 8; sqRow++)
           for(int sqCol = 0; sqCol < 8; sqCol++){
             if((squares[sqRow][sqCol].getColumn() + Integer.toString(squares[sqRow][sqCol].getRow())).equals(moveAvailable.get(i).substring(2,4)))
               board.greenMoveAvailable(squareFrom,squares[sqRow][sqCol],bool);
           }
      }
  }
  
  public String getBestMove(){
    return bestMove;
  }
  
  public Square getSquareFrom(){
    return squareFrom;
  }
  
  public Piece getPieceCaptured(){
    return pieceCaptured;
  }
  
  public void setMoves(String moves){
     this.moves = moves;
  }
  
  public String getMoves(){
     return moves;
  }
  
  public String getResultGame(){
     return resultGame;
  }
  
  public void setResultGame(String resultGame){
     this.resultGame = resultGame;
  }
}
