
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
