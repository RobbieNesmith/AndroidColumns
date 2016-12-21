int[][] gg;
int gw;
int gh;
int s;
int score;
int hs;
boolean sl;
int cn;
color[] cm={0,color(255,0,0),color(255,255,0),color(0,255,0),color(0,255,255),color(0,0,255),color(255,0,255),color(255,255,255),0,0,0,color(255,200,200),color(255,255,200),color(200,255,200),color(200,255,255),color(200,200,255),color(255,200,255),color(255,255,255)};

int[] gp={0,0,0};
int[] ngp={0,0,0};
int gpx,gpy;
int tr;
int mt;

int smx,smy;

boolean go;
boolean p;

void setup()
{
  orientation(PORTRAIT);
  ellipseMode(CORNER);
  score=0;
  gw = 8;
  gh = 23;
  gg = new int[gw][gh];
  s = height/20;
  gpx=3;
  gpy=0;
  rgp();
  tr=0;
  mt=60;
  sl=false;
  cn=1;
  go=true;
  p=true;
  hs=10;
}

void reset()
{
  score=0;
  gg=new int[gw][gh];
  gpx=3;
  gpy=0;
  rgp();
  tr=0;
  mt=60;
  sl=false;
  cn=1;
  go=false;
  p=false;
}

void draw()
{
  background(200);
  fill(0);
  rect(0,0,8*s,20*s);
  if(!p)
  {
    if(!go)
    {
      if(sl)
      {
        scl();
      }
      else
      {
        sgp();
      }
    }
  }
  if(!go)
  {
    dg(0,-3*s,s);
    dgp();
  }
  else
  {
    dgo();
  }
  textSize(s);
  fill(0);
  text(score,8*s,2*s);
  dp();
}

void rg()
{
  for(int c=0; c<gw; c++)
  {
    for(int r=0; r<gh; r++)
    {
      gg[c][r]=(int)random(0,7);
    }
  }
}

void dg(int x, int y, int s)
{
  for(int c=0; c<gw; c++)
  {
    for(int r=0; r<gh; r++)
    {
      int co = gg[c][r];
      if(co>20)
      {
        co-=10;
      }
      if(co>0)
      {
        fill(cm[co]);
        rect(x+c*s,y+r*s,s,s);
      }
    }
  }
}

void dgp()
{
  int x=gpx*s;
  int y=(gpy-3)*s;
  if(gpy<gh-3&&gg[gpx][gpy+3]==0)
  {
    y+=tr*s/mt;
  }
  for(int j=0; j<3; j++)
  {
    if(!sl)
    {
      fill(cm[gp[j]%10]);
      if(gp[j]<10)
      {
        rect(x,y+j*s,s,s);
      }
      else
      {
        ellipse(x,y+j*s,s,s);
      }
    }
    fill(cm[ngp[j]%10]);
    if(ngp[j]<10)
    {
      rect(8*s,3*s+j*s,s,s);
    }
    else
    {
      ellipse(8*s,3*s+j*s,s,s);
    }
  }
}

void dgo()
{
  fill(255);
  text("GAME OVER!",s,s);
  textSize(s/2);
  text("unpause then choose difficulty\nto play again",s,2*s);
  fill(0,255,255);
  rect(s,3*s,6*s,2*s);
  fill(0);
  text("prolonged",2*s,4*s);
  fill(255,255,0);
  rect(s,6*s,6*s,2*s);
  fill(0);
  text("normal",2*s,7*s);
  fill(255,0,0);
  rect(s,9*s,6*s,2*s);
  fill(0);
  text("quick",2*s,10*s);
}

void dp()
{
  if(p)
  {
    fill(0,255,0);
  }
  else
  {
    fill(0,0,255);
  }
  rect(width-2*s,height-2*s,2*s,2*s);
  if(p)
  {
    fill(0,0,255);
  }
  else
  {
    fill(0,255,0);
  }
  rect(width-s*8/5,height-s*8/5,s*2/5,s*6/5);
  rect(width-s*4/5,height-s*8/5,s*2/5,s*6/5);
}

boolean sg()
{
  boolean ch = false;
  for(int c=0; c<gw; c++)
  {
    for(int r=gh-1; r>=0; r--)
    {
      if(r<gh-1&&gg[c][r]>0&&gg[c][r+1]==0)
      {
        gg[c][r+1] = gg[c][r];
        gg[c][r] = 0;
        ch=true;
      }
      if(gg[c][r]>6)
      {
        gg[c][r]=0;
        ch=true;
      }
    }
  }
  return ch;
}

void sgp()
{
  tr++;
  if(tr>=mt)
  {
    if(gpy==gh-3||gg[gpx][gpy+3]>0)
    {
      if(gpy<3)
      {
        go=true;
        p=true;
      }
      else
      {
        for(int j=0; j<3; j++)
        {
          gg[gpx][gpy+j] = gp[j]%10;
        }
        if(gp[2]>6)
        {
          int rep=-1;
          if(gpy<gh-3)
          {
            rep=gg[gpx][gpy+3];
          }
          for(int c=0; c<gw; c++)
          {
            for(int r=0; r<gh; r++)
            {
              if(rep==-1&&gg[c][r]>0)
              {
                if(gp[2]==7)
                {
                  gg[c][r]=7;
                }
                else
                {
                  gg[c][r]=(int)random(1,7);
                }
              }
              if(rep==gg[c][r])
              {
                gg[c][r]=gp[2]%10;
              }
            }
          }
        }
        gpx=3;
        gpy=0;
        tr=0;
        int tmp=sc();
        score+=tmp*cn;
        mt=60*hs/(score+hs);
        if(tmp==0)
        {
          rgp();
          cn=1;
          sl=false;
        }
        else
        {
          sl=true;
          cn++;
        }
      }
    }
    else
    {
      gpy++;
      tr=0;
    }
  }
}

