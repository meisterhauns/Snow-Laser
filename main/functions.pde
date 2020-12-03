

//setup


public float[][] setupStars(int amount) {
    float[][] stars = new float[amount][2];
    for (int i=0; i < stars.length; i++) {
        stars[i][0] = random(0, 1);
        stars[i][1] = random(0,0.9);
    }
    return stars;
}

public Snowflake[] setupSnowflakes(Snowflake[] sf, int wind) {
    for (int i = 0; i < sf.length; i++) {
        sf[i] = new Snowflake(random(-0.2 * width - 10*abs(wind), 1.2 * width + 10*abs(wind)), random(height*(-1), 0), random(0.1, 5));
        //--optinal: print snowflake data
        //println(sf[i].getX1() + " | " + sf[i].getY1() + " | " + sf[i].getSize());
    }
    return sf;
}




//generate


public Snow generateSnow(float msl, int sp) {
    return new Snow(random(0.0, width), random(height - msl - 3*sp, height - 0.1*msl - 3*sp), (int)random(0,3), random(7*sp,21*sp));
}

public void renewSnowflakes(Snowflake[] sfs, int wind) {
    for (int i = 0; i < sfs.length; i++) {
        if (sfs[i].getY2() > height){
            sfs[i] = new Snowflake(random(-0.2 * width - 10*abs(wind), 1.2 * width + 10*abs(wind)), random(height*(-1), 0), random(0.1, 5));
        }
    }
}




//delete


public void deleteSnow(Snow[] snow){
    for (Snow s : snow) {
        if (minDistanceToMouse(s.getX(),s.getY()) < 60) {
            //remove by setting size to 0
            s.setSize(0);
        }
    }
}




//calculate


public float checkMaxSnowLayer(Snow s, float msl) {
    if (s.getY() < height - msl){
        if (msl >= height){
            msl = height;
        } else {
            msl = height - s.getY();
        }
    }
    return msl;
    
}

public float minDistanceToMouse(float f1, float f2, float f3, float f4){
    return min(sqrt(pow((f1 - mouseX), 2) + pow((f2 - mouseY), 2)),sqrt(pow((f3 - mouseX), 2) + pow((f4 - mouseY), 2)));
}

public float minDistanceToMouse(float f1, float f2){
    return sqrt(pow((f1 - mouseX), 2) + pow((f2 - mouseY), 2));
}




//colorize


public void colorize(Snowflake sf){

    float m = minDistanceToMouse(sf.getX1(), sf.getY1(), sf.getX2(), sf.getY2());

    //different colors for different distances
    if (m < 15) {
        sf.setColor(color(#ff0000));
    } else if (m < 30) {
        sf.setColor(color(#695271));
    } else if (m < 45) {
        sf.setColor(color(#695271));
    } else if (m < 60) {
        sf.setColor(color(#083051));
    } else {
        sf.setColor(color(29, 48, 67, 127 + (sf.getSize()/2)*128));
    }
}

public void colorize(Snow s){
    float m = minDistanceToMouse(s.getX(), s.getY());

    //different colors for different distances
    if (m < 15) {
        s.setColor(color(#ff0000));
    } else if (m < 30) {
        s.setColor(color(#695271));
    } else if (m < 45) {
        s.setColor(color(#695271));
    } else if (m < 60) {
        s.setColor(color(#083051));
    } else {
        if (s.colorEquals(color(#142332))) {
            s.setColor(color(#142332));
        } else if (s.colorEquals(color(#1d3043))) {
            s.setColor(color(#1d3043));
        } else if (s.colorEquals(color(#18222d))) {
            s.setColor(color(#18222d));
        } else if (s.colorEquals(color(#121b25))) {
            s.setColor(color(#121b25));
        } else {
            s.setRandomColor();
        }
    }
}




//mouse actions


public void mouseWheel(MouseEvent e){
    wind = e.getCount()*3;
}

public int mouseActions(Snow[] snow, int wind) {
    if (mousePressed && (mouseButton == RIGHT)) {
        wind = 0;
    }
    if (mousePressed && (mouseButton == LEFT)) {
        deleteSnow(snow);
    }
    return wind;
}

public void changeCursor(){
    if((mouseX > 0 && mouseX < width-1) && (mouseY > 0 && mouseY < height-1)){
        noCursor();
    } else {
        cursor(ARROW);
    }
}

public void mouseMoved() {
    if(frameCount > 50){
        endInstructions = true;
    }
}