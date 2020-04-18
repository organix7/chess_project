class Rook extends Piece{ 
  Rook(char c){
    super('R',c);
    if(c == 'W')
      setPieceImg(new DnGImg(loadImage("WhiteRook.png"),this));
    else
      setPieceImg(new DnGImg(loadImage("BlackRook.png"),this));
  }
}
