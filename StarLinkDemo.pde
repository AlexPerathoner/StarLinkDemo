PImage img;  // Declare variable "a" of type PImage


int maxHeight = 512;
int maxWidth = 1024;

  

SinWave[] waves;

int STEPS = 128;

void setup() {
  size(1024, 512);
  img = loadImage("Background.jpg");  // Load the image into the program
  image(img, 0, 0);
  
  waves = new SinWave[maxWidth/64];
  
  for(int i=0; i<maxWidth;i+=STEPS) {
    SinWave s = new SinWave(1, i);
    waves[i/STEPS] = s;
    
    strokeWeight(1);
    s.display();
  }
  frameRate(240);
  drawSatellites(n);
  
  
}

void setupOrbits() {
  for(int i=0; i<maxWidth;i+=STEPS) {
    waves[i/STEPS].display();
  }
}



int n = 0;

void draw() {
    image(img, 0, 0);
    setupOrbits();
    
    drawSatellites(n/4); //slow down with /
    drawPoints();
    
    drawPath();
    n++;
}

Point[] ptsPath = new Point[20];

Point ptA;
Point ptB;

boolean lastModifiedIsB = false;

void drawPoints() {
  strokeWeight(20);
  stroke(20,250,255);
  fill(255);
  textSize(32);
  if(ptA != null) {
    point(ptA.x, ptA.y);
    text("A", ptA.x, ptA.y); 
  }
  if(ptB != null) {
    point(ptB.x, ptB.y);
    text("B", ptB.x, ptB.y);
  } 
}


void drawPath() {
  if(ptA == null || ptB == null) {return;}
  strokeWeight(2);
  
  ptsPath = new Point[20];
  Point c = new Point(0,0);
  Point old = ptA;
  ptsPath[0] = old;
  int nPt=0;
  while(c != ptB) {
    c = findNextPoint(old, ptB);
    //println("Added point " + c.x + " " + c.y + " was " + old.x + " " + old.y + "\n");
    ptsPath[nPt+1] = c;
    line(old.x, old.y, c.x, c.y);
    old = c;
    nPt++;
  }
  
  
}



Point findNextPoint(Point fromA, Point toB) {
  Point nearestPt = toB;
  double bestDistB = 3000;
  double bestDistA = 3000;
  double dist = findDistanceSquared(fromA, toB);

  for(int i=0; i<pts.length; i++) {
    for(int j=0; j<pts[i].length; j++) {
      double distB = findDistanceSquared(pts[i][j], toB);
      double distA = findDistanceSquared(pts[i][j], fromA);
      if(distA + distB < dist && fromA != pts[i][j] && distA < 8193) {
        dist = distA + distB;
        nearestPt = pts[i][j];

      }   
    }
  }
  
  return nearestPt;
}

double findDistanceSquared(Point a, Point b) {
  return Math.pow(Math.abs(a.x-b.x), 2.0) + Math.pow(Math.abs(a.y-b.y), 2.0); 
}



Point[][] pts = new Point[8][20];

void drawSatellites(int istant) {
  strokeWeight(10);
  int k=0;
  for(int orbitN=0; orbitN<maxWidth/STEPS; orbitN++) { //for each orbit
    //stroke(255/(orbitN+1),255,255);
    
    k+=7; //satellites won't crash into each other
    int s=0;
    for(int i=0; i<400; i+=20) { //multiple satellites
      point((int)(((istant+i+k)*2.56)%maxWidth), waves[orbitN].getY((int)((istant+i+k))));
      pts[orbitN][s] = new Point((int)(((istant+i+k)*2.56)%maxWidth), waves[orbitN].getY((int)((istant+i+k))));
      s++;
    }
  }
}



void mouseClicked() {
  if(lastModifiedIsB) {
     ptB = new Point(mouseX, mouseY);
     lastModifiedIsB = false;
  } else {
     ptA = new Point(mouseX, mouseY);
     lastModifiedIsB = true;
  }
}






class Point {
  public int x, y;
  Point(int x, int y) {
    this.x = x;
    this.y = y;
  }
}








class SinWave {
  private static final int SCALEFACTOR = 200;

  private int cycles;
  private int points;

  private double[] sines;
  private int offsetX;

  private int[] pts;

  SinWave(int cycles, int offset) {
    setCycles(cycles);
    offsetX = offset;
  }

  public void setCycles(int newCycles) {
    cycles = newCycles;
    points = SCALEFACTOR * cycles * 2;
    sines = new double[points];
    for (int i = 0; i < points; i++) {
      double radians = (Math.PI / SCALEFACTOR) * i;
      sines[i] = Math.sin(radians);
    }
    create();
  }
  
  void create() {
    pts = new int[points];
    for (int i = 0; i < points; i++) {
      pts[i] = (int) (sines[i] * maxHeight / 2 * .80 + maxHeight / 2);
    }
    
  }

  void display() {
    double hstep = (double) maxWidth / (double) points;
    
    stroke(255);
    strokeWeight(1);
    for (int i = 1; i < points; i++) {
      int x1 = ((int) ((i - 1) * hstep)+offsetX)%maxWidth;
      int x2 = ((int) (i * hstep)+offsetX)%maxWidth;
      if(x2 != 0) {
        int y1 = pts[i - 1];
        int y2 = pts[i];
        line(x1, y1, x2, y2);
      }
    }
  }
  
  int getY(int forX) {
    return pts[(int(forX+offsetX/2.56))%(points)];
  }
  
  
}
