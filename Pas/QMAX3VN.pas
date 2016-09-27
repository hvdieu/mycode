Uses math;
Const   inp = 'QMAX3VN.INP';
        out = 'QMAX3VN.OUT';
        maxn = 100001;
        oo = -999999999;

Var     n,q,i,u,v,m : longint;
        kind : char;
        t,f : array [1..4*maxn] of longint;
        k : array [1..maxn] of char;
        vt,qx,qy,pos : array [1..maxn] of longint;

procedure Init(i,lo,hi : longint);
var mid : longint;
  begin
      if lo=hi then
        begin
            t[i] := 1; exit;
        end;
      mid := (lo+hi) shr 1;
      Init(i*2,lo,mid); Init(i*2+1,mid+1,hi);
      t[i] := t[i*2]+t[i*2+1];
  end;

procedure Init2(i,lo,hi : longint);
var mid : longint;
  begin
      if lo=hi then
        begin
            f[i] := oo;
            exit;
        end;
      mid := (lo+hi) shr 1;
      Init2(i*2,lo,mid); Init2(i*2+1,mid+1,hi);
      f[i] := oo;
  end;

function find(i,lo,hi,u,tt : longint) : longint;
var mid,res : longint;
  begin
      if lo=hi then
        begin
           if tt=0 then t[i] := 0;
           exit(lo);
        end;
      mid := (lo+hi) shr 1;
      if u <= t[i*2] then res := find(i*2,lo,mid,u,tt)
       else res := find(i*2+1,mid+1,hi,u-t[i*2],tt);
      t[i] := t[i*2]+t[i*2+1];
      exit(res);
  end;

procedure Khoitao;
var i,j : longint;
  begin
      Init(1,1,n);
      for i := n downto 1 do
        pos[i] := find(1,1,n,vt[i],0);
      fillchar(t,sizeof(t),0);
  end;

procedure Update(i,lo,hi,u,x : longint);
var mid : longint;
  begin
      if (u<lo) or (hi<u) then exit;
      if (lo=u) and (hi=u) then
        begin
            f[i] := x; t[i] := 1;
            exit;
        end;
      mid := (lo+hi) shr 1;
      Update(i*2,lo,mid,u,x); Update(i*2+1,mid+1,hi,u,x);
      f[i] := max(f[i*2],f[i*2+1]);
      t[i] := t[i*2]+t[i*2+1];
  end;

function Qr(i,lo,hi,u,v : longint) : longint;
var mid : longint;
  begin
      if (v<lo) or (u>hi) then exit(oo);
      if (u<=lo) and (hi<=v) then exit(f[i]);
      mid := (lo+hi) shr 1;
      exit(max(Qr(i*2,lo,mid,u,v),Qr(i*2+1,mid+1,hi,u,v)));
  end;

procedure Main;
var i,j,u,v,id : longint;
  begin
      id := 0;
      Init2(1,1,n);
      for i := 1 to q do
        begin
           u := qx[i]; v := qy[i];
           if k[i]='A' then
             begin
                 inc(id);
                 Update(1,1,n,pos[id],u);
             end
           else begin
                    u := find(1,1,n,u,1); v := find(1,1,n,v,1);
                    writeln(Qr(1,1,n,u,v));
                end;
        end;
  end;

begin
     assign(input,inp); reset(input);
     assign(output,out); rewrite(output);
     readln(q);
     for i := 1 to q do
       begin
           readln(kind,u,v);
           if kind='A' then
             begin
                 inc(n); vt[n] := v;
             end;
           k[i] := kind; qx[i] := u; qy[i] := v;
       end;
     Khoitao;
     Main;
end.