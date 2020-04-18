import java.io.*;
Game game;

void setup()
{
  fullScreen();
  frameRate(120);
  game = new Game();
  game.begin();
}

void draw(){
  game.refresh(); 
}

void mousePressed() { //Get the dragged piece
  game.dragPiece();
}
 
void mouseReleased() { //release the piece
  game.releasePiece();
}
