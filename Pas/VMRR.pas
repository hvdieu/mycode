Const   inp = '';
        out = '';
        maxn = 1000001;
Var     fi,fo : text;
        s,st       :       ansistring;
        x,y     :       char;
        a       :       array [1..maxn + 1 ] of longint;
        n,dem      :       longint;
        res     :   longint;
{*      *       *       *       *}
Procedure Solve;
Var i         :       longint;
BEGIN
     n := length(s);
     fillchar(a,sizeof(a),0);
     For i:=n downto 1 do
        if s[i] = y then inc(dem);
     For i:=1 to n do
       if s[i] = x then res := res + a[i+1];
END;
{*      *       *       *       *}
BEGIN
        Assign(fi,inp);reset(fi);
        readln(fi,s);
        readln(fi,x,y);
        close(fi);
        n := length(s);
        Solve;
        Assign(fo,out);rewrite(fo);
        write(fo,res);
        close(fo);
END.
