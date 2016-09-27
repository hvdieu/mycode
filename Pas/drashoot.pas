Uses math;
Const   inp = 'drashoot.inp';
        out = 'drashoot.out';
        maxn = 100001;
        oo = -1000000007;

Type    node = record
        gt,val,v2,valua : longint;
        end;

Var     n,m,i,res,x,u,v : longint;
        kind : char;
        t : array [1..4*maxn] of node;
        f : array [1..4*maxn] of longint;

procedure Init(i,lo,hi : longint);
var mid : longint;
  begin
      if lo=hi then
        begin
            t[i].valua := 1; exit;
        end;
      mid := (lo+hi) shr 1;
      Init(i*2,lo,mid); Init(i*2+1,mid+1,hi);
      t[i].valua := t[i*2].valua+t[i*2+1].valua;
  end;

function find1(i,lo,hi,u,tt : longint) : longint;
var mid,res : longint;
  begin
      if lo=hi then
        begin
           if tt=0 then t[i].valua := 0;
           exit(lo);
        end;
      mid := (lo+hi) shr 1;
      if u <= t[i*2].valua then res := find1(i*2,lo,mid,u,tt)
       else res := find1(i*2+1,mid+1,hi,u-t[i*2].valua,tt);
      t[i].valua := t[i*2].valua+t[i*2+1].valua;
      exit(res);
  end;

procedure down(i : longint);
var c1,c2 : longint;
  begin
      c1 := i*2; c2 := i*2+1;
      inc(f[c1],f[i]); inc(f[c2],f[i]);
      inc(t[c1].val,f[i]); inc(t[c2].val,f[i]);
      inc(t[c1].v2,f[i]); inc(t[c2].v2,f[i]);
      f[i] := 0;
  end;

procedure Update(i,lo,hi,u,x,tt : longint);
var mid : longint;
  begin
      if (u<lo) or (u>hi) then exit;
      if (lo=u) and (hi=u) then
       begin
           if tt=1 then
             begin
                t[i].gt := x;
                exit;
             end
           else
             begin
                 t[i].gt := oo;
                 t[i].val := oo;
                 t[i].v2 := oo;
                 exit;
             end;
       end;
      mid := (lo+hi) shr 1;
      down(i);
      Update(i*2,lo,mid,u,x,tt);
      Update(i*2+1,mid+1,hi,u,x,tt);
      t[i].gt := max(t[i*2].gt,t[i*2+1].gt);
      t[i].val := max(t[i*2].val,t[i*2+1].val);
      if t[i*2].v2 <0 then t[i].v2 := t[i*2+1].v2
       else if t[i*2+1].v2<0 then t[i].v2 := t[i*2].v2
        else t[i].v2 := min(t[i*2].v2,t[i*2+1].v2);
  end;

procedure Fix(i,lo,hi,u,v,x : longint);
var mid : longint;
  begin
      if (lo=u) and (hi=v) then
        begin
            inc(f[i],x);
            inc(t[i].val,x);
            inc(t[i].v2,x);
            exit;
        end;
      mid := (lo+hi) shr 1;
      down(i);
      if u <= mid then Fix(i*2,lo,mid,u,min(mid,v),x);
      if v > mid then Fix(i*2+1,mid+1,hi,max(u,mid+1),v,x);
      t[i].val := max(t[i*2].val,t[i*2+1].val);
      if t[i*2].v2<0 then t[i].v2 := t[i*2+1].v2
       else if t[i*2+1].v2<0 then t[i].v2 := t[i*2].v2
        else t[i].v2 := min(t[i*2].v2,t[i*2+1].v2);
  end;

function find(i,lo,hi,u,tt : longint) : longint;
var mid : longint;
  begin
      if (lo=hi) then exit(lo);
      mid := (lo+hi) shr 1;
      down(i);
      if tt=0 then
        begin
            if t[i*2].val>=u then exit(find(i*2,lo,mid,u,tt))
             else exit(find(i*2+1,mid+1,hi,u,tt));
        end
      else
        begin
            if (t[i*2+1].v2>=0) and (t[i*2+1].v2<=u) then exit(find(i*2+1,mid+1,hi,u,tt))
            else exit(find(i*2,lo,mid,u,tt));
        end;
  end;

function Qr(i,lo,hi,u,v : longint) : longint;
var mid,l,r : longint;
  begin
      if (u>hi) or (v<lo) then exit(oo);
      if (u<=lo) and (hi<=v) then exit(t[i].gt);
      mid := (lo+hi) shr 1;
      l := Qr(i*2,lo,mid,u,v);
      r := Qr(i*2+1,mid+1,hi,u,v);
      exit(max(l,r));
  end;

begin
     assign(input,inp); reset(input);
     assign(output,out); rewrite(output);
     readln(n);
     for i := 1 to n do
       begin
           read(x);
           Update(1,1,n,i,x,1);
       end;
     readln(m);
     Init(1,1,n);
     for i := 1 to m do
       begin
            read(kind);
           case kind of
             'Q' : begin
                       readln(u,v);
                       if u < 0 then u := 0;
                       if (u > t[1].val) or (v<t[1].v2) or (u>v) then writeln('NONE') else begin
                       if u < t[1].v2 then u := 1 else u := find(1,1,n,u,0);
                       if v > t[1].val then v := n else v := find(1,1,n,v,1);
                       if u > v then writeln('NONE') else begin
                         res := Qr(1,1,n,u,v);
                         writeln(res);
                       end;
                       end;
                   end;
             'S' : begin
                       readln(u);
                       u := find1(1,1,n,u,0);
                       Update(1,1,n,u,oo,0);
                       Fix(1,1,n,u,n,1);
                   end;
           end;
       end;
end.
