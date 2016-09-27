Uses    math;
Const   Fi      =       'VQUERY.INP';
        Fo      =       'VQUERY.OUT';
        Mn      =       Trunc(1e5)+1;
        Mm      =       1000+1;
        VC      =       Trunc(1e9);
Type    deta    =       record
                r,a,b,c,d       :       int64;
                end;
Var     F1,F2   :       text;
        N,R,Q,P :       int64;
        U,V,K   :       int64;
        G       :       Array[1..Mn] of longint;
        F       :       Array[0..10000,1..Mm] of longint;
        H       :       Array[0..10000,1..Mn] of longint;
        IT      :       Array[1..Mn*4] of longint;
        W       :       Array[1..mn] of deta;
        L,X,LL  :       int64;
        A,B,C,D :       int64;
        OK      :       Boolean;
Procedure       Mofile;
Begin
        Assign(f1,fi);
        Reset(f1);
        Assign(f2,fo);
        Rewrite(f2);
End;
///////////////////////////
Procedure       Update(x,l,r,u,k:longint);
Var     m       :       longint;
Begin
        If (l=r) then
        Begin
                If (l=u) then IT[x]:=K;
                Exit;
        End;
        If (u<l) or (r<u) then Exit;
        m:=(l+r) div 2;
        Update(2*x,l,m,u,k);
        Update(2*x+1,m+1,r,u,k);
        IT[x]:=Max(IT[2*x],IT[2*x+1]);
End;
//////////////////////////
Procedure       Docfile;
Var     i,j     :       longint;
Begin
        Readln(F1,N);
        For i:=1 to N do
        Begin
                Read(f1,G[i]);
                Update(1,1,N,I,G[i]);
                F[0,i]:=G[i];
                H[0,i]:=G[i];
        End; //Readln(f1);
        Readln(F1,R,Q);
        If R*Q<=1000 then
                Ok:=True
        Else
                Ok:=False;
        For i:=1 to Q do
        With W[i] do REadln(f1,R,a,b,c,d);
End;
////////////////////////////
Function        Get(x,l,r,u,v:longint):longint;
Var     m       :       longint;
Begin
        If (u<=l) and (r<=v) then Exit(IT[x]);
        If (v<l)  or  (r<u)  then Exit(0);
        m:=(l+r) div 2;
        Exit(Max(Get(2*x,l,m,u,v),Get(2*x+1,m+1,r,u,v)));
End;
/////////////////////////////
Procedure       Xulyfile;
Var     i,j,e   :       longint;
Begin
        For i:=1 to R do
        For e:=1 to Q do
        Begin
                R:=W[e].r;
                A:=W[e].A;
                B:=W[e].B;
                C:=W[e].C;
                D:=W[e].D;
                If R=1 then
                Begin
                        u := (L*a+c) mod N + 1;
                        k := (L*b+d) mod VC + 1;
                        writeln(f2,u,' ',k);
                        G[u]:=K;
                        Inc(ll);
                        If Ok then
                                For j:=1 to N do F[ll,j]:=G[j]
                        Else
                                For j:=1 to N do H[ll,j]:=G[j];
                        Update(1,1,N,U,K);
                        Inc(p);
                End else
                If R=2 then
                Begin
                        u := (L*a+c) mod N + 1;
                        v := (L*b+d) mod N + 1;
                        writeln(f2,u,' ',v);
                        If u>v then
                        Begin
                                k:=u;
                                u:=v;
                                v:=k;
                        End;
                        L:=Get(1,1,n,U,V);
                        //Writeln(F2,L);
                End else
                Begin
                        x := (L*a + c) mod (P+1);
                        writeln(f2,x,' ');
                        Inc(ll);
                        If Ok then
                        Begin
                                For j:=1 to N do G[j]:=F[x,j];
                                For j:=1 to N do F[ll,j]:=G[j];
                        End else
                        Begin
                                For j:=1 to N do G[j]:=H[x,j];
                                For j:=1 to N do H[ll,j]:=G[j];
                        End;
                        For j:=1 to N do Update(1,1,N,j,G[j]);
                End;
        End;
End;
/////////////////////////////
Procedure       Dongfile;
Begin
        Close(f1);
        Close(f2);
End;
//////////////////////////////
Begin
        Mofile;
        Docfile;
        Xulyfile;
        Dongfile;
End.
