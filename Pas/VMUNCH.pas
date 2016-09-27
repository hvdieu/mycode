Program VMUNCH;
Const    inp = '';
         out = '';
         maxn = 200;
         h      :       array [1..4] of integer = (-1,0,1,0);
         c      :       array [1..4] of integer = (0,1,0,-1);
Var      fi,fo  :       text;
         r,c1,rb,cb,left,right      :       integer;
         a      :       array [1..maxn,1..maxn] of char;
         d      :       array [0..maxn,0..maxn] of boolean;
         qh,qc  :       array [1..maxn*maxn] of integer;
         dd     :       array [1..maxn,1..maxn] of longint;
{*       *      *       *       *}
Procedure Input;
Var i,j : integer;
BEGIN
      fillchar(d,sizeof(d),false);
      assign(fi,inp);reset(fi);
      readln(fi,r,c1);
      For i:=1 to r do
       BEGIN
         For j:=1 to c1 do
           BEGIN
             read(fi,a[i,j]);
             if a[i,j]='C' then  BEGIN
                                     rb:=i;
                                     cb:=j;
                                 END;
             d[i,j]:=true;
             if a[i,j]='*' then d[i,j]:=false;
           END;
         readln(fi);
       END;
       qh[1]:=rb;
       qc[1]:=cb;
       left:=0;
       right:=1;
       dd[rb,cb]:=0;

END;
{*      *       *       *       *}
Procedure Loangrong;
Var i,j,xx,yy,k : integer;
BEGIN
    While left<right do
      BEGIN
          Inc(left);
          xx:=qh[left];
          yy:=qc[left];
          d[xx,yy]:=false;
          For k:=1 to 4 do
            BEGIN
               If d[xx+h[k],yy+c[k]] then
                 BEGIN
                    Inc(right);
                    qh[right]:=xx+h[k];
                    qc[right]:=yy+c[k];
                    dd[xx+h[k],yy+c[k]]:=dd[xx,yy]+1;
                    d[xx + h[k], yy + c[k]]:=false;
                 END;
            END;
      END;
END;
{*      *       *       *       *}
Procedure Output;
BEGIN
    Assign(fo,out);rewrite(fo);
    Write(fo,dd[1,1]);
    Close(fo);
END;
{*      *       *       *       *}
BEGIN
     Input;
     loangrong;
     output;
END.
