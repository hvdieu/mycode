Type    arr   = array [1..3] of longint;
Var     n,m,x1,y1,z1,x2,y2,z2,res,i    :       longint;
        a       :       array [0..4,0..4,0..4,0..4,0..4,0..4] of boolean;
        free,doi    :       array [0..4,0..4,0..4] of boolean;
        sl      :   array [0..4,0..4,0..4] of longint;
        queue   :       array [1..20000] of arr;
        d       :       array [1..20000] of longint;
        kq      :       boolean;
        s,t     :       arr;

{***************************************************************************}
procedure main;
var i,j,left,right : longint;
    u,v : arr;
    ok : boolean;
        begin
              left := 0; right := 1;
              fillchar(free,sizeof(free),true);
              free[s[1],s[2],s[3]] := false;
              queue[1] := s;
              while left < right do
                begin
                    inc(left); u := queue[left];
                    for x1 := 0 to u[1] do
                    for y1 := 0 to u[2] do
                    for z1 := 0 to u[3] do
                    for x2 := 0 to 4 do
                    for y2 := 0 to 4 do
                    for z2 := 0 to 4 do
                     if a[x1,y1,z1,x2,y2,z2] then
                       begin
                           v[1] := u[1]-x1+x2; v[2] := u[2]-y1+y2;
                           v[3] := u[3]-z1+z2;
                           if (v[1] <= 4) and (v[2] <= 4) and (v[3] <= 4)
                            and (free[v[1],v[2],v[3]]) then
                            begin
                               free[v[1],v[2],v[3]] := false;
                               ok := true;
                               for i := 1 to 3 do
                                if v[i] < t[i] then ok := false;
                                if ok then
                                  begin
                                     kq := true;
                                     doi[v[1],v[2],v[3]] := true;
                                     sl[v[1],v[2],v[3]] := d[left]+1;
                                  end
                                else
                                  begin
                                     inc(right); queue[right] := v;
                                     d[right] := d[left]+1;
                                  end;
                            end;
                       end;
                end;
        end;
{***************************************************************************}
procedure ghi;
var i,j,k : longint;
        begin
            for i := t[1] to 4 do
             for j := t[2] to 4 do
              for k := t[3] to 4 do
               if doi[i,j,k] then inc(res);
            writeln(res);
            for i := t[1] to 4 do
             for j := t[2] to 4 do
              for k := t[3] to 4 do
               if doi[i,j,k] then writeln(i,' ',j,' ',k,' ',sl[i,j,k]);
        end;
{***************************************************************************}
begin
     assign(input,'asd.inp'); reset(input);
     assign(output,'asd.out'); rewrite(output);
     readln(m);
     for i := 1 to 3 do read(s[i]);
     for i := 1 to 3 do read(t[i]);
     readln;
     while not eof(input) do
       begin
           read(x1,y1,z1,x2,y2,z2);
           a[x1,y1,z1,x2,y2,z2] := true;
       end;
     main;
     if kq = false then write(-1)
      else ghi;
end.


