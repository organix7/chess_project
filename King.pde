class King extends Piece{
  King(char c){
    super('K',c);
    if(c == 'W')
      setPieceImg(new DnGImg(loadImage("WhiteKing.png"),this));
    else
      setPieceImg(new DnGImg(loadImage("BlackKing.png"),this));
  }
}
