Const    inp = 'PBCDIV.INP';
         out = 'PBCDIV.OUT';
Var      fi,fo :        text;
         t,res,i     :       longint;
         a,b    :       int64;
{*       *      *       *       *}
BEGIN
    Assign(fi,inp);reset(fi);
    Assign(fo,out);rewrite(fo);
    readln(fi,t);
    For i:=1 to t do
      BEGIN
         readln(fi,a,b);
         res:= b div 12 + b div 30 - 2*(b div 60) - (a-1) div 12 - (a-1) div 30 + 2* ((a-1) div 60);
         writeln(fo,res);
      END;
    Close(fi);close(fo);
END.

