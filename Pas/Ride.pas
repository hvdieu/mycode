{
PROG: ride
LANG: PASCAL
ID: pynhp9x1
}
Const   inp     =     'ride.in';
        out     =     'ride.out';
Var     fi,fo   :     text;
        a       :     array ['A'..'Z'] of integer;
        s1,s2   :     string;
        i       :     char;
        j       :     integer;
        max1,max2     : longint;
{*      *       *     * *}
BEGIN
    assign(fi,inp);reset(fi);
    readln(fi,s1);
    readln(fi,s2);
    close(fi);
    j:=0;
    For i:='A' to 'Z' do
      BEGIN
          Inc(j);
          a[i]:=j;
      END;
      max1:=1;
      max2:=1;
    For j:=1 to length(s1) do
      BEGIN
          max1:=max1* a[ s1[j] ];
      END;
    For j:=1 to length(s2) do
      BEGIN
           max2:=max2* a[ s2[j] ];
      END;
    assign(fo,out);rewrite(fo);
    if max1 mod 47 = max2 mod 47 then writeln(fo,'GO')
     else writeln(fo,'STAY');
     close(fo);
END.
