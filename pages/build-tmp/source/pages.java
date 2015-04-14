import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.net.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class pages extends PApplet {

//Book pages


//from API
Client c;
String input;

int data[];

PFont font;

String para1 = "\"What's on your mind?\" He asked {{name}}";
String para2 = "She paused, and tapped her fingers on the keyboard.";
String para3 = "Well. It\u2019s my birthday today... She pondered and hit enter.";
String para4 = "Happy birthday my dear! {{date}} is your special day. What are your plans?";
String para5 = "I might just stay at home and have pizza.";
String para6 = "How about I get Amazon to send you a birthday surprise to you?";
String para7 = "Wait. How did you know where I live?";
String para8 = "I know a lot things. Anyway come on, turning __ isn\u2019t that bad.";
String para9 = "She switched the screen off. How could he have known?";

String incomingData = "";

public void setup() {
  size(displayWidth, displayHeight);  
  font = createFont("Baskerville",50,true);
  textFont(font);
  c = new Client(this, "127.0.0.1", 12345);
  frameRate(5);
}

public void draw(){
  
  
  if (c.available() > 0) {
    input = c.readString();
    if (incomingData != input) {
      incomingData = input;

      String[] list = split(input, "|");
      String[] data = split (list[1], "^");

      println("marker ID : " + list[0]);
      println("user info : " + list[1]);

      String markerID = list[0];

      String chars = list[1];
     
     if (PApplet.parseInt(markerID) != 0){

       
      background(0); 
      fill(255);  

      String toDisplay = "";
      String toDisplay2 = "";
      switch(PApplet.parseInt(markerID)) {
        case 1: 
          toDisplay = para1.replace("{{name}}", removeUnderscore(data[1]));
          toDisplay2= para2;
          break;
        case 2: 
          toDisplay = para3;
          toDisplay2 = para4.replace("{{date}}", data[1]);
          break;
        case 3: 
          toDisplay = para5;
          toDisplay2 = para6;
          break;
        case 4: 
          toDisplay = para7;
          toDisplay2 = para8;
          break;
        case 5: 
          toDisplay = para9;
          toDisplay2 = "";
          break;
        default:          
          break;
      }
        
        //you can use toDisplay
        

      text(toDisplay, 150, 200, 550, 900);
      text(toDisplay2, 800, 200, 550, 900);  
      }

    }
   
  }
  
}

public String removeUnderscore (String input) {
  return input.replace("_", " ");

}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "pages" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
