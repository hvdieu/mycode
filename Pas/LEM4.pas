Uses math;
Const   inp = 'LEM4.INP';
        out = 'LEM4.OUT';
        maxn = 10001;

Type    node = record
        l,r,g : longint;
        end;

Var     n,m,u,v,k,i : longint;
        t : array [1..4*maxn] of node;
        f : array [1..4*maxn] of longint;

procedure init(i,lo,hi : longint);
var mid,c1,c2 : longint;
  begin
       with t[i] do begin
       g := hi-lo+1; l := g; r := g; end;
       mid := (lo+hi) shr 1;
       if lo=hi then exit;
       init(i*2,lo,mid); init(i*2+1,mid+1,hi);
  end;

procedure down(i : longint);
var c1,c2 : longint;
  begin
      c1 := i*2; c2 := i*2+1;
      f[c1] := f[i]; f[c2] := f[i];
      f[i] := 0;
  end;

procedure gan(i,lo,hi : longint);
  begin
      if f[i]=0 then exit;
      with t[i] do
        begin
            if f[i]=1 then
             begin
               g := hi-lo+1; l := g; r := g;
             end
            else begin g := 0; r := 0; l := 0; end;
        end;
      if lo=hi then
      begin
        f[i] := 0;
        exit;
      end;
      down(i);
  end;

function max3(x,y,z : longint) : longint;
  begin
      exit(max(max(x,y),z));
  end;

procedure update(i,lo,hi,u,v,tt : longint);
var mid,c1,c2 : longint;
  begin
      c1 := i*2; c2 := i*2+1; mid := (lo+hi) shr 1;
      if (lo=u) and (hi=v) then
        begin
           f[i] := tt;
           gan(i,lo,hi);
           exit;
        end;
      gan(c1,lo,mid); gan(c2,mid+1,hi);
      if u <= mid then update(c1,lo,mid,u,min(mid,v),tt);
      if v > mid then update(c2,mid+1,hi,max(u,mid+1),v,tt);
      with t[i] do
        begin
            g := max3(t[c1].g,t[c2].g,t[c1].r+t[c2].l);
            if t[c1].l=(mid-lo+1) then l := t[c1].l+t[c2].l
             else l := t[c1].l;
            if t[c2].r=(hi-mid) then r := t[c2].r+t[c1].r
             else r := t[c2].r;
        end;
  end;

begin
      assign(input,inp); reset(input);
      assign(output,out); rewrite(output);
      readln(n);
      init(1,1,n);
      readln(m);
      for i := 1 to m do
        begin
            read(k);
            case k of
               1,2 : begin
                         read(u,v);
                         update(1,1,n,u,v,k);
                     end;
               3   : writeln(t[1].g);
            end;
        end;
end.


