{$Inline off}
Uses math;
Type
        mat=array [1..2500,-50..2500] of longint;
        mat1=array [0..25000] of longint;
Var     f:mat;
        a,dd,q:mat1;
        n,k,p,res,f1,r1:longint;
        fi,fo:text;

Procedure Doc;  inline;
        Var i:longint;
        Begin
                Read(fi,n,k,p);
                For i:=1 to n do
                    Begin
                        Read(fi,a[i]);
                        dd[a[i]]:=1;
                    end;
        end;

Procedure Push(i,j:longint); inline;
        Begin
                While (f1<=r1) and (f[i,j]>=f[i,q[r1]]) do dec(r1);
                inc(r1);
                q[r1]:=j;
        end;

Procedure Lam;   inline;
        Var i,j,t:longint;
        Begin
                For j:=0 to 2500 do f[1,j]:=dd[j];
                For i:=2 to n do
                 Begin
                 f1:=1;
                 r1:=0;
                 For j:=-p to -k do Push(i-1,j);
                 For j:=0 to 2500 do
                  Begin
                    f[i,j]:=f[i-1,q[f1]]+dd[j];
                    Push(i-1,j-k+1);
                    While (f1<=r1) and (q[f1]<j-(p-k)) do inc(f1);
                  end;
                 end;
                For j:=0 to 2500 do res:=Max(res,f[n,j]);
                res:=n-res;
        end;

Procedure Inkq; inline;
        Begin
                Writeln(fo,res);
        end;

        Begin
              //  Assign(fi,'input.txt');Reset(fi);
              //  Assign(fo,'output.out');Rewrite(fo);
                        Doc;
                        Lam;
                        Inkq;
                Close(fo);Close(fi);
        end.
