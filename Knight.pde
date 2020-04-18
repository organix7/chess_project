class Knight extends Piece{ 
  Knight(char c){
    super('N',c);
    if(c == 'W')
      setPieceImg(new DnGImg(loadImage("WhiteKnight.png"),this));
    else
      setPieceImg(new DnGImg(loadImage("BlackKnight.png"),this));
  }
}
