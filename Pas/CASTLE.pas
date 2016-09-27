Program CASTLE;
Const   inp = 'castle.in';
        out = 'castle.out';
        maxn = 55;
        maxs = 2500;
        hang    :       array [1..4] of integer = (1,0,-1,0);
        cot     :       array [1..4] of integer = (0,1,0,-1);
        c       :       array [1..4] of integer = (8,4,2,1);
        direction       :       array [1..4] of char = ('S','E','N','W');
Var     fi,fo   :       text;
        a       :       array [1..maxn,1..maxn] of integer;
        d       :       array [0..maxn+1,0..maxn+1] of integer;
        m,n     :       integer;
        dem,max,maxsum,kqi,kqj,kqmax     :       integer;
        s,cs       :       array [1..maxs] of integer;
        dir     :  char;
        maxkq   :  longint;
{*      *       *       *       *}
Procedure Input;
Var i,j,k,u,v : integer;
BEGIN
    assign(fi,inp);reset(fi);
    readln(fi,n,m);
    for i:=1 to m do
      BEGIN
          for j:=1 to n do
            read(fi,a[i,j]);
      END;
    Close(fi);

END;
{*      *       *       *       *}
Procedure Init;
Var i,j : integer;
BEGIN
    fillchar(d,sizeof(d),0);
    kqi:=0;
    kqj:=n+1;
END;
{*      *       *       *       *}
Procedure Loangsau ( i,j : integer);
Var k,x,t : integer;
BEGIN
    d[i,j]:=dem;
    inc(s[dem]);
    x:=a[i,j];
    for k:=1 to 4 do
      BEGIN
         t:=x-c[k];
         if t>=0 then x:=x-c[k]
           else
             BEGIN
               if d[i+hang[k],j+cot[k]]=0 then
               Loangsau(i+hang[k],j+cot[k]);
             END;
      END;
END;
{*      *       *       *       *}
Procedure Solve;
Var i,j : integer;
BEGIN
    For i:=1 to m do
      For j:=1 to n do
        BEGIN
            if d[i,j]=0 then
              BEGIN
                  Inc(dem);
                  s[dem]:=0;
                  Loangsau(i,j);
              END;
        END;
END;
{*      *       *       *       *}
Procedure Print;
Var i,j,u,v,k : integer;
    ok : boolean;
BEGIN
   maxkq:=0;
   kqi:=0;
   kqj:=n+1;
   for i:=1 to m do
     For j:=1 to n do
       BEGIN
           For k:=3 downto 2 do
             if (d[i,j]<> d[i+hang[k],j+cot[k]]) and (d[i+hang[k],j+cot[k]]<>0) then
               BEGIN
                   maxsum:=s[d[i,j]]+s[d[i+hang[k],j+cot[k]]];
                   if maxsum>maxkq then
                     BEGIN
                       kqi:=i;
                       kqj:=j;
                       dir:=direction[k];
                       maxkq:=maxsum;
                     END
                       else if (maxsum=maxkq) then
                         if (j<kqj) then
                           BEGIN
                               kqi:=i;
                               kqj:=j;
                               dir:=direction[k];
                           END
                            else if (j=kqj) and (i>kqi) then
                              BEGIN
                                  kqj:=j;
                                  kqi:=i;
                                  dir:=direction[k];

                              END;
               END;
       END;

END;
{*      *       *       *       *}
Procedure Output;
Var k,i,j,u,v : integer;
BEGIN
    assign(fo,out);rewrite(fo);
    writeln(fo,dem);
    max:=s[1];
    For k:=2 to dem do
      if max<s[k] then max:=s[k];
    writeln(fo,max);
    Print;
    writeln(fo,maxkq);
    writeln(fo,kqi,' ',kqj,' ',dir);
    close(fo);
END;
{*      *       *       *       *}
BEGIN
    input;
    init;
    Solve;
    output;
END.
