Const   inp = '';
        out = '';
        maxn = 401;
Var     fi,fo   :       text;
        a,gt,mau,l       :       array [1..maxn] of longint;
        d       :      array [1..4] of integer;
        cx      :      array [1..4] of boolean;
        n,c,i,min,res,k      :       longint;

Procedure nhap;
Var i : longint;
        BEGIN
                assign(fi, inp); reset(fi);
                readln(fi, c, n);
                for i := 1 to n*c do readln(fi, mau[i], gt[i]);
                close(fi);

                fillchar(cx,sizeof(cx),true);
                res := maxint;
                k := n*c;
        END;
Procedure main;
Var u,v : longint;
        BEGIN
              for u := 1 to k do l[u] := 1;
              for u := 1 to k do a[u] := d[ mau[u] ] * 1000 + gt[u];
              for u := 1 to k do
                for v := 1 to u-1 do
                  if (a[u] > a[v]) and (l[u] < l[v] + 1) then l[u] := l[v] + 1;
              min := l[1];
              for u := 2 to k do if l[u] > min then min := l[u];
              if k - min < res then res := k - min;
        END;


Procedure ql(i : integer);
Var j : integer;
        BEGIN
              for j := 1 to c do
                if cx[j] then
                   BEGIN
                        d[i] := j;
                        cx[j] := false;
                        if i = c then main
                          else ql(i+1);
                        cx[j] := true;
                   END;
        END;
Procedure ghi;
        BEGIN
              assign(fo,out); rewrite(fo);
              write(fo,res);
              close(fo);
        END;

BEGIN
     nhap;
     ql(1);
     ghi;
END.