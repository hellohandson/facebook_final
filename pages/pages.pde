//Book pages

import processing.net.*;
//from API
Client c;
String input;
int data[];
PFont font;
import processing.video.*;
Movie myMovie;

String para1 = "";
String para2 = "She couldn’t remember the last time she got on the train without getting budged on the side. ";
String para3 = "";
String para4 = "She sighed. Listening to Apparat made her disconnected from the world.";
String para5 = "";
String para6 = "“What’s on your mind?” He asked.";
String para7 = "“What is the point of existence? When we are just doing what society tells us?” She thought out loud.";
String para8 = "She looked up and noticed how everyone was looking down at their mobile phones. Nobody had noticed her.";
String para9 = "Beep. “Yeah. I wonder too. Sometimes it makes me want to quit my job.”";
String para10 = "It was not the first time she has heard that. She looked through her iCalendar.";
String para11 = "“I’m thinking how I should spend my birthday. Another year older, another year gone.”";
String para12 = "“Oh how can I forget. I have locked down 23 February, your celebratory worthy day.”";
String para13 = "";
String para14 = "She grinned. “That was probably automated from Facebook Birthdays.”";
String para15 = "“You underestimate me, ______(name). I know a lot of things.”";
String para16 = "She smiled, and felt a little more upbeat. It was strange how technology was bringing her closer to someone.";
String para17 = "";
String para18 = "“How about I get Amazon to send you a birthday surprise? Perhaps, something _______(ethnicity) from _____(hometown)?”";
String para19 = "";
String para20 = "“Come on, get me something more relevant to what I do for a living. Maybe that would make my life more purposeful.”";
String para21 = "“…Fine. You are taking me for granted, _____(name). But I shall find you something on eBay related to uhm, ________(activity).";
String para22 = "She got off the train and walked home. She sat down on a bench and opened up The Da Vinci Code. She had stopped in the middle of chapter 20.";
String para23 = "“Have you arrived in __________(location) yet?”";
String para24 = "Indeed, she was sitting in the middle of her neighbourhood.";
String para25 = "It was late at night, yet people were rushing all the time. Everyone seemed to have a destination.";
String para26 = "“Yes. I miss you, ______(insert friends name).”";
String para27 = "“I miss you too, ______(name). …Although the last time I saw you was while you were sleeping.”";
String para28 = "She felt something amiss.";
String para29 = "“What are you talking about,  ______(insert friends name)?”";
String para30 = "“No, I’m not ______(friends name). But I’m with him right now.”";
String para31 = "";
String para32 = "She typed frantically, “Who the hell are you?” And quickly looked up ______(friends name) on the Facebook chat.";
String para33 = "“I’m your big brother, _____(full name).”";
String para34 = "Eyes widened, she looked back up into the dark sky in shock.";
String para35 = "____(friends name) was tracking her. No, it can’t be. Was this a prank?";
String para36 = "She slammed her book and dashed to her apartment.";
String para37 = "";
String para38 = "Frantically searching for her keys, she opened her apartment door.";
String para39 = "Beep. “You can’t hide from me, _______(name).”";
String para40 = "I’m dreaming, I’m dreaming, I’m dreaming.";
String para41 = "";
String para42 = "She locked the bathroom door and splashed water onto her face.";
String para43 = "And looked into the mirror.";


String incomingData = "";

void setup() {
  size(displayWidth, displayHeight);  
  font = createFont("Baskerville",50,true);
  textFont(font);
  c = new Client(this, "127.0.0.1", 12345);
  frameRate(5);
  myMovie = new Movie(this, "crowd.mp4");
  myMovie.play();
  myMovie.loop();
}

void draw(){
  
  if (c.available() > 0) {
    input = c.readString();
    if (incomingData != input) {
      incomingData = input;

      String[] list = split(input, "|");
      String[] data = split (list[1], ".");

      println("marker ID : " + list[0]);
      println("user info : " + list[1]);

      String markerID = list[0];
      String chars = list[1];
     
     if (int(markerID) != 0){ 
      background(0); 
      fill(255);  
      String toDisplay = "";
      String toDisplay2 = "";
      switch(int(markerID)) {
        case 1: 
          toDisplay = para1.replace("{{gender1}}", data[0]);
          toDisplay2= para2.replace("{{gender1}}", data[0]);
          break;
        case 2: 
          toDisplay = para3;
         // toDisplay2 = para4.replace(“{{gender1}}”, data[0]); 
         // toDisplay2 = toDisplay2.replace(“{{gender2}}”, data[1]);
         // para4.replace("{{gender1}}", removeUnderscore(data[1]));
          break;
        case 3: 
          toDisplay = para5;
          toDisplay2 = para6;   
          image(myMovie, 0, 0);    
          break;
        case 4: 
          toDisplay = para7;
          toDisplay2 = para8;
          break;
        case 5: 
          toDisplay = para9;
          toDisplay2 = para10;
          break;
        case 6: 
          toDisplay = para11;
          toDisplay2 = para12;
          break;
        case 7: 
          toDisplay = para13;
          toDisplay2 = para14;
          break;  
        case 8: 
          toDisplay = para15;
          toDisplay2 = para16;
          break;
        case 9: 
          toDisplay = para17;
          toDisplay2 = para18;
          break;
        case 10: 
          toDisplay = para19;
          toDisplay2 = para20;
          break;
        case 11: 
          toDisplay = para21;
          toDisplay2 = para22;
          break;
        case 12: 
          toDisplay = para23;
          toDisplay2 = para24;
          break;
        case 13: 
          toDisplay = para25;
          toDisplay2 = para26;
          break;
        case 14: 
          toDisplay = para27;
          toDisplay2 = para28;
          break;
        case 15: 
          toDisplay = para29;
          toDisplay2 = para30;
          break;
        case 16: 
          toDisplay = para31;
          toDisplay2 = para32;
          break;  
        case 17: 
          toDisplay = para33;
          toDisplay2 = para34;
          break; 
        case 18: 
          toDisplay = para35;
          toDisplay2 = para36;
          break;  
        case 19: 
          toDisplay = para37;
          toDisplay2 = para38;
          break;  
        case 20: 
          toDisplay = para39;
          toDisplay2 = para40;
          break;  
        case 21: 
          toDisplay = para41;
          toDisplay2 = para42;
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

String removeUnderscore (String input) {
  return input.replace("_", " ");
}

void movieEvent(Movie m) {
  m.read();
}


