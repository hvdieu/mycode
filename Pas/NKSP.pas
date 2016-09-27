
Const   maxn = 1001;
        oo = 1000000007;
Var     n       :       longint;
        s       :       ansistring;
        h1,h2,mu :       array [0..maxn] of int64;
        d       :       array [1..maxn,1..maxn] of boolean;
        res     :       int64;

procedure main;
var i,j,k : longint;
    p1,p2 : int64;
        begin
            mu[0] := 1;
            n := length(s);
            for i := 1 to n do mu[i] := (int64(mu[i-1])*26) mod oo;
            for i := 1 to n do
             h1[i] := (int64(h1[i-1])*26 + ord(s[i]) - ord('a')) mod oo;
            for i := n downto 1 do
             h2[i] := (int64(h2[i+1])*26 + ord(s[i]) - ord('a')) mod oo;
            for i := 2 to n do
              for j := i-1 downto 1 do
               begin
                    p1 := (h1[i] - int64(h1[j-1])*mu[i-j+1] + int64(oo)*oo) mod oo;
                    p2 := (h2[j] - int64(h2[i+1])*mu[i-j+1] + int64(oo)*oo) mod oo;
                    if p1 = p2 then
                     begin
                       d[j,i] := true;
                     end;
               end;

            for j := 2 to n do
             for i := j-1 downto 1 do
              if d[i,j] = false then
              for k := i to j-1 do
               begin
                   if d[i,k] and d[k+1,j] then
                     begin
                         d[i,j] := true;
                         break;
                     end;
               end;
             for i := 1 to n do
              for j := 1 to n do if d[i,j] = true then inc(res);
             write(res);
        end;

begin
    assign(input,'nksp.inp'); reset(input);
  assign(output,'nksp.out'); rewrite(output);
    read(s);
    main;
end.

