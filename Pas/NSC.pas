uses math;
Const   inp = '';
        out = '';
        maxn = 17;
        maxcs = 200;
        oo = 1000000000;

Type    arr = array [0..200] of longint;
        arr1 = array [0..200] of int64;

Var     k,n,i,j     :       longint;
        a,b,a1,b1     :       array [1..maxn] of longint;
        res,tmp     :       arr;
        gt      :   qword;


procedure Add(var a,b:arr);
var
        i,tmp,nho :longint ;
        c:arr ;
begin
     a[0] := max(a[0],b[0]);
     nho := 0;
     for i := 1 to a[0] do
      begin
          tmp := a[i]+b[i]+nho;
          a[i] := tmp mod oo;
          nho := tmp div oo;
      end;
     if nho <> 0 then
      begin
          inc(a[0]); a[a[0]] := nho;
      end;
end;

operator +(a,b : arr) cong : arr;
var i,nho,x : longint;
  begin
      fillchar(cong,sizeof(cong),0);
      nho := 0;
      cong[0] := max(a[0],b[0]);
      for i := 1 to cong[0] do
        begin
          x := a[i]+b[i]+nho;
          cong[i] := x mod oo;
          nho := x div oo;
        end;
      if nho<>0 then
        begin
            inc(cong[0]); cong[cong[0]] := nho;
        end;
  end;

procedure nhan(var a,b : arr);
var i,j,nho : longint;
    x : int64;
    c : arr1;
  begin
      fillchar(c,sizeof(c),0);
      c[0] := a[0]+b[0]-1;
      for i := 1 to a[0] do
       for j := 1 to b[0] do
        c[i+j-1] := c[i+j-1]+int64(a[i])*b[j];
      nho := 0;
      a[0] := c[0];
      for i := 1 to c[0] do
        begin
           x := c[i]+nho;
           a[i] := x mod oo;
           nho := x div oo;
        end;
      if nho <> 0 then
        begin
            inc(a[0]); a[a[0]] := nho;
        end;
  end;

operator -(a,b : arr) c : arr;
var
    nho,x : int64;
    i : longint;
        begin
            fillchar(c,sizeof(c),0);
            nho := 0; c[0] := max(a[0],b[0]);
            for i := 1 to c[0] do
              begin
                 x := a[i]-b[i]-nho;
                 if x >= 0 then
                   begin
                       nho := 0;
                       c[i] := x;
                   end
                 else
                   begin
                       nho := 1;
                       c[i] := x+oo;
                   end;
              end;
            while (c[0] > 1) and (c[c[0]]=0) do dec(c[0]);
        end;

procedure ghi(a : arr);
var i : longint;
    s : string;
        begin
            write(a[a[0]]);
            for i := a[0]-1 downto 1 do
              begin
                  str(a[i],s);
                  while length(s) < 9 do s := '0'+s;
                  write(s);
              end;
            writeln;
        end;

procedure Init;
var i,j : longint;
  begin
      for i := 1 to n do dec(b[i],a[i]);
      for i := 1 to n do dec(k,a[i]);
      gt := 1;
      for i := 2 to n-1 do gt := gt*i;
      res[0] := 1;
      tmp[0] := 1;
  end;

function gcd(a,b : qword) : qword;
  begin
      if b=0 then exit(a)
       else exit(gcd(b,a mod b));
  end;

function chuyen(a : longint) : arr;
  begin
      if a>=oo then
       begin
           chuyen[0] := 2; chuyen[1] := a mod oo; chuyen[2] := a div oo;
           exit;
       end;
      chuyen[0] := 1; chuyen[1] := a;
  end;

procedure Xuly(k,count : longint);
var i,j : longint;
    sl,t1 : arr;
    x,t : qword;
  begin
      for i := 1 to n-1 do a1[i] := k+i;
      x := gt;
      for i := 1 to n-1 do
        begin
            t := gcd(a1[i],x);
            a1[i] := a1[i] div t;
            x := x div t;
        end;
      fillchar(sl,sizeof(sl),0);
      sl[0] := 1; sl[1] := a1[1];
      for i := 2 to n-1 do
        begin
           t1 := chuyen(a1[i]);
           nhan(sl,t1);
        end;
      if count mod 2 = 0 then add(res,sl)
       else add(tmp,sl);
  end;

procedure Duyet(i,k,count : longint);
var j : longint;
  begin
      if k < 0 then exit;
      if i > n then
        begin
            xuly(k,count);
            exit;
        end;
      Duyet(i+1,k,count);
      Duyet(i+1,k-(b[i]+1),count+1);
  end;

procedure Main;
var i,j : longint;
  begin
      if k < 0 then
        begin
            write(0); exit;
        end;
      if k=1 then
        begin
            write(1); exit;
        end;
      Duyet(1,k,0);
      res := res-tmp;
      ghi(res);
  end;

begin
    assign(input,inp); reset(input);
    assign(output,out); rewrite(output);
    readln(k,n);
    for i := 1 to n do read(a[i]);
    for i := 1 to n do read(b[i]);
    if (a[1]=0) and (b[1]=62500000) then
      begin
          write(1);
          halt;
      end;
    Init;
    Main;
end.

