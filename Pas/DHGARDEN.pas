Uses math;
Const   inp = '';
        out = '';
        maxn = 10;

Var     ntest,n,i,res,dem,r,d : longint;
        a,b,c : int64;
        x,y,id : array [1..maxn] of int64;
        bl : array [1..maxn] of boolean;
        cv : extended;

function dis(x1,y1,x2,y2 : longint) : double;
  begin
      dis := sqrt(sqr(x1-x2)+sqr(y1-y2));
  end;

procedure xay(x1,y1,x2,y2 : longint);
  begin
      a := y2-y1;
      b := x1-x2;
      c := -x1*(y2-y1)+y1*(x2-x1);
  end;

function check : boolean;
var i,j,u,v,k,t,x1,x2,y1,y2,n1 : longint;
    t1,temp : int64;
    kc : extended;
    ok,ok1 : boolean;
  begin
      kc := 0;
      fillchar(bl,sizeof(bl),false);
      if dem=1 then exit(true);
      for i := 1 to dem do
       for j := i+1 to dem do
        begin
           u := id[i]; v := id[j];
           x1 := min(x[u],x[v]); x2 := max(x[u],x[v]);
           y1 := min(y[u],y[v]); y2 := max(y[u],y[v]);
           xay(x[u],y[u],x[v],y[v]);
           temp := 0;
           ok := true;
           for k := 1 to dem do
            if (k<>i) and (k<>j) then
             begin
                t := id[k];
                t1 := a*x[t]+b*y[t]+c;
                if (t1<>0) and (temp<>0) then
                  begin
                      if temp*t1 < 0 then
                        begin
                            ok := false;
                            break;
                        end;
                  end
                 else
                    if t1=0 then
                  begin
                      if ((x[t]>x1) and (x[t]<x2)) or ((y[t]>y1) and (y[t]<y2)) then
                       begin
                           ok := false;
                           break;
                       end;
                  end;
                 if temp=0 then temp := a*x[t]+b*y[t]+c;
             end;
           if ok then begin
             kc := kc + dis(x[u],y[u],x[v],y[v]);
             bl[u] := true; bl[v] := true;
           end;
        end;
       ok1 := true; u := 0; v := 0;
       for i := 1 to dem do
         if bl[id[i]] then if u = 0 then u := id[i] else v := id[i];
       xay(x[u],y[u],x[v],y[v]);
       for k := 1 to dem do
        if bl[id[k]] then
         if a*x[id[k]]+b*y[id[k]]+c<>0 then ok1 := false;
       if ok1 then
        begin
           if 2*kc+cv <= d then exit(true) else exit(false);
        end
       else if kc+cv <=d then exit(true) else exit(false);
   end;
procedure main;
var i,j,tt : longint;
  begin
      cv := 2*pi*r;
      if d < cv then
        begin
            writeln(0);
            exit;
        end;
      res := 0;
      for tt := 1 to 1 shl n-1 do
        begin
            dem := 0;
            for i := 0 to n-1 do
             if (tt shr i) and 1 = 1 then
               begin
                  inc(dem);
                  id[dem] := i+1;
               end;
            if check then res := max(res,dem);
        end;
      writeln(res);
  end;

begin
     assign(input,inp); reset(input);
     assign(output,out); rewrite(output);
     readln(ntest);
     while ntest > 0 do
       begin
           dec(ntest);
           readln(d,n,r);
           for i := 1 to n do read(x[i],y[i]);
           main;
       end;
end.
