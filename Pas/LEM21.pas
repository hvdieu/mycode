Const
        finp='';
        fout='';
Type
        mat=array [0..2000000] of longint;
        mat1=array [0..100] of longint;
Var     queue,d:mat;
        a:mat1;
        n,k,res,trangthai,r,f:longint;
        fi,fo:text;

Procedure Doc;
        Var i,s,j,y:longint;
        Begin
                Assign(fi,finp);
                Reset(fi);
                Read(fi,n,k);
                For i:=1 to n do
                  Begin
                        a[i]:=1 shl n-1;
                        Read(fi,s);
                        For j:=1 to s do
                          Begin
                                Read(fi,y);
                                a[i]:=a[i] xor (1 shl (y-1));
                          end;
                  end;
                trangthai:=0;
                For i:=1 to n do
                  Begin
                        Read(fi,y);
                        If y=1 then
                        trangthai:=trangthai or (1 shl (i-1));
                  end;
                k:=1 shl (k-1);
                Close(fi);
        end;

Procedure Push(x:longint);
        Begin
                inc(r);
                queue[r]:=x;
        end;

Function Pop:longint;
        Begin
                pop:=queue[f];
                inc(f);
        end;

Procedure Bfs;
        Var i,j,tt,x:longint;
        Begin
                f:=1;
                r:=0;
                res:=-1;
                d[trangthai]:=0;
                Push(trangthai);
                While f<=r do
                  Begin
                        x:=pop;
                        If x=k then
                          Begin
                                res:=d[x];
                                exit;
                          end;
                        For i:=1 to n do
                          Begin
                                tt:=(x and a[i]) or (1 shl(i-1));
                                If d[tt]=0 then
                                     Begin
                                        d[tt]:=d[x]+1;
                                        Push(tt);
                                     end;
                          end;
                  end;
        end;

Procedure Inkq;
        Begin
                Assign(fo,fout);
                Rewrite(fo);
                Write(fo,res);
                Close(fo);
        end;

        Begin
                Doc;
                Bfs;
                Inkq;
        end.