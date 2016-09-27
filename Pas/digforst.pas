Const   inp = 'DIGFORST.IN';
        out = 'DIGFORST.OUT';
        maxn = 101;
        maxw = 999999999;

Var     a       :       array [1..maxn] of longint;
        head    :       array [1..maxn] of longint;
        ke,next :       array [1..maxn*maxn] of longint;
        x       :       array [1..7] of integer;
        hi,hj   :       array [1..maxn*420] of longint;
        d,pos       :       array [1..maxn,0..420] of longint;
        free    :   array [1..maxn,0..420] of boolean;
        m,n,nheap,u,res,t1,temp,oo     :       longint;

{**************************************************************************}
procedure nhap;
var i,j,x : longint;
        begin
            assign(input,inp); reset(input);
            assign(output,out); rewrite(output);
            readln(n);
            for i := 1 to n do read(a[i]);
            for i := 1 to n do
             begin
                for j := 1 to n do
                 begin
                     read(x);
                     if x = 1 then
                      begin
                         inc(m);
                         ke[m] := j; next[m] := head[i]; head[i] := m;
                      end;
                 end;
             end;
        end;
{**************************************************************************}
procedure swap(var xx,yy : longint);
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;
{***************************************************************************}
procedure update(cha,con : longint);
        begin
            swap(hi[cha],hi[con]); swap(hj[cha],hj[con]);
            pos[hi[cha],hj[cha]] := cha;
            pos[hi[con],hj[con]] := con;
        end;
{***************************************************************************}
procedure upheap(i,j : longint);
var cha,con : longint;
        begin
            con := pos[i,j];
            if con=0 then
             begin
                inc(nheap); con := nheap; pos[i,j] := con;
                hi[con] := i; hj[con] := j;
             end;
            repeat
                cha := con div 2;
                if (cha=0) or (d[hi[cha],hj[cha]] <= d[hi[con],hj[con]]) then break;
                update(cha,con);
                con := cha;
            until false;
        end;
{***************************************************************************}
procedure pop;
var cha,con : longint;
        begin
            u:=hi[1]; t1 := hj[1];
            update(1,nheap); dec(nheap);
            cha := 1;
            repeat
                 con := cha*2;
                 if (con<nheap) and (d[hi[con],hj[con]] > d[hi[con+1],hj[con+1]]) then inc(con);
                 if(con>nheap) or (d[hi[cha],hj[cha]] <= d[hi[con],hj[con]]) then break;
                  update(cha,con);
                  cha := con;
            until false;
        end;

{***************************************************************************}
function uc(a,b : longint) : longint;
        begin
            if b = 0 then exit(a)
             else exit(uc(b,a mod b));
        end;
{***************************************************************************}
function bc(a,b : longint) : longint;
        begin
            bc := (a*b) div uc(a,b);
        end;
{***************************************************************************}
procedure khoitao;
var i,j,last,s,t,vt : longint;
        begin
            fillchar(free,sizeof(free),true);
            fillchar(pos,sizeof(pos),0);
            nheap := 0; t := 1;
            last := 1; s := 1;
            for i := 2 to 7 do
             if x[i]=1 then
              begin
                 t := i; vt := i;break;
              end;
            for i := vt+1 to 7 do
             if x[i]=1 then t := bc(t,i);
            oo := t;
            for i := 1 to n do
             for j := 0 to oo do d[i,j] := maxw;
            d[1,a[1] mod oo] := a[1]; upheap(1,a[1] mod oo);
        end;
{***************************************************************************}
procedure Dij;
var i,j,t2,v,alt : longint;
        begin
            if x[a[1]] = 0 then exit;
            temp := -1;
            khoitao;
            repeat
                if nheap = 0 then break;
                pop; j := head[u];
                free[u,t1] := false;
                if (u=n) and (t1=0) then
                  begin
                      temp := d[u,t1];
                      break;
                  end;
                while j<>0 do
                 begin
                    v := ke[j];
                    if x[a[v]]=1 then
                     begin
                         t2 := (t1*10+a[v]) mod oo;
                         if free[v,t2] and (d[v,t2] > d[u,t1]+a[v]) then
                          begin
                              d[v,t2] := d[u,t1] + a[v];
                              upheap(v,t2);
                          end;
                     end;
                    j := next[j];
                 end;
            until false;
            if (temp <> -1) and (temp < res) then res := temp;
        end;
{**************************************************************************}
procedure try(i : longint);
var j : longint;
        begin
            if i > 7 then
              begin
                  Dij;
                  exit;
              end;
            for j := 0 to 1 do
             begin
                 x[i] := j;
                 try(i+1);
             end;
        end;
{**************************************************************************}
begin
     nhap;
     x[1] := 1; res := maxw;
     try(2);
     if res = maxw then write(-1)
      else write(res);
end.
