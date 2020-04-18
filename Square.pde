class Square{

  private int x,y,row;
  private char column;
  private Piece piece;
  
  Square(int x, int y, char column, int row){
    this.x = x;
    this.y = y;
    this.column = column;
    this.row = row;
  }
  
  void setPiece(Piece piece){
    this.piece = piece;
    this.piece.setSquare(this);
    this.piece.getPieceImg().setPosition(x,y);
  }
  
  public void nullPiece(){
    piece = null;
  }
  
  Piece getPiece(){
    return this.piece;
  }
  
  int getX(){
    return x;
  }
  int getY(){
    return y;
  }
  int getRow(){
    return row;
  }
  char getColumn(){
    return column;
  }
}
