class Piece {
  
  private char pieceType;
  private char pieceColor;
  private DnGImg pieceImg;
  private Square square;
  
  Piece(char pieceType, char pieceColor){
    this.pieceType = pieceType;
    this.pieceColor = pieceColor;
  }
  
  public char getPieceColor(){
    return pieceColor;
  }
  
  public char getPieceType(){
    return pieceType;
  }
  
  public Square getSquare(){
    return square;
  }
  
  public void setSquare(Square square){
    this.square = square;
  }
  
  public void setPieceImg(DnGImg pieceImg){
    this.pieceImg = pieceImg;
  }
  
  public DnGImg getPieceImg(){
    return pieceImg;
  }
}
