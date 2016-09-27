(*
ID: bit_ske1
LANG: PASCAL
PROB: castle
*)

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
        dem,max,maxsum,kqi,kqj,maxkq     :       integer;
        s,cs       :       array [1..maxs] of integer;
        dir     :  char;
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
Procedure Swap( Var x,y : integer);
Var temp : integer;
BEGIN
    temp:=x;
    x:=y;
    y:=temp;
END;
{*      *       *       *       *}
Procedure Quicksort(L,H : integer);
Var i,j,key : integer;
BEGIN
    if l>=h then exit;
    i:=l;
    j:=h;
    key := s[ (l+h) div 2 ];
    Repeat
      BEGIN
          While s[i]>key do Inc(i);
          While s[j]<key do Dec(j);
          If i<=j then
            BEGIN
                if i<j then
                  BEGIN
                    Swap(s[i],s[j]);
                    Swap(cs[i],cs[j]);
                  END;
                Inc(i);
                Dec(j);
            END;
      END;
         Until i>j;
      Quicksort(L,j);
      Quicksort(i,H);
END;
{*      *       *       *       *}
Procedure Print;
Var i,j,u,v,k : integer;
    ok : boolean;
BEGIN
   ok:=false;
   For k:=1 to dem do
     cs[k]:=k;
    Quicksort(1,dem);
    i:=1;j:=2;
    While (i<=dem-1) and (j<=dem) do
      BEGIN
           For u:=1 to m do
             For v:=1 to n do
                BEGIN
                 if d[u,v]=cs[i] then
                    For k:=3 downto 2 do
                      if (d[u+hang[k],v+cot[k]]=cs[j]) then
                        BEGIN
                            maxsum:=s[i]+s[j];
                            if maxsum>maxkq then maxkq:=maxsum;
                            if v<=kqj then
                              BEGIN
                                  kqi:=u;
                                  kqj:=v;
                                  dir:=direction[k];
                                  ok:=true;
                              END;
                        END;
                      if d[u,v]=cs[j] then
                        for k:=3 downto 2 do
                          if d[u+hang[k],v+cot[k]]=cs[i] then
                             BEGIN
                                 maxsum:=s[i]+s[j];       if maxsum>maxkq then maxkq:=maxsum;
                                 if (v<=kqj) then
                                    BEGIN
                                        kqi:=u;
                                        kqj:=v;
                                        dir:=direction[k];
                                        ok:=true;
                                    END;
                             END;
                END;
             if s[i]+s[j+1]>s[i+1]+s[i+2] then inc(j)
               else BEGIN
                        Inc(i);
                        j:=i+1;
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
