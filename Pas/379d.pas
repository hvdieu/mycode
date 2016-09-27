
Const   maxn = 51;
        inp = '';
        out = '';
Var     n,m,k,x,i1,i2,i3,i4,i,i5,k1,k2,k3,k4,k5 : longint;
        f       : array [1..maxn] of int64;
        g       : array [0..1] of integer;
        ch      : array [1..3] of char;
        s1,s2   : array [0..100] of char;
        ok : boolean;

procedure check;
var j,j1,j2,j3,j4,d1,d2,d3,d4,d5,vt : longint;
        begin
            for i := 0 to n do s1[i] := 'W';
            for i := 0 to m do s2[i] := 'W';
            for j1 := 1 to 3 do
             for j2 := 1 to 3 do
              for j3 := 1 to 3 do
               for j4 := 1 to 3 do
                begin
                   if ok then exit;
                   d3 := 0; d4 := 0; d5 := 0; d1 := 0; d2 := 0;
                   if ch[j2]+ch[j3]='AC' then inc(d3);
                   if ch[j4]+ch[j1]='AC' then inc(d4);
                   if ch[j4]+ch[j3]='AC' then inc(d5);
                   if (d3<>i3) or (d4<>i4) or (d5<>i5) then continue;
                   if ((n=1) and (j1<>j2)) or ((m=1) and (j3<>j4)) then continue;
                   s1[1] := ch[j1]; s1[n] := ch[j2]; s2[1] := ch[j3]; s2[m] := ch[j4];
                   for i := 2 to n-1 do
                    if i mod 2 = 0 then s1[i] := 'A' else s1[i] := 'C';
                   for i := 2 to n do
                    if (s1[i]='C') and (s1[i-1]='A') then inc(d1);
                   if (n=2) and (d1>i1) then continue;
                   if d1 > i1 then
                     begin
                         d1 := 0; vt := 0;
                         for i := 1 to n do
                          begin
                          if (s1[i]='C') and (s1[i-1]='A') then inc(d1);
                           begin
                               if d1=i1 then
                                begin
                                    vt := i; break;
                               end;
                           end;
                          end;
                          if vt=0 then continue;
                          for i := vt+1 to n-1 do s1[i] := 'W';
                     end
                   else if d1 < i1 then
                     begin
                         d1 := 0; vt := 0;
                         for i := 2 to n-1 do
                          if i mod 2 = 0 then s1[i] := 'C' else s1[i] := 'A';
                         for i := 2 to n do
                          if (s1[i]='C') and (s1[i-1]='A') then inc(d1);
                         if d1 > i1 then
                        begin
                         d1 := 0; vt := 0;
                         for i := 1 to n do
                         begin
                          if (s1[i]='C') and (s1[i-1]='A') then inc(d1);
                           begin
                               if d1=i1 then
                                begin
                                    vt := i; break;
                               end;
                           end;
                         end;
                         if vt=0 then continue;
                          for i := vt+1 to n-1 do s1[i] := 'W';
                         end else if d1<i1 then continue;
                     end;


                  d1 := 0;
                  for i := 2 to m-1 do
                    if i mod 2 = 0 then s2[i] := 'A' else s2[i] := 'C';
                   for i := 2 to m do
                    if (s2[i]='C') and (s2[i-1]='A') then inc(d1);
                   if(m=2) and (d1>i2) then continue;
                   if d1 > i2 then
                     begin
                         d1 := 0; vt:=0;
                         for i := 1 to m do
                         begin
                          if (s2[i]='C') and (s2[i-1]='A') then inc(d1);
                          if d1=i2 then
                           begin
                           vt := i; break;
                          end;
                           end;
                           if vt=0 then continue;
                          for i := vt+1 to m-1 do s2[i] := 'W';
                     end
                   else if d1 < i2 then
                     begin
                         d1 := 0; vt := 0;
                         for i := 2 to m-1 do
                          if i mod 2 = 0 then s2[i] := 'C' else s2[i] := 'A';
                         for i := 2 to m do
                          if (s2[i]='C') and (s2[i-1]='A') then inc(d1);
                         if d1 > i2 then
                        begin
                         d1 := 0; vt := 0;
                         for i := 1 to m do
                          if (s2[i]='C') and (s2[i-1]='A') then inc(d1);
                          begin
                           begin

                               if d1=i2 then
                                begin
                                    vt := i; break;
                               end;
                           end;
                          end;
                          if vt=0 then continue;
                          for i := vt+1 to m-1 do s1[i] := 'W';
                         end else if d1<i2 then continue;
                     end;
                   ok := true;
                   k1 := i1; k2 := i2; k3 := i3; k4 := i4; k5 := i5;
                end;
        end;

procedure main;
begin
       begin
            for i1 := 0 to n div 2 do
             for i2 := 0 to m div 2 do
              for i3 := 0 to 1 do
               for i4 := 0 to 1 do
                for i5 := 0 to 1 do
                  begin
                    fillchar(f,sizeof(f),0);
                    f[1] := i1; f[2] := i2;
                    f[3] := i1+i2+i3; g[0] := i4; g[1] := i5;
                    for i := 4 to k do
                     f[i] := f[i-1]+f[i-2]+g[i mod 2];
                    if f[k]=x then check;
                    if ok then exit;
                  end;
        end;
end;

begin
    assign(input,inp); reset(input);
    assign(output,out); rewrite(output);
    readln(k,x,n,m); ch[1] := 'A'; ch[2] := 'C'; ch[3] := 'W';

   // i1 := 0; i2 := 0; i3 := 0; i4 := 0; i5 := 1;
   // check;
   if x = 0 then
     begin
         for i := 1 to n do write('A');writeln;
         for i := 1 to m do write('A');
     end else begin
    main;
    if ok=false then write('Happy new year!')
     else
       begin
           for i := 1 to n do write(s1[i]); writeln;
           for i := 1 to m do write(s2[i]);
       end;
    end;
end.
