class Board{

  private Square[][] squares = new Square [8][8];
  private ArrayList <Piece> allPieces;
  private boolean showPromotionPiece = false;
  private Square moveOppenentFrom,moveOppenentTo;
  private PImage retryImg = loadImage("Retry.png"),bg = loadImage("background.jpg"), winImg = loadImage("you_win.png"), loseImg = loadImage("you_lose.png"), drawImg = loadImage("draw.png");
  private PFont myFont;
  
  Board(){
    int coordX = width/2-400;
    int coordY = height/2+300;
    bg.resize(width,height);

    //Create coordinate of squares
    for(int sqRow = 0; sqRow < 8; sqRow++)
     for(int sqCol = 0; sqCol < 8; sqCol++)
      squares[sqRow][sqCol] = new Square(coordX+(sqCol)*100,coordY-(sqRow)*100,char(sqCol+97),sqRow+1);
    displayBoard();
   }
  
  public void refresh(Move move,Piece draggedPiece){
     displayBoard();
     if(draggedPiece != null)
       move.showPossibleMove();
     if(moveOppenentFrom != null && moveOppenentTo != null)
       showMoveOppenent();
     try{
       for(int i=0; i<= allPieces.size()-1; i++)
         allPieces.get(i).getPieceImg().display();
     }
     catch(Exception e){
       e.printStackTrace();
     }
  }
  
