public void drawText(boolean b){
    if (!b){
        noStroke();
        fill(#050017);
        rect(0, 0, width, height);
        fill(#fffee6);
        textSize((int)(min(width, height)*0.03));
        text("Your windshield wipers are broken and a layer of snow is slowly building up.", width*0.02, height*0.45);
        text("Use your laser to remove the snow.", width*0.02, height*0.5);
        text("Left click to use laser. Change the wind direction with your mouse wheel.", width*0.02, height*0.55);
        text("To reset the wind direction right click.", width*0.02, height*0.6);
        fill(#d6376f);
        text("Move your mouse to close this!", width*0.02, height*0.85);
    }
}

public void drawSky(float[][] stars){
    //moon
    fill(#fffee6);
    noStroke();
    circle(width*0.8, height*0.15, min(width, height)*0.2);
    //stars
    fill(#bfe5ff);
    for (float[] f : stars) {
        circle(width*f[0], height*f[1], min(width, height)*0.01);
    }
}

public void drawCar(){
    stroke(#616875);
    strokeWeight(min(width, height)/10);
    noFill();
    circle(width/2,1.25*height,1.25*height);
}

public void drawSnowSnowflakes(Snowflake[] sfs, Snow[] ss, int wind) {
    for (Snowflake sf : sfs){
        colorize(sf);
        sf.updateSnowflake(wind);
        sf.drawSnowflake();
    }
    for (Snow s : ss){
        colorize(s);
        s.drawSnow();
    }
}