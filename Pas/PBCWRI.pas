Const   inp = '';
        out = '';
Var     fi,fo        :          text;
        da,db            :          array ['A'..'z'] of longint;
        a,b              :          ansistring;
        n,m,dem          :          longint;
{*      *       *    *          *}
procedure input;
BEGIN
   assign(fi,inp);reset(fi);
   readln(fi,n,m);
   readln(fi,a);
   readln(fi,b);
   close(fi);
   fillchar(da,sizeof(da),0);
   fillchar(db,sizeof(db),0);
   dem:=0;
END;
{*      *       *       *       *}
Function kt : boolean;
Var k : char;
    ok  : boolean;
BEGIN
    ok:=true;
    for k:='A' to 'z' do
     if da[k]<> db[k] then
       BEGIN
         ok:=false;
         break;
       END;
    kt:=ok;
END;
{*      *       *       *       *}
Procedure Xuly;
Var i,j,k : longint;
BEGIN
    For i:=1 to n do inc(da[a[i]]);
    For i:=1 to m-n+1 do
      BEGIN
          fillchar(db,sizeof(db),0);
          For j:=i to i+n-1 do
            Inc(db[ b[j] ]);
          if kt then inc(dem);
      END;

END;
{*      *       *       *       *}
procedure output;
BEGIN
    assign(fo,out);rewrite(fo);
    write(fo,dem);
    close(fo);
END;
{*      *       *       *       *}
BEGIN
      input;
      xuly;
      output;
END.