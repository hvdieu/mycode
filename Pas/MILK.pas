Program Milk;
const   inp = 'MILK.INP';
        out = 'MILK.OUT';
Var     fi,fo :      text;
        t       :    array [1..3] of integer;
        a,b,c   :    integer;
        d       :    array [0..20,0..20,0..20] of boolean;
        l       :    array [0..20] of boolean;
{*      *       *    *  *       *}
Procedure Input;
BEGIN
    assign(fi,inp);reset(fi);
    readln(fi,t[1],t[2],t[3]);
    close(fi);
    fillchar(l,sizeof(l),true);
    fillchar(d,sizeof(d),true);
END;
{*      *       *       *       *}
Procedure Try(a,b,c : integer);
BEGIN
    d[a,b,c]:=false;
    if a=0 then l[c]:=false;
    if (a+b>=t[2]) and (d[a+b-t[2],t[2],c]) then try(a+b-t[2],t[2],c)
      else if (a+b<t[2]) and d[0,a+b,c] then try(0,a+b,c);
    if (a+c>=t[3]) and d[a+c-t[3],b,t[3]] then try(a+c-t[3],b,t[3])
      else if (a+c<t[3]) and d[0,b,a+c] then try(0,b,a+c);
    if (b+a>=t[1]) and d[t[1],a+b-t[1],c] then try(t[1],a+b-t[1],c)
      else if (b+a<t[1]) and d[a+b,0,c] then try(a+b,0,c);
    if (b+c>=t[3]) and d[a,b+c-t[3],t[3]] then try(a,b+c-t[3],t[3])
      else if (b+c<t[3]) and d[a,0,b+c] then try(a,0,b+c);
    if (c+a>=t[1]) and d[t[1],b,c+a-t[1]] then try(t[1],b,c+a-t[1])
      else if (c+a<t[1]) and d[c+a,b,0] then try(c+a,b,0);
    if (c+b>=t[2]) and d[a,t[2],b+c-t[2]] then try(a,t[2],b+c-t[2])
      else if (c+b<t[2]) and d[a,c+b,0] then try(a,c+b,0);
END;
{*      *       *       *       *}
Procedure Output;
Var i : integer;
BEGIN
   assign(fo,out);rewrite(fo);
    For i:=0 to t[3] do
      if not l[i] then Write(fo,i,' ');
    close(fo);
END;
{*      *       *       *       *}
BEGIN
      input;
      try(0,0,t[3]);
      output;
END.