Const   inp = '';
        out = '';
Var     fi,fo : text;
        t,num,dem       :       longint;
        a       :       array [1..500000] of longint;
        s       :       string;
{*      *       *       *       *       *}
procedure Try( i,n : integer);
Var j : integer;
BEGIN
    For j:=1 to 9 do
      if j mod 2 = 1 then
        BEGIN
            num:= num * 10 + j;
            if i = n then
                BEGIN
                    Inc(dem);
                    a[dem] := num;
                END
                  else Try(i+1,n);
            num := num div 10;

        END;
END;
{*      *       *       *       *       *}
Procedure Solve;
Var i : longint;
BEGIN
    For i:=1 to 8 do
        BEGIN
                num := 0;
                Try(1,i);
        END;

END;
{*      *       *       *       *       *}
Function find(d,c,key : longint) : longint;
Var res,mid : longint;
BEGIN
        mid:= (d + c) div 2;
        While d <= c do
          BEGIN
              mid:= (d+c) div 2;
              if a[mid] = key then
                 BEGIN
                     find := mid;
                     exit;
                 END
                   else if a[mid] > key then
                        BEGIN
                                c:= mid -1;
                        END
                          else d:= mid + 1;
          END;
        find := c + 1 ;
END;
{*      *       *       *       *       *}
Procedure Xuly;
Var i,res,d1,d2 : longint;
BEGIN
    res:= maxlongint;
    if t > 3 then
    BEGIN
    d1 := find(1,dem,t);
    d1 := d1 - 1;
    For i:=1 to dem do
      BEGIN
          if a[i] > t then break;
          While (d1 > 1) and (a[d1 -1 ] + a[i] >= t ) do dec(d1);
          if (a[i] + a[d1] < res) and (a[i] + a[d1] >= t) then res := a[i] + a[d1];
      END;
    writeln(fo,res);
    END
        else
                BEGIN
                        if t = 1 then writeln(fo,2);
                        if t = 2 then writeln(fo,2);
                        if t = 3 then writeln(fo,4);
                        exit;
                END;

END;
{*      *       *       *       *       *}
Procedure nhap;
Var i : longint;
    ok : boolean;
BEGIN
    Assign(fi,inp);reset(fi);
    Assign(fo,out);rewrite(fo);
    ok := true;
    While ok do
      BEGIN
          readln(fi,s);
          if s= '[CASE]' then
            BEGIN
                readln(fi,t);
                readln(fi);
                xuly;
            END
              else ok:=false;

      END;
    close(fi);
    close(fo);
END;
{*      *       *       *       *       *}
BEGIN
   Solve;
   nhap;
END.
