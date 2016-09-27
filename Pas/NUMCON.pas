Const   inp = '';
        out = '';
Var     fi,fo   :       text;
        giua       :       array [1..101] of string;
        n       :       integer;
        res     :       ansistring;
        s       :       string;
{*      *       *       *       *}
Procedure input;
Var i : integer;
BEGIN
     i:=0;
     assign(fi,inp);reset(fi);
     While not eof(fi) do
       BEGIN
           inc(i);
           readln(fi,s);
           giua[i]:=s;
       END;
     Close(fi);
     n:=i;
END;
{*      *       *       *       *}
Function lon(xx,yy : string) : string;
Var aa,bb : string;
BEGIN
   aa:=xx+yy;
   bb:=yy+xx;
   if aa = bb then lon := '*';
   if aa > bb then lon := xx;
   if aa < bb then lon := yy;
END;
{*      *       *       *       *}
Procedure Swap( Var xx,yy : string);
Var temp : string;
BEGIN
    temp:=xx;
    xx:=yy;
    yy:=temp;
END;
{*      *       *       *       *}
procedure Quicksort(L,H : integer);
Var i,j : integer;
    key : string;
BEGIN
    if l>=h then exit;
    i:=l;
    j:=h;
    key := giua [ (l+h) div 2] ;
    Repeat
       BEGIN
           While lon(giua[i],key) = giua[i] do inc(i);
           While lon(giua[j],key) = key do dec(j);
           if i<=j then
             BEGIN
                 if i<j then Swap(giua[i],giua[j]);
                 Inc(i);
                 Dec(j);
             END;
       END;
          Until i>j;
    Quicksort(l,j);
    Quicksort(i,h);

END;
{*      *       *       *       *}
Procedure output;
Var i : integer;
BEGIN
    Quicksort(1,n);
    For i:=1 to n do
     res:=res + giua[i];
    Assign(fo,out);rewrite(fo);
    write(fo,res);
    close(fo);
END;
{*      *       *       *       *}
begin
    input;
    output;
end.