int sc()
{
  int com = 0;
  for(int c=0; c<gw; c++)
  {
    for(int r=0; r<gh; r++)
    {
      int v = gg[c][r]%10;
      if(v==7)
      {
        com++;
      }
      else if(v>0)
      {
        boolean ru=true;
        boolean rt=true;
        boolean rd=true;
        boolean dn=true;
        for(int off=0; off<3; off++)
        {
          if(ru&&(r<2||c>gw-3||gg[c+off][r-off]%10!=v))
          {
            ru=false;
          }
          if(rt&&(c>gw-3||gg[c+off][r]%10!=v))
          {
            rt=false;
          }
          if(rd&&(r>gh-3||c>gw-3||gg[c+off][r+off]%10!=v))
          {
            rd=false;
          }
          if(dn&&(r>gh-3||gg[c][r+off]%10!=v))
          {
            dn=false;
          }
        }
        if(ru)
        {
          int off=0;
          while(c+off<gw&&r-off>0&&gg[c+off][r-off]%10==v)
          {
            if(gg[c+off][r-off]==v)
            {
              gg[c+off][r-off]+=10;
              com++;
            }
            off++;
          }
        }
        if(rt)
        {
          int off=0;
          while(c+off<gw&&gg[c+off][r]%10==v)
          {
            if(gg[c+off][r]==v)
            {
              gg[c+off][r]+=10;
              com++;
            }
            off++;
          }
        }
        if(rd)
        {
          int off=0;
          while(c+off<gw&&r+off<gh&&gg[c+off][r+off]%10==v)
          {
            if(gg[c+off][r+off]==v)
            {
              gg[c+off][r+off]+=10;
              com++;
            }
            off++;
          }
        }
        if(dn)
        {
          int off=0;
          while(r+off<gh&&gg[c][r+off]%10==v)
          {
            if(gg[c][r+off]==v)
            {
              gg[c][r+off]+=10;
              com++;
            }
            off++;
          }
        }
      }
    }
  }
  return com;
}

void scl()
{
  tr++;
  if(tr>=mt)
  {
    tr=0;
    boolean d=true;
    while(d)
    {
      d=sg();
    }
    int tmp=sc();
    score+=tmp*cn;
    mt=60*hs/(score+hs);
    if(tmp==0)
    {
      rgp();
      cn=1;
      sl=false;
    }
    else
    {
      sl=true;
      cn++;
    }
  }
}

void rgp()
{
  if(gp[0]==0)
  {
    for(int i=0; i<3; i++)
    {
      ngp[i]=(int)random(1,7);
    }
  }
  for(int i=0; i<3; i++)
  {
    gp[i]=ngp[i];
    ngp[i]=(int)random(1,7);
  }
  if(ngp[0]==ngp[1]&&ngp[1]==ngp[2])
  {
    if(random(1)<0.5)
    {
      for(int j=0; j<3; j++)
      {
        ngp[j]=7;
      }
    }
  }
  else if(ngp[0]!=ngp[1]&&ngp[1]!=ngp[2]&&ngp[2]!=ngp[0])
  {
    if(random(1)<0.1)
    {
      for(int j=0; j<3; j++)
      {
        ngp[j]+=10;
      }
    }
  }
}

boolean inb(int x,int y,int xx,int yy,int w,int h)
{
  return x>xx&&x<xx+w&&y>yy&&y<yy+h;
}

void mousePressed()
{
  smx=mouseX;
  smy=mouseY;
}

void mouseReleased()
{
  if(mouseX>width-2*s&&mouseY>height-2*s)
  {
    p=!p;
  }
  else if(go&&!p)
  {
    if(inb(mouseX,mouseY,s,3*s,6*s,2*s))
    {
      hs=500;
      reset();
    }
    if(inb(mouseX,mouseY,s,6*s,6*s,2*s))
    {
      hs=100;
      reset();
    }
    if(inb(mouseX,mouseY,s,9*s,6*s,2*s))
    {
      hs=10;
      reset();
    }
  }
  else if(!p)
  {
    int dx=mouseX-smx;
    int dy=mouseY-smy;
    if(abs(dx)>abs(dy))
    {
      int off=3;
      if(gpy==gh-3||gg[gpx][gpy+3]>0)
      {
        tr=0;
        off=2;
      }
      if(dx<0&&gpx>0&&gg[gpx-1][gpy+off]==0)
      {
        gpx--;
      }
      if(dx>0&&gpx<gw-1&&gg[gpx+1][gpy+off]==0)
      {
        gpx++;
      }
    }
    else
    {
      if(dy<0)
      {
        if(gpy==gh-3||gg[gpx][gpy+3]>0)
        {
          tr=0;
        }
        int tmp=gp[0];
        gp[0]=gp[1];
        gp[1]=gp[2];
        gp[2]=tmp;
      }
      else
      {
        if(!sl&&gpy<gh-3&&gg[gpx][gpy+3]==0)
        {
          gpy++;
        }
        else
        {
          tr=mt;
        }
      }
    }
  }
}