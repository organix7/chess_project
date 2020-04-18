class Game{
  
  private Board board;
  private WhitePlayer wP;
  private BlackPlayer bP;
  private Piece draggedPiece = null, promotionPiece = null;
  private Move move;
  
  Game(){
   board = new Board();
   wP = new WhitePlayer("White");
   bP = new BlackPlayer("Black");
   move = new Move(board,board.getSquares());
  }
  
  public Board getBoard(){
    return board;
  }
  
  public void begin(){
    board.startPosition(wP,bP);
  }
  
  public void refresh(){
   if(move.getResultGame()==null){
    if(!board.getShowPromotionPiece()){
     if(move.getBestMove()==null)
       board.refresh(move,draggedPiece);
     if(draggedPiece != null){ //update piece dragged
       draggedPiece.getPieceImg().display();
       draggedPiece.getPieceImg().mouseDragged();
     }
    }
    else
     board.displayChoosePiecesPromotion('W');
   }
   else
     board.displayFinish(move.getResultGame());
  }
  
  public void dragPiece(){
    if(!board.getShowPromotionPiece()){ 
      for (Piece piece : board.getAllPieces()) 
        if(piece.getPieceImg().isDragged() != null && piece.getPieceColor() == 'W')
          draggedPiece = piece.getPieceImg().isDragged();
      if(draggedPiece != null)
        move.moveFrom(draggedPiece);
      board.retry(wP,bP,move,game);
    }
    else         
      board.selectedPiecePromotion(move,promotionPiece, promotionPiece.getSquare()); 
  }
  
  public void releasePiece(){
    if(draggedPiece != null){
      if(move.moveTo(draggedPiece) && move.pawnPromotion(draggedPiece)){
        new Engine(move.getMoves(),false,move);
      }
      if(board.getShowPromotionPiece())
          promotionPiece = draggedPiece;
      draggedPiece = null;
    }
  }
  
  public Move getMove(){
    return move;
  }
  
   public void setMove(Move move){
    this.move = move;;
  }
}
