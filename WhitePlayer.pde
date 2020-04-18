class WhitePlayer{

  private ArrayList <Piece> pieces = new ArrayList();
  private String pseudo;
  
  WhitePlayer(String pseudo){
    this.pseudo = pseudo;
  }
  
  public ArrayList <Piece> getPieces(){
    return pieces;
  }
  
  public Piece getPieceDragged(){
   for (Piece piece : pieces) 
    if(piece.getPieceImg().isDragged() != null)
      return piece.getPieceImg().isDragged();
   return null;
  }
}
