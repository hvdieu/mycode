program DOUBLE14;
const
    inp='DOUBLE14.Inp';
    oup='DOUBLE14.Out';
    max=11000;
type
    LNode=record
        X,Y:longint;
    end;
var
    F:text;
    L:array[1..max] of LNode;
    N:longint;
    Head,Next,Ke,Cost,X,Y,C:array[1..max*2] of longint;
    Head1,Next1,Ke1:array[1..max*2] of longint;
    count:array[1..max] of longint;
    DD:array[1..max] of longint;
    Lt,Pa,Cpa,CountLt:array[1..max] of longint;
    Numedge,Numedge1:longint;
    i:longint;
    Dp:array[1..max,0..2] of longint;
    Ans1,Ans2:longint;
    NumLt:longint;
    Ok:array[1..max] of boolean;
    PaX,PaY:longint;

function Minval(X,Y:longint):longint;
begin
    if X>Y then exit(Y) else exit(X);
end;

procedure Addedge(X1,Y1,C1:longint);
begin
    inc(Numedge);
    Ke[Numedge]:=Y1;
    Cost[Numedge]:=C1;
    Next[Numedge]:=Head[X1];
    Head[X1]:=Numedge;
    X[Numedge]:=X1;
    Y[Numedge]:=Y1;
    C[Numedge]:=C1;
end;

procedure Addedge1(X1,Y1:longint);
begin
    inc(Numedge1);
    Ke1[Numedge1]:=Y1;
    Next1[Numedge1]:=Head1[X1];
    Head1[X1]:=Numedge1;
end;

function Find(X:longint):longint;
begin
    if Pa[X]<0 then exit(X);
    exit(Find(Pa[X]));
end;

procedure Union(X,Y:longint);
var paX,paY:longint;
begin
    paX:=Find(X);
    paY:=Find(Y);
    if Pa[paX]<Pa[PaY] then
        begin
            Pa[Pax]:=Pa[Pax]+Pa[Pay];
            Pa[Pay]:=Pax;
        end
    else
        begin
            Pa[Pay]:=Pa[Pay]+Pa[Pax];
            Pa[Pax]:=Pay;
        end;
end;

procedure DFS(Pos:longint);
var i:longint;
begin
    Lt[Pos]:=NumLt;
    CountLt[NumLt]:=CountLt[NumLt]+1;
    i:=Head[Pos];
    while i>0 do
        begin
            if (Lt[Ke[i]]=0) and (Cost[i]=1) then
                begin
                    DFS(Ke[i]);
                end;
            i:=Next[i];
        end;
end;

procedure DFSFind(Pos:longint);
var i:longint;
begin
    Lt[Pos]:=NumLt;
    i:=Head[Pos];
    while i>0 do
        begin
            if (Lt[Ke[i]]=0) then
                begin
                    DFSFind(Ke[i]);
                end;
            i:=Next[i];
        end;
end;

procedure DFSCalc(Pos:longint);
var i:longint;
    Res:array[0..2] of longint;
begin
    i:=Head1[Pos];
    while i>0 do
        begin
            if CPa[Pos]<>Ke1[i] then
                begin
                    CPa[Ke1[i]]:=Pos;
                    DFSCalc(Ke1[i]);
                end;
            i:=Next1[Pos];
        end;
    Res[1]:=CountLt[Pos];
    Res[0]:=0;
    Res[2]:=0;
    Dp[Pos,2]:=N+1;
    i:=Head1[Pos];
    while i>0 do
        begin
            if Cpa[Pos]<>Ke1[i] then
                begin
                    Res[1]:=Res[1]+minval(Dp[Ke1[i],0],minval(Dp[Ke1[i],1],Dp[Ke1[i],2]));
                    Res[0]:=Res[0]+Dp[Ke1[i],2];
                    Res[2]:=Res[2]+minval(Dp[Ke1[i],2],Dp[Ke1[i],1]);
                end;
            i:=Next1[Pos];
        end;
    i:=Head1[Pos];
    while i>0 do
        begin
            if Cpa[Pos]<>Ke1[i] then
                begin
                    Dp[Pos,2]:=minval(Dp[Pos,2],(Res[2]-minval(Dp[Ke1[i],2],Dp[Ke1[i],1])+Dp[Ke1[i],1]));
                end;
            i:=Next1[Pos];
        end;
    Dp[Pos,1]:=Res[1];
    Dp[Pos,0]:=Res[0];
end;

begin
    assign(input,inp); reset(input);
    assign(output,oup); rewrite(output);
    readln(N);
    for i:=1 to N do read(L[i].X);
    readln;
    for i:=1 to N do read(L[i].Y);
    for i:=1 to N do
        begin
            inc(Count[L[i].X]);
            inc(Count[L[i].Y]);
        end;
    for i:=1 to N do if Count[i]<>2 then
        begin
            writeln('0 0');
            exit;
        end;
    for i:=1 to N do
        begin
            if DD[L[i].X]=0 then
                begin
                    DD[L[i].X]:=i;
                end
            else
                begin
                    if DD[L[i].X]>0 then
                        begin
                            Addedge(i,DD[L[i].X],0);
                            Addedge(DD[L[i].X],i,0);
                        end
                    else
                        begin
                            Addedge(i,-DD[L[i].X],1);
                            Addedge(-DD[L[i].X],i,1);
                        end;
                end;
            if DD[L[i].Y]=0 then
                begin
                    DD[L[i].Y]:=-i;
                end
            else
                begin
                    if DD[L[i].Y]<0 then
                        begin
                            Addedge(i,-DD[L[i].Y],0);
                            Addedge(-DD[L[i].Y],i,0);
                        end
                    else
                        begin
                            Addedge(i,DD[L[i].Y],1);
                            Addedge(DD[L[i].Y],i,1);
                        end;
                end;
        end;
    for i:=1 to N do if Lt[i]=0 then
        begin
            inc(NumLt);
            DFS(i);
        end;
    fillchar(Pa,sizeof(Pa),$FF);
    for i:=1 to Numedge do if (C[i]=0) then
        begin
            PaX:=Find(Lt[X[i]]);
            PaY:=Find(Lt[Y[i]]);
            if Pax=Pay then continue;
            Addedge1(Lt[X[i]],Lt[Y[i]]);
            Addedge1(Lt[Y[i]],Lt[X[i]]);
            Ok[Lt[X[i]]]:=true;
            Ok[Lt[Y[i]]]:=true;
            Union(Lt[X[i]],Lt[Y[i]]);
        end;
    for i:=1 to NumLt do if (Ok[i]) and (CPa[i]=0) then
        begin
            Cpa[i]:=-1;
            DFSCalc(i);
            Ans2:=Ans2+Minval(Dp[i,1],Dp[i,2]);
        end;
    fillchar(Lt,sizeof(Lt),0);
    NumLt:=0;
    for i:=1 to N do if Lt[i]=0 then
        begin
            inc(NumLt);
            DFSFind(i);
        end;
    Ans1:=1;
    for i:=1 to NumLt do Ans1:=Ans1*2;
    writeln(Ans1,' ',Ans2);
end.