Const   inp = 'PRIMREC.INP';
        out = 'PRIMREC.OUT';
        maxn = 8;
Var     fi,fo   :       text;
        start,a       :       array [1..maxn,1..maxn] of char;
        m,n     :       integer;
        k       :       longint;
        s       :       string[8];
        x       :       array [0..9] of char;
        ok      :       boolean;
{*      *       *       *       *}
Procedure input;
Var i,j : integer;
    ch : char;
BEGIN
    assign(fi,inp);reset(fi);
    readln(fi,m,n);
    For i:=1 to m do
     BEGIN
      For j:=1 to n do
        read(fi,start[i,j]);
        readln(fi);
     END;
    close(fi);
    a:=start;
    x[0]:='0';
    x[1]:='1';
    x[2]:='2';
    x[3]:='3';
    x[4]:='4';
    x[5]:='5';
    x[6]:='6';
    x[7]:='7';
    x[8]:='8';
    x[9]:='9';

END;
{*      *       *       *       *}
Procedure Kiemtra;
Var l : longint;
BEGIN
    ok:=true;
    For l:=2 to trunc (  sqrt(k) ) do
      BEGIN
          if k mod l = 0 then
            BEGIN
                ok:=false;
                exit;
            END;
      END
END;
{*      *       *       *       *}

Procedure Solve;
Var r,t : integer;
BEGIN
    For r:=1 to m do
      BEGIN
          s:='';
          For t:=1 to n do
          s:=s+a[r,t];
          Val(s,k);
          Kiemtra;
          if ok=false then exit;
      END;
    For t:=1 to n do
      BEGIN
          s:='';
          For r:=1 to m do
            s:=s+a[r,t];
            Val(s,k);
            Kiemtra;
            if ok=false then exit;
      END;
    Assign(fo,out);rewrite(fo);
    For r:=1 to m do
      BEGIN
          For t:=1 to n do
            write(fo,a[r,t]);
            writeln(fo);
      END;
    Close(fo);
    halt;
END;
{*      *       *       *       *}
Procedure Try(i,j : integer);
Var u,v : integer;
BEGIN
    if start[i,j]='.' then
      BEGIN
          For u:=0 to 9 do
            BEGIN
                if (i=m) or (j=n) then
                BEGIN
                 if u mod 2 <>0 then
                 BEGIN
                a[i,j]:=x[u];
                if (i=m) and (j=n) then solve
                  else
                    if (j=n) and (i<m) then Try(i+1,1)
                      else if j<n then Try(i,j+1);
                  END;
                  END
                    else if (i<m) and (j<n) then
                      BEGIN
                         a[i,j]:=x[u];
                if (i=m) and (j=n) then solve
                  else
                    if (j=n) and (i<m) then Try(i+1,j)
                      else if j<n then Try(i,j+1);
                      END;

            END;
      END
       else if (i=m) and (j=n) then solve
                  else
                    if (j=n) and (i<m) then Try(i+1,1)
                      else if j<n then Try(i,j+1);
END;
{*      *       *       *       *}
BEGIN
      Input;
      Try(1,1);
      Assign(fo,out);rewrite(fo);
      write(fo,'Impossible.');
      close(fo);
END.
