class DnGImg {
 
  private int x;
  private int y;
  private PImage pieceImg;
  private Piece piece;
 
  DnGImg(PImage pieceImg, Piece piece) { 
    this.pieceImg = pieceImg; 
    this.pieceImg.resize(100,100);
    this.piece = piece;
  }
 
 public void setPosition(int x,int y){
   this.x = x;
   this.y = y;
 } 
 
 public void clearPieceImg(){
   pieceImg = null;
 }
 
  public void display(){
    image(pieceImg, x, y);
  }
   
  public Piece isDragged() {
    if (mouseX > x && mouseY > y && mouseX < x + pieceImg.width && mouseY < y + pieceImg.height){    
      return piece;
    }
      return null;
  }
 
  public void mouseDragged() {
     x=mouseX-pieceImg.width/2; 
     y=mouseY-pieceImg.height/2;
  }
}
