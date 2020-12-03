class Snow{

    float x;
    float y;
    color c;
    float s;

    Snow(){
        this.x = 0;
        this.y = 0;
        this.c = color(#ffffff);
        this.s = 0;
    }

    Snow(float x, float y, float s){
        this.x = x;
        this.y = y;
        this.c = color(#ffffff);
        this.s = s;
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
        circle(this.x, this.y, this.s);
    }

    public boolean colorEquals(color c){
        return (this.c == c);
    }
    
}