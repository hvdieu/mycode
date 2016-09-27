uses math, windows;
const
        tinp='ballgame.inp';
        tout='ballgame.ou1';
        e=0.000000000001;

var
        fi,fo:text;
        n,m,top1,top2,time:longint;
        res1,res2,res3:extended;
        x,y,pos:array[1..4000000]of extended;
        a,d,c:array[1..4000000]of extended;
        st1,st2:array[1..2]of extended;

procedure input;
var i:longint;
begin
        assign(Fi,tinp);reset(fi);
        read(fi,n);
        for i:=1 to 2*n do read(Fi,x[i],y[i]);
        for i:=1 to 2*n do pos[i]:=i;
        close(fi);
end;

procedure swap(var i,j:extended);
var k:extended;
begin
        k:=i;i:=j;j:=k;
end;

procedure sort(l,r:longint);
var i,j,key:longint;
    k,p,q:extended;
begin
        if l>=r then exit;
        i:=l;
        j:=r;
        key:=l+random(r-l+1);
        k:=a[key];
        p:=d[key];
        q:=c[key];
        repeat
          while (k-a[i]>e) or ((abs(k-a[i])<=e) and (d[i]<p))
          or ((abs(k-a[i])<=e) and (d[i]=p) and (c[i]<q)) do inc(i);
          while (a[j]-k>e) or ((abs(a[j]-k)<=e) and (d[j]>p))
          or ((abs(a[j]-k)<=e) and (d[j]=p) and (c[j]>q))do dec(j);
          if i<=j then
            begin
              if i<j then
                begin
                  swap(a[i],a[j]);
                  swap(c[i],c[j]);
                  swap(d[i],d[j]);
                end;
              inc(i);
              dec(j);
            end;
        until i>j;
        sort(l,j);
        sort(i,r);
end;

procedure init;
var i,j,t:longint;
begin
        for i:=1 to 2*n do
          for j:=1 to 2*n do
            if (x[i]<>x[j]) and (pos[i]<>pos[j]) then
            begin
              inc(m);
              a[m]:=tan((y[i]-y[j])/(x[i]-x[j]));
              d[m]:=pos[i];
              c[m]:=pos[j];
            end;
end;

procedure process;
var i,j,k,t:longint;
    dd,dd1:extended;
    ok:boolean;
begin
        init;
        sort(1,m);
        ok:=false;
        for i:=2 to m do
          if abs(a[i]-a[i-1])<=e then
            begin
              t:=i-1;
              dd:=d[i-1];
              dd1:=a[i-1];
              while (t<m) and (abs(a[t+1]-dd1)<=e) and (d[t+1]=dd) do inc(t);
              if t<>i-1 then
                begin
                  {if ((d[i-1]>n) and (c[i-1]<=n)) or
                  ((d[i-1]<=n) and (c[i-1]>n)) then ok:=true;
                  if ((d[i-1]>n) and (c[t]<=n)) or
                  ((d[i-1]>n) and (c[t]>n)) then ok:=true;
                  if ((c[i-1]>n) and (c[t]<=n)) or
                  ((c[i-1]<=n) and (c[t]>n)) then ok:=true;}
                  if not (((d[i-1]>n) and (c[i-1]>n) and (c[t]>n))
                  or ((d[i-1]<=n) and (c[i-1]<=n) and (c[t]<=n))) then ok:=true;
                  if ok then
                    begin
                      res1:=d[i-1];
                      res2:=c[i-1];
                      res3:=c[t];
                      break;
                    end;
                end;
            end;
        assign(fo,tout);rewrite(fo);
        if ok then writeln(fo,trunc(res1),' ',trunc(res2),' ',trunc(res3))
        else writeln(fo,-1);
end;

procedure sort2(l,r:longint);
var i,j,key:longint;
    k:extended;
begin
        if l>=r then exit;
        i:=l;
        j:=r;
        key:=l+random(r-l+1);
        k:=x[key];
        repeat
          while x[i]<k do inc(i);
          while x[j]>k do dec(j);
          if i<=j then
            begin
              if i<j then
                begin
                  swap(x[i],x[j]);
                  swap(y[i],y[j]);
                  swap(pos[i],pos[j]);
                end;
              inc(i);
              dec(j);
            end;
        until i>j;
        sort(l,j);
        sort(i,r);
end;

function check:boolean;
var i,j:longint;
begin
        sort2(1,2*n);
        for i:=2 to 2*n do
          if x[i]=x[i-1] then
            begin
              top1:=0;
              top2:=0;
              if pos[i-1]<=n then
                begin
                  inc(top1);
                  st1[top1]:=pos[i-1];
                end
              else
                begin
                  inc(top2);
                  st2[top2]:=pos[i-1];
                end;
              j:=i-1;
              while (j<2*n) and (x[j+1]=x[i-1]) do
                begin
                  inc(j);
                  if (top1<2) and (pos[j]<=n) then
                    begin
                      inc(top1);
                      st1[top1]:=pos[j];
                    end
                  else
                    if (top2<2) and (pos[j]>n) then
                      begin
                        inc(top2);
                        st2[top2]:=pos[j];
                      end;
                  if top1+top2=3 then break;
                end;
              if top1+top2=3 then
                begin
                  if top1=1 then
                    begin
                      res1:=st1[top1];
                      res2:=st2[1];
                      res3:=st2[2];
                    end
                  else
                    begin
                      res1:=st1[1];
                      res2:=st1[2];
                      res3:=st2[1];
                    end;
                  exit(true);
                end;
            end;
        exit(false);
end;

BEGIN
        time := gettickcount;
        input;
        if check then
          begin
            assign(fo,tout);rewrite(fo);
            writeln(fo,trunc(res1),' ',trunc(res2),' ',trunc(res3));
          end
        else process;
        writeln(fo,gettickcount-time);
        close(fo);
END.

