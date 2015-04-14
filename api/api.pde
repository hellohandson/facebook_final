//server
import rekognition.faces.*;
import processing.video.*;
import gab.opencv.*;
import http.requests.*;
import java.awt.Rectangle;
import processing.net.*;
import jp.nyatla.nyar4psg.*;

OpenCV opencv;
Capture cam;

Server s;
Client c;
String input;
int data[];

// We will need a smaller image for fast real-time detection
PImage smaller;
PImage img;

int openCVScale = 4;  // Scale Capture to OpenCV
float windowScale;    // Window to Capture
float scl;            // Overall scale for drawing faces


Rekognition rekog;
FaceDetector detector;
// For the user to type in their name
// This is awkard and needs to be improved
String typed = "";

int vw = 640;
int vh = 480;

//
// Marker varibles
String patternPath = "/Users/handson/Documents/Handson/10_code/facebook/facebook_final/api/markers/";
MultiMarker nya;
int cr,cg,cb;
int recogniseMarkerID = 0;

String recogniseName = "";

void setup() {
  size(vw, vh, P3D);

  windowScale = width/float(vw);
  scl = windowScale * openCVScale;

  cam = new Capture(this, vw, vh);
  cam.start();

  // OpenCV object
  opencv = new OpenCV(this, vw/openCVScale, vh/openCVScale);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE); 

  // Scaled down image
  smaller = createImage(opencv.width, opencv.height, RGB);
  // Larger capture object

  // Setting up Rekognition API
  String[] keys = loadStrings("key.txt");
  String k = keys[0];
  String secret = keys[1];
  rekog = new Rekognition(this, k, secret);
  // You can have different databases of faces for different applications
  rekog.setNamespace("demo2");
  rekog.setUserID("processing");

  // A generic time-based face detector
  detector = new FaceDetector();
  
  frameRate(12); // Slow it down a little
  s = new Server(this, 12345); // Start a simple server on a port

  nya=new MultiMarker(this,vw, vh,"camera_para.dat",NyAR4PsgConfig.CONFIG_PSG);
  nya.addARMarker("patt.hiro",80);
  nya.addARMarker(patternPath+"01.patt",80);
  nya.addARMarker(patternPath+"02.patt",80);
  nya.addARMarker(patternPath+"03.patt",80);
  nya.addARMarker(patternPath+"04.patt",80);
  nya.addARMarker(patternPath+"05.patt",80);
  nya.addARMarker(patternPath+"06.patt",80);
  nya.addARMarker(patternPath+"07.patt",80);
  nya.addARMarker(patternPath+"08.patt",80);
  nya.addARMarker(patternPath+"09.patt",80);
  nya.addARMarker(patternPath+"10.patt",80);
  nya.addARMarker(patternPath+"11.patt",80);
  nya.addARMarker(patternPath+"12.patt",80);
  nya.addARMarker(patternPath+"13.patt",80);
  nya.addARMarker(patternPath+"14.patt",80);
  nya.addARMarker(patternPath+"15.patt",80);
  nya.addARMarker(patternPath+"16.patt",80);
  nya.addARMarker(patternPath+"17.patt",80);
  nya.addARMarker(patternPath+"18.patt",80);
  nya.addARMarker(patternPath+"19.patt",80);
  nya.addARMarker(patternPath+"20.patt",80);
  nya.addARMarker(patternPath+"21.patt",80);
  cr=cg=cb=100;
}

void captureEvent(Capture cam) {
  //cam.read();
}

void draw() {

  if (cam.available() !=true) {
    return;
  }
  background(0);
  cam.read();
  smaller.copy(cam, 0, 0, cam.width, cam.height, 0, 0, smaller.width, smaller.height);
  smaller.updatePixels();
  // Scale down video and pass to OpenCV
  
  opencv.loadImage(smaller);

  // Get an array of rectangles and send to the detector
  Rectangle[] faces = opencv.detect();
  detector.detect(faces);

  // Draw the faces
  detector.showFaces();
  // Check for any requests to Rekognition API
  detector.checkRequests();
  // Check to see if user is rolling over faces
  detector.rollover(mouseX, mouseY);
  
  
  //image(cam, 0, 0);
  //cam.read();
  nya.detect(cam);
  //background(0);
  nya.drawBackground(cam);
  
  //
  //
  int tempMarker = 0;
  if(nya.isExistMarker(0)){
    // execute marker scripts here
    //set the recogniseMarkerID to what ever number you want when it recognises the corresponding marker
    //tempMarker = 1;
  }
  for (int i=0; i<20; i++) {
    if (nya.isExistMarker(i)) {
      tempMarker = i+1;
    }
  }
  println(str(tempMarker));

  //s.write(name);
  String tempName = detector.nameString;
  
  if (recogniseMarkerID != tempMarker || recogniseName != tempName) {

    recogniseMarkerID = tempMarker;
    recogniseName = tempName;

    // combining the data to send over the server

    String sendString = "";
    sendString += str(recogniseMarkerID);
    // use the | symbol as a delimiter to separate the data, note that you cannot use that symbol in the face info if not it'll screw up;
    sendString += "|";
    sendString += tempName;

    s.write(sendString);
  }
  
  

}

void mousePressed() {
  // Check to see if user clicked on a face
  detector.click(mouseX, mouseY);
}

void keyPressed() {

  // This should really be improved, super basic keyboard input for name
  if (detector.selected) {
    if (key == '\n') {
      detector.enter(typed, true);
      typed = "";
    } 
    else if (key == 8) {
      if (typed.length() > 0) {
        typed = typed.substring(0, typed.length()-1);
      }
      detector.enter(typed, false);
    }
    else if (key > 31 && key < 127) {
      typed = typed + key;
      detector.enter(typed, false);
    }
  }
}



