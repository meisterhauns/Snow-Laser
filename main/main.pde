/*

Object oriented programming Snow Generator

Laser all snow away!

Controls:
left click: laser
mouse wheel: wind direction
right click: reset wind

*/



//editable constants
static final int amountOfSnowflakes = 25000;
static final int windowWidth = 1280;
static final int windowHeight = 720;
static final int snowSpawnrate = 1; //lower is faster but draws more particles
static final int amountOfStars = 10;

//do not edit
static final float RAD = 60;
Snowflake[] snowflakes = new Snowflake [amountOfSnowflakes];
Snow[] snow = new Snow[0];
float[][] stars;

float maxSnowLayer = 0;
int timer = 0;
int wind = 0;
boolean endInstructions = false;


public void settings() {
    size(windowWidth, windowHeight, P2D);
    fullScreen();
}


public void setup() {
    background(20);
    noCursor();
    stars = setupStars(amountOfStars);
    snowflakes = setupSnowflakes(snowflakes, wind);
}


public void draw(){

    background(#050017);

    renewSnowflakes(snowflakes, wind);

    if (timer >= snowSpawnrate){
        Snow s = generateSnow(maxSnowLayer, snowSpawnrate);
        snow = (Snow[])append(snow, s);
        timer = 0;
        //--optional: print snow data
        //println("snow amount: " + snow.length + " | max H: " + (height - maxSnowLayer) + " | location: " + s.getX() + " : " + s.getY());
        maxSnowLayer = checkMaxSnowLayer(s, maxSnowLayer);
    }

    changeCursor();
    wind = mouseActions(snow, wind);

    drawSky(stars);
    drawSnowSnowflakes(snowflakes, snow, wind);
    drawCar();
    drawText(endInstructions);

    timer++;
}