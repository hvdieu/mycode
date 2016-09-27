Const   maxn = 1001;
Var     a       :       array [1..maxn] of longint;
        i,n,j,x,y,u,v   :       longint;
        ok      :       boolean;

procedure swap(var xx,yy : longint);
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;

begin
  //  assign(input,'asd.inp'); reset(input);
  //  assign(output,'asd.out'); rewrite(output);
    readln(n);
    ok := true;
    for i := 1 to n do read(a[i]);
    for i := 1 to n-1 do
      begin
          x := a[i]; y := a[i+1];
          if x > y then swap(x,y);
          for j := 1 to n-1 do if i <> j then
            begin
                u := a[j]; v := a[j+1];
                if (u > v) then swap(u,v);
                if (x < u) and (u < y) and (v > y) then
                  begin
                      ok := false;
                      break;
                  end;
            end;

      end;

    if ok then write('no')
     else write('yes');
end.