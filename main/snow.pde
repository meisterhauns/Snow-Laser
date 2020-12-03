class Snow{

    float x;
    float y;
    color c;
    float s;
    float rot;

    Snow(){
        this.x = 0;
        this.y = 0;
        this.c = color(#ffffff);
        this.s = 0;
        this.rot = random(0,TWO_PI);
    }

    Snow(float x, float y, float s){
        this.x = x;
        this.y = y;
        this.c = color(#ffffff);
        this.s = s;
        this.rot = random(0,TWO_PI);
    }

    Snow(float x, float y, int i, float s){
        this.x = x;
        this.y = y;
        switch (i){
            case 0:
                this.c = color(#142332);
                break;
            case 1:
                this.c = color(#1d3043);
                break;
            case 2:
                this.c= color(#18222d);
                break;
            case 3:
                this.c = color(#121b25);
                break;
        }
        this.s = s;
        this.rot = random(0,TWO_PI);
    }

    public color getColor() {
        return this.c;
    }
    

    public void setColor(color c) {
        this.c = c;
    }

    public void setRandomColor() {
        switch ((int)random(0,3)){
            case 0:
                this.c = color(#142332);
                break;
            case 1:
                this.c = color(#1d3043);
                break;
            case 2:
                this.c= color(#18222d);
                break;
            case 3:
                this.c = color(#121b25);
                break;
        }
    }

    public float getX() {
        return this.x;
    }

    public float getY() {
        return this.y;
    }

    public void setSize(float s) {
        this.s = s;
    }
    

    public void drawSnow() {
        fill (this.c);
        noStroke();
        pushMatrix();
        translate(this.x, this.y);
        rotate(rot);
        beginShape();
        for (float a = 0; a < TWO_PI; a += PI/3) {
            float sx = cos(a) * this.s;
            float sy = sin(a) * this.s;
            vertex(sx, sy);
        }
        endShape(CLOSE);
        popMatrix();
        //circle(this.x, this.y, this.s);
    }

    public boolean colorEquals(color c){
        return (this.c == c);
    }
    
}