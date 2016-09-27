Const   inp = '';
        out = '';
        maxn = 10001;
        maxk = 1001;
Var     fi,fo   :       text;
        n,k     :       longint;
        posx,posy,px,py,x       :       array [1..maxk] of longint;
        i,j,dem     :       longint;
{*      *       *       *}
Procedure Solve;
Var i,j,t,s : longint;
BEGIN
    For i:=1 to k do
      BEGIN
          t:=x[i];
          if t mod n = 0 then
            BEGIN
                posx[i] := t div n;
                posy[i] := n;
            END
             else BEGIN
                   posx[i]:= t div n + 1 ;
                   posy[i]:= t mod n;
            END;
      END;
    For i:=1 to k do
      BEGIN
         dem:=0;
         if posy[i] < py[i] then
           BEGIN
               s:= py[i] - posy[i];
               dem:= dem + s;
               For j:=i+1 to k do
                 if posx[i] = posx[j] then
                   BEGIN
                       posy[j] := posy[j] + s;
                       if posy[j] > n then posy[j] := posy[j] - n;
                   END;
           END
             else if posy[i] > py[i] then
                 BEGIN
                     s:= n - posy[i] + py[i];
                     dem:=dem + s;
                      For j:= i+1 to k do
                        if posx[i] = posx[j] then
                          BEGIN
                              posy[j] := posy[j] + s;
                              if posy[j] > n then posy[j] := posy[j] - n;
                          END;
                 END;
           posy[i] := py[i];
           if posx[i] < px[i] then
             BEGIN
                 s:= px[i] - posx[i];
                 dem:= dem + s;
                 For j:= i+1 to k do
                   if posy[i] = posy[j] then
                     BEGIN
                         posx[j] := posx[j] + s;
                         if posx[j] > n then posx[j] := posx[j] - n;
                     END;
             END
               else if posx[i] > px[i] then
                 BEGIN
                     s:= n- posx[i] + px[i];
                     dem:= dem + s;
                     For j:= i+1 to k do
                       if posy[j] = posy[i] then
                         BEGIN
                             posx[j] := posx[j] + s;
                             if posx[j] > n then posx[j] := posx[j] -n;
                         END;
                 END;
           posx[i] := px[i];
           writeln(fo,dem);
      END;
END;
{*      *       *       *}
BEGIN
    Assign(fi,inp);reset(fi);
    readln(fi,n,k);
    For i:=1 to k do
     readln(fi,x[i],px[i],py[i]);
    close(fi);
    dem:=0;
    Assign(fo,out);rewrite(fo);
    Solve;
    close(fo);
END.