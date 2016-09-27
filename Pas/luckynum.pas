uses math;
Const
    inp = '3.in';
    out = '3.out';
    maxn = 100010;
    M = 1000000007;

Var
    n,k,i,j,count1,count2,count3,count4 : longint;
    f,g : array [-1..maxn,0..1,0..1] of int64;
    ff : array [0..maxn,0..1] of int64;
    ss : string;

procedure counter;
    var i,j,dem : longint;
        ss : string;
        ok : boolean;
begin
    count1 := 0; count2 := 0; count3 := 0;
    count4 := 0;
    for i := 10000 to 99999 do
      begin
          str(i,ss);
          if ss[1] = '6' then dem := 1
           else dem := 0;
          ok := false;
          for j := 2 to length(ss) do
           begin
               if ss[j] = '6' then inc(dem)
                else dem := 0;
               if dem >= k then ok := true;
           end;
          if ok then
           begin
              if ss[length(ss)] = '6' then inc(count4)
               else inc(count3);
           end
           else
            begin
              if ss[length(ss)] = '6' then inc(count2)
               else inc(count1);
            end;
      end;
end;

procedure sub3;
    var i,j : longint;
begin
    ff[1][0] := 8; ff[1][1] := 1;
    for i := 2 to n do
      begin
          ff[i][0] := (ff[i-1][0]*9) mod M;
          ff[i][1] := (ff[i-1][1]*10+ff[i-1][0]) mod M;
      end;
    writeln(ff[n][1]);
end;


procedure sub1;
    var i,j,L,R : longint;
        ss : string;
        ok : boolean;
begin
    fillchar(f,sizeof(f),0);
    fillchar(g,sizeof(g),0);
    f[1][0][0] := 8; f[1][0][1] := 1;
    f[0][0][0] := 1;
    for i := 2 to n do
      begin
          f[i][0][0] := ((f[i-1][0][1]+f[i-1][0][0])*9) mod M;
          f[i][1][0] := ((f[i-1][1][0]+f[i-1][1][1])*9) mod M;
          for j := i-k downto 0 do
           f[i][1][1] := (f[i][1][1] + f[j][0][0]+f[j][1][0]) mod M;
          for j := i-1 downto max(i-k+1,0) do
          begin
           f[i][0][1] := (f[i][0][1] + f[j][0][0]) mod M;
           f[i][1][1] := (f[i][1][1] + f[j][1][0]) mod M;
          end;
         j := j+1;
      end;
    writeln((f[n][1][1] + f[n][1][0]) mod M);
end;

procedure sub2;
    var i,j,L,R,t1,t2 : longint;
        ss : string;
        ok : boolean;
begin
    fillchar(f,sizeof(f),0);
    fillchar(g,sizeof(g),0);
    f[1][0][0] := 8; f[1][0][1] := 1;
    g[1][0][0] := 9; g[1][0][1] := 1;
    f[0][0][0] := 1; g[0][0][0] := 1;
    for i := 2 to n do
      begin
          f[i][0][0] := ((f[i-1][0][1]+f[i-1][0][0])*9) mod M;
          f[i][1][0] := ((f[i-1][1][0]+f[i-1][1][1])*9) mod M;
          L := 0; R := i-k;
          if L <= R then
           f[i][1][1] := (g[R][0][0] - g[L-1][0][0] + g[R][1][0] - g[L-1][1][0] +2*M) mod M;
          L := max(i-k+1,0); R := i-1;
          f[i][0][1] := (f[i][0][1] + g[R][0][0] - g[L-1][0][0]+M) mod M;
          f[i][1][1] := (f[i][1][1] + g[R][1][0] - g[L-1][1][0] + M) mod M;
          for t1 := 0 to 1 do
           for t2 := 0 to 1 do
            g[i][t1][t2] := (g[i-1][t1][t2] + f[i][t1][t2]) mod M;
      end;
    writeln((f[n][1][1] + f[n][1][0]) mod M);
end;

procedure process;
    var i,j : longint;
begin
     assign(input,ss+'.in'); reset(input);
     assign(output,ss+'.out') ;rewrite(output);
     readln(n,k);
  //   counter;
      if k = 1 then sub3
      else
     if n <= 1000 then sub1
      else sub2;
     close(input); close(output);
end;

procedure make;
    var i,j,nn : longint;
        fi,fo : text;
        inn,opp : string;
begin
    for nn := 26 to 50 do
      begin
          str(nn,ss);
          assign(fo,ss+'.in'); rewrite(fo);
          j := random(100000)+1;
          writeln(fo,j,' ',random(j)+1);
          close(fo);
          process;
      end;
end;

begin
     randomize;
     ss := '3';
     //make;
     process;
end.
