class Bishop extends Piece{
  Bishop(char c){
    super('B',c);
    if(c == 'W')
      setPieceImg(new DnGImg(loadImage("WhiteBishop.png"),this));
    else
      setPieceImg(new DnGImg(loadImage("BlackBishop.png"),this));
  }
}
