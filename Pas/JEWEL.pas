Const   inp = '';
        out = '';
        maxn = 200001;
        oo = 999999999999999;

Type    node = record
        Cy,Dy: extended;
        init : byte;
        end;

Var     m,n,i,j : longint;
        t : array [1..4*maxn] of node;
	s,e : longint;
        v,d : longint;
        res : extended;
        time,now : longint;

procedure swap(Var xx,yy : extended);
var temp : extended;
  begin
      temp := xx; xx := yy; yy := temp;
  end;

procedure xay(var a,b,c : extended;x1 : longint;y1 : extended;x2 : longint;y2 : extended);
  begin
      a := y2-y1;
      b := x1-x2;
      c := y1*(x2-x1)-x1*(y2-y1);
  end;

procedure update(i,lo,hi,x1 : longint;y1 : extended;x2 : longint;y2 : extended);
var mid,u,v : longint;
    a2,b2,c2,a1,b1,c1,P,Q,Dy1,Cy1 : extended;
  begin
      mid := (lo+hi) div 2;
      if (lo=x1) and (hi=x2) then
        begin
            if t[i].init=0 then
              begin
                  t[i].init := 1;
                  t[i].Cy := y1; t[i].Dy := y2;
              end
            else
              begin
                 if x1<>x2 then
                 begin
                 with t[i] do
                   begin
                     if (Cy >= y1) and (Dy >= y2) then exit;
                     if (Cy < y1) and (Dy <y2) then
                       begin
                         Cy := y1; Dy := y2; exit;
                       end;
                     Dy1 := Dy; Cy1 := Cy;
                     if (y1<Cy) and (Dy<y2) then
                      begin
                       swap(y1,Cy1); swap(y2,Dy1);
                      end;
                     xay(a1,b1,c1,x1,y1,x2,y2);
                     xay(a2,b2,c2,x1,Cy1,x2,Dy1);
                     P := (-a1*mid-c1)/b1;
                     Q := (-a2*mid-c2) / b2;
                     if P <= Q then Update(i*2,x1,mid,x1,y1,mid,P)
                     else
                     begin
                        Update(i*2+1,mid+1,x2,mid+1,(-a2*(mid+1)-c2)/b2,x2,Dy1);
                        Cy1 := y1; Dy1 := y2;
                     end;
                   Cy := Cy1; Dy := Dy1;
                 end;
                end else
                  begin
                      if y2 > t[i].Dy then
                        begin
                            t[i].Dy := y2;
                            t[i].Cy := y1;
                        end;
                  end;
              end;
            exit;
        end;
      if x1=x2 then
        begin
           if x1 <= mid then Update(i*2,lo,mid,x1,y1,x2,y2);
           if x2 >= mid+1 then Update(i*2+1,mid+1,hi,x1,y1,x2,y2);
           exit;
        end;
	  if mid+1>x1 then u := mid+1 else u := x1;
	  if mid < x2 then v := mid else v := x2;
      xay(a1,b1,c1,x1,y1,x2,y2);
      P := (-a1*v-c1)/b1;
      Q := (-a1*u-c1)/b1;
      if x1 <= mid then Update(i*2,lo,mid,x1,y1,v,P);
      if x2 >= mid+1 then Update(i*2+1,mid+1,hi,u,Q,x2,y2);
  end;

function max3(x,y,z : qword) : qword;
var temp : qword;
  begin
      if x > y then temp := x else temp := y;
      if z > temp then exit(z) else exit(temp);
  end;

procedure Qr(i,lo,hi,u : longint);
var mid : longint;
    a1,b1,c1,x : extended;
  begin
      if (lo>u) or (u>hi) then exit;
      if (lo=u) and (hi=u) then
      begin
        if t[i].init=1 then if res < t[i].Dy then res := t[i].Dy;
        exit;
      end;
      mid := (lo+hi) shr 1;
      if t[i].init=1 then
      begin
         xay(a1,b1,c1,lo,t[i].Cy,hi,t[i].Dy);
         x := (-a1*u-c1)/b1;
		 if x > res then res := x;
      end;
      if (u >= lo) and (u<=mid) then Qr(i*2,lo,mid,u);
      if (u>mid) and (u<=hi) then Qr(i*2+1,mid+1,hi,u);
  end;

begin
     assign(input,inp); reset(input);
     assign(output,out); rewrite(output);
     readln(n,m);
     for i := 1 to m do
       begin
           readln(s,e,v,d);
           update(1,1,n,s,v,e,int64(v)+(int64(e)-s)*d);
       end;
     for i := 1 to n do
       begin
	       res := 0;
           Qr(1,1,n,i);
           writeln(res:0:0);
       end;
end.