   public void showMoveOppenent(){
    noStroke();
    fill(#CAE533,120);
    rect(moveOppenentFrom.getX(),moveOppenentFrom.getY(),100,100);
    rect(moveOppenentTo.getX(),moveOppenentTo.getY(),100,100);
   }
  
   public void greenMoveAvailable(Square squareFrom, Square squareTo,boolean bool){
    noStroke();
    fill(#347933,90);
    if(bool)
      rect(squareFrom.getX(),squareFrom.getY(),100,100);
    if(squareTo.getPiece() != null)
      rect(squareTo.getX(),squareTo.getY(),100,100,80);
    else
      ellipse(squareTo.getX()+50,squareTo.getY()+50,30,30);
  }
  
  public void startPosition(WhitePlayer wP, BlackPlayer bP){
     allPieces = new ArrayList();
    //add at player white player
      for(int i = 0; i<8; i++)
        wP.getPieces().add(new Pawn('W'));    
      wP.getPieces().add(new Rook('W')); 
      wP.getPieces().add(new Knight('W'));  
      wP.getPieces().add(new Bishop('W'));  
      wP.getPieces().add(new Queen('W'));  
      wP.getPieces().add(new King('W')); 
      wP.getPieces().add(new Bishop('W'));
      wP.getPieces().add(new Knight('W')); 
      wP.getPieces().add(new Rook('W')); 
                    
     //add at player black player
     for(int i = 0; i<8; i++)
        bP.getPieces().add(new Pawn('B'));    
      bP.getPieces().add(new Rook('B')); 
      bP.getPieces().add(new Knight('B'));  
      bP.getPieces().add(new Bishop('B'));  
      bP.getPieces().add(new Queen('B'));  
      bP.getPieces().add(new King('B')); 
      bP.getPieces().add(new Bishop('B'));
      bP.getPieces().add(new Knight('B')); 
      bP.getPieces().add(new Rook('B')); 
      
    
    //add in list
    for(Piece piece: wP.getPieces())
      allPieces.add(piece);

    for(Piece piece: bP.getPieces())
      allPieces.add(piece);
    
    //placed on board
    for(int i = 0; i<8; i++){
      squares[1][i].setPiece(allPieces.get(i));
      squares[6][i].setPiece(allPieces.get(i+16));
      squares[0][i].setPiece(allPieces.get(i+8));
      squares[7][i].setPiece(allPieces.get(i+24));
    }  
  }
  
   private void displayBoard(){
    background(bg);
    displayCoord();
    noStroke();
    for(int i=0;i<8;i++)
      for(int j=0;j<4;j++){
       if(i%2==0){
        fill(#f0d9b5);
        rect((width/2) - 400 + (j*200),(height/2) - 400 + (i*100),100,100);
        fill(#b58863);
        rect((width/2) - 300 + (j*200),(height/2) - 400 + (i*100),100,100);
      }
       else{
        fill(#f0d9b5);         
        rect((width/2) - 300 + (j*200),(height/2) - 400 + (i*100),100,100);
        fill(#b58863);
        rect((width/2) - 400 + (j*200),(height/2) - 400 + (i*100),100,100);
      }
    }
    fill(#B9BC33);
    myFont = createFont("Arial Bold", 80);
    textFont(myFont);
    text("Retry",(width/2+565),(height/2)-160);
    stroke(1);
    fill(#D4AF37);
    rect((width/2)+595, (height/2)-100, 130, 130,50);
    fill(#b97455);
    rect((width/2)+600, (height/2)-95, 120, 120,50);
    if(mouseX > (width/2)+600 && mouseY > (height/2)-95 && mouseY < (height/2)+25 && mouseX < (width/2)+720)
      image(retryImg,(width/2) + 610,(height/2)-85,95,95);
    else
      image(retryImg,(width/2) + 620,(height/2)-75,75,75);
  } 
  
  public void displayFinish(String result){
    stroke(1);
    fill(#D4AF37);
    rect((width/2)-65, (height/2)-5, 130, 130,50);
    fill(#b97455);
    rect((width/2)-60, (height/2), 120, 120,50);
    if(result.equals("You Lose"))
     image(loadImage("you_lose.png"),(width/2-290),(height/2)-230);  
    else if(result.equals("You Win"))
     image(loadImage("you_win.png"),(width/2-270),(height/2)-230);   
    else
     image(loadImage("draw.png"),(width/2-290),(height/2)-230);


    if(mouseX > (width/2)-57.5 && mouseY > (height/2)-10 && mouseY < (height/2)+115 && mouseX < (width/2)+45)
      image(retryImg,(width/2) - 50,(height/2)+10,95,95);
    else
      image(retryImg,(width/2) - 37.5,(height/2)+20,75,75);
  }
  
  public void retry(WhitePlayer wP, BlackPlayer bP,Move move,Game game){
    int coordX = width/2-400;
    int coordY = height/2+300;
    
    if(mouseX > (width/2)+600 && mouseY > (height/2)-95 && mouseY < (height/2)+25 && mouseX < (width/2)+720 || 
       (mouseX > (width/2)-57.5 && mouseY > (height/2)-10 && mouseY < (height/2)+115 && mouseX < (width/2)+45 && move.getResultGame()!=null)){
      wP.getPieces().clear();
      bP.getPieces().clear();
      squares = new Square [8][8];
      
      for(int sqRow = 0; sqRow < 8; sqRow++)
       for(int sqCol = 0; sqCol < 8; sqCol++)
        squares[sqRow][sqCol] = new Square(coordX+(sqCol)*100,coordY-(sqRow)*100,char(sqCol+97),sqRow+1);
        
      game.setMove(new Move(this,squares));
      startPosition(wP,bP);
      moveOppenentFrom = null;
      moveOppenentTo = null;
      move.setResultGame(null);
    }
  }
  
  public void displayChoosePiecesPromotion(char pieceColor){
    stroke(1);
    fill(#D4AF37);
    rect((width/2) - 240 , (height/2)-110, 480, 220,50);
    fill(#b97455);
    rect((width/2) - 230 , (height/2)-100, 460, 200,50);
    if(pieceColor=='W'){
      image(loadImage("WhiteKnight.png"),(width/2) - 220,(height/2)-50,100,100);
      image(loadImage("WhiteBishop.png"),(width/2) - 105,(height/2)-50,100,100);
      image(loadImage("WhiteQueen.png"),(width/2) + 10,(height/2)-50,100,100);
      image(loadImage("WhiteRook.png"),(width/2) + 125,(height/2)-50,100,100);
    }
    else{
      image(loadImage("WhiteKnight.png"),(width/2) - 220,(height/2)-50,100,100);
      image(loadImage("WhiteBishop.png"),(width/2) - 105,(height/2)-50,100,100);
      image(loadImage("WhiteQueen.png"),(width/2) + 10,(height/2)-50,100,100);
      image(loadImage("WhiteRook.png"),(width/2) + 125,(height/2)-50,100,100);
    }
    noFill();
    for(int i=0; i<4; i++)
    if(mouseX > (width/2)-220+(115*i) && mouseY > height/2-50 && mouseY < height/2+50 && mouseX < (width/2)-105+(115*i))
       rect((width/2)-220+(115*i),(height/2)-50,100,100);      
  }  
  
  public void selectedPiecePromotion(Move move,Piece promotionPiece, Square squareTo){
    char pieceTypePromotion = ' ';
    
    if(mouseX > (width/2)-220 && mouseY > height/2-50 && mouseY < height/2+50 && mouseX < (width/2)-105)
      pieceTypePromotion = 'n';
    else if(mouseX > (width/2)-105 && mouseY > height/2-50 && mouseY < height/2+50 && mouseX < (width/2)+10)
      pieceTypePromotion = 'b';
    else if(mouseX > (width/2)+10 && mouseY > height/2-50 && mouseY < height/2+50 && mouseX < (width/2)+125)
      pieceTypePromotion = 'q';
    else if(mouseX > (width/2)+125 && mouseY > height/2-50 && mouseY < height/2+50 && mouseX < (width/2)+240)
      pieceTypePromotion = 'r';
    
    if(pieceTypePromotion == ' '){
      squareTo.nullPiece();
      move.getSquareFrom().setPiece(promotionPiece);
      squareTo.setPiece(move.getPieceCaptured());
      allPieces.add(move.getPieceCaptured());
      String moves = move.getMoves().substring(0,move.getMoves().lastIndexOf(" "));
      move.setMoves(moves.substring(0,moves.lastIndexOf(" "))+" "); 
      println(move.getMoves());
    }
    else{
      move.choosePromotion(promotionPiece,squareTo, pieceTypePromotion, 'W');
      move.setMoves(move.getMoves().substring(0,move.getMoves().length()-1)+ pieceTypePromotion+" ");
      new Engine(move.getMoves(),false,move);
    }
    showPromotionPiece = false;
  }
  
  private void displayCoord(){
    stroke(1);
    fill(#735041);
    rect((width/2) - 450,(height/2) - 450,900,900);
    noFill();
    rect((width/2) - 401,(height/2) - 401,801,801);
    fill(0);
    myFont = createFont("Arial", 25);
    textFont(myFont);
    
    for(int i=0;i<8;i++){
      text(8-i,(width/2) - 432,(height/2) - 340 + (i * 100));
      text(char(65+i),(width/2) - 360 + (i * 100),(height/2) + 435);
    }
    fill(255);
    myFont = createFont("Arial", 50);
    textFont(myFont);
    text("By Guigui",width - 360,height-100);
  }
  
  public void setShowPromotionPiece(boolean showPromotionPiece){
    this.showPromotionPiece = showPromotionPiece;
  }
  
  public boolean getShowPromotionPiece(){
    return showPromotionPiece;
  }
  
  public ArrayList <Piece> getAllPieces(){
    return allPieces;
  }
  
  public Square[][] getSquares(){
    return squares;
  }
  
  public void setMoveOppenentFrom(Square moveOppenentFrom){
    this.moveOppenentFrom = moveOppenentFrom;
  }
  
  public void setMoveOppenentTo(Square moveOppenentTo){
    this.moveOppenentTo = moveOppenentTo;
  }
}  
  
