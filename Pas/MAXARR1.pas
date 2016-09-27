Program MAXARR1;
Const   inp = '';
        out = '';
        maxn = 1000100;
Var     fi,fo   :       text;
        t,max     :       longint;
        a,maxa       :       array [0..maxn] of longint;
        b       :       array [1..maxn] of longint;
{*      *       *       *       *       *}
Procedure Xuly;
Var j : longint;
BEGIN
    For j:=2 to max do
      BEGIN
          if a[j]=0 then
             BEGIN
                 if j mod 2 = 0 then a[j]:=a[j div 2]
                   else a[j]:=a[j div 2] + a[j div 2 +1];
             END;
      END;
      maxa[1]:=a[1];
      For j:=2 to max do
        if a[j]>maxa[j-1] then maxa[j]:=a[j]
          else maxa[j]:=maxa[j-1];
END;
{*      *       *       *       *       *}
Procedure Output;
Var j : longint;
BEGIN
    For j:=1 to t do
      Writeln(fo,maxa[b[j]]);
END;
{*      *       *       *       *       *}
procedure init;
BEGIN
    fillchar(a,sizeof(a),0);
    a[0]:=0;
    a[1]:=1;
END;
{*      *       *       *       *       *}
Procedure Input;
Var i : longint;
BEGIN
     assign(fi,inp);reset(fi);
     assign(fo,out);rewrite(fo);
     readln(fi,t);
     init;
     For i:=1 to t do
           readln(fi,b[i]);
     max:=b[1];
     For i:=2 to t do if b[i]>max then max:=b[i];
     xuly;
     output;
     Close(fi);Close(fo);
END;
{*      *       *       *       *       *}
BEGIN
   input;
END.