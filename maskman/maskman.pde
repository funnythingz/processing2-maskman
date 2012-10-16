/**
* Maskman
*/
 
//import
import hypermedia.video.*;
import java.awt.Rectangle;
 
OpenCV opencv;
 
//propaty
int w = 800;
int h = 480;
 
PImage logo;
 
PImage redHuman;
PImage blueHuman;
PImage yellowHuman;
PImage pinkHuman;
PImage greenHuman;
 
boolean shutter = false;
int cAlpha = 255;
 
void setup(){
  size(w, h);
//  size(screenWidth/2, screenHeight/2);
  opencv = new OpenCV(this);
  opencv.capture(width, height);
  opencv.cascade(OpenCV.CASCADE_FRONTALFACE_ALT);
 
  redHuman =     loadImage("images/red.png");
  blueHuman =    loadImage("images/blue.png");
  yellowHuman =  loadImage("images/yellow.png");
  pinkHuman =    loadImage("images/pink.png");
  greenHuman =   loadImage("images/green.png");
}
 
void draw(){
  frameRate(60);
 
  opencv.read();
  Rectangle[] faces = opencv.detect(1.2, 2, OpenCV.HAAR_DO_CANNY_PRUNING, 40, 40);
  image(opencv.image(), 0, 0);
 
  for(int i = 0; i < faces.length; i++){
    switch(i){
      //red
      case 0:
        image(redHuman, faces[0].x, faces[0].y, faces[0].width, faces[0].height + (faces[0].height/8));
        break;
      //blue
      case 1:
        image(blueHuman, faces[1].x, faces[1].y, faces[1].width, faces[1].height + (faces[1].height/8));
        break;
      //yellow
      case 2:
        image(yellowHuman, faces[2].x, faces[2].y, faces[2].width, faces[2].height + (faces[2].height/8));
        break;
      //white
      case 3:
        image(pinkHuman, faces[3].x, faces[3].y, faces[3].width, faces[3].height + (faces[3].height/8));
        break;
      //black
      case 4:
        image(greenHuman, faces[4].x, faces[4].y, faces[4].width, faces[4].height + (faces[4].height/8));
        break;
    }
  }
 
  if(shutter){
    int posX = (w / 2);
    int posY = (h / 2);
    int fade = 15;
 
    cAlpha -= fade;
    noStroke();
    fill(255, 255, 255, cAlpha);
    rect(0, 0, w, h);
    if(cAlpha < fade){
      shutter = false;
      println("end");
    }
  }
  else{
    cAlpha = 255;
  }
}
 
void keyPressed(){
  if(key == 'c'){
    println("c");
    if(!shutter){
      shutter = true;
      saveFrame("cap_##.png");
    }
  }
}
 
void stop() {
    opencv.stop();
    super.stop();
}
