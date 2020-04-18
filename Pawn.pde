class Pawn extends Piece{
  Pawn(char c){
    super('P',c);
    if(c == 'W')
      setPieceImg(new DnGImg(loadImage("WhitePawn.png"),this));
    else
      setPieceImg(new DnGImg(loadImage("BlackPawn.png"),this));
  }
}
