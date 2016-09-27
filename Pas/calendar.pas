program calendar;

uses math;

const
  tfi = 'calendar.inp';
  tfo = 'calendar.out';

var
  n,res,count : longint;
  a,b,p : array [1..100000] of longint;
  fi,fo : text;

procedure input;
  var i : longint;
  begin
    assign(fi,tfi);
    reset(fi);
    read(fi,n);
    for i := 1 to n do read(fi,a[i]);
    for i := 1 to n do
      begin
        read(fi,b[i]);
        p[b[i]] := i;
      end;
    close(fi);
  end;

procedure process;
  var i,j : longint;
  begin
    for i := 1 to n do
      begin
        count := 1;
        for j := i+1 to n-1 do
           if a[i+j] = b[((p[a[i]]+j) mod n) + 1] then count := count + 1;
        res := max(res,count);
      end;
  end;

procedure output;
  begin
    assign(fo,tfo);
    rewrite(fo);
    write(fo,res);
    close(fo);
  end;

begin
  input;
  process;
  output;
end.
