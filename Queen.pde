class Queen extends Piece{ 
  Queen(char c){
    super('Q',c);
    if(c == 'W')
      setPieceImg(new DnGImg(loadImage("WhiteQueen.png"),this));
    else
      setPieceImg(new DnGImg(loadImage("BlackQueen.png"),this));
  }
}
