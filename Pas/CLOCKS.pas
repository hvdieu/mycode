Const   maxn = 10;

Type    arr = array [1..10] of integer;
Var     start   :       array [1..maxn] of integer;
        k,i,j       :       integer;
        xoay    :       array [1..10,1..5] of longint;
        solan   :       arr;
        res     :       qword;

function check(a : arr) : boolean;
var i : longint;
        begin
             for i := 1 to 9 do
              if a[i] <> 12 then exit(false);
             exit(true);
        end;

function xuoi(x : integer) : integer;
        begin
            if x = 3 then exit(6);
            if x = 6 then exit(9);
            if x = 9 then exit(12);
            if x = 12 then exit(3);
        end;

function nguoc(x : integer) : integer;
        begin
            if x = 3 then exit(12);
            if x = 6 then exit(3);
            if x = 9 then exit(6);
            if x = 12 then exit(9);
        end;

procedure ql(i :longint;a,solan : arr;sum : qword);
var j,sl,t : longint;
        begin
             if i > k then
             begin
                if check(a) then if res > sum then res := sum;
                exit;
             end;
               for sl := 0 to 3 do
                begin
                    solan[i] := sl;
                    for j := 1 to 4 do
                     for t := 1 to sl do
                      begin
                      a[xoay[i,j]] := nguoc(a[xoay[i,j]]);
                     end;
                     for t := 1 to sl do inc(sum,xoay[i,5]);
                    ql(i+1,a,solan,sum);
                    for j := 1 to 4 do
                     for t := 1 to sl do
                     a[xoay[i,j]] := xuoi(a[xoay[i,j]]);
                    for t := 1 to sl do dec(sum,xoay[i,5]);
                end;
        end;

begin
      assign(input,'CLOCKS.INP'); reset(input);
      assign(output,'CLOCKS.OUT'); rewrite(output);
      for i := 1 to 9 do read(start[i]);
      readln(k);
      for i := 1 to k do
        for j := 1 to 5 do read(xoay[i,j]);
      if check(start) then writeln(0)
       else
        begin
             res := 1 shl 60;
             ql(1,start,solan,0);
             if res = 1 shl 60 then writeln(-1)
              else writeln(res);
        end;

end.