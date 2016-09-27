Program Note;
Const    inp = '';
         out = '';
         maxf   =       35;
Var      fi,fo  :       text;
         p,f    :       int64;
         s,s1,s2      :       ansistring;
{*      *       *       *       *}
Procedure Xuly;
Var i,j,k : longint;
BEGIN
  s:='D';
  For i:=2 to f do
    BEGIN
        s1:=s;
        s2:='';
        For j:=1 to length(s1) do
           BEGIN
               if s1[j]='U' then s1[j]:='D'
                 else s1[j]:='U';

           END;
        For j:=length(s1) downto 1 do
          s2:=s2+s1[j];
        s:=s2+'D'+s;
    END;
END;
{*       *      *       *       *}
Procedure Output;
BEGIN
   Writeln(fo,s[p]);
END;
{*      *       *       *       *}
Procedure Input;
Var i,j : int64;
BEGIN
    Assign(fi,inp);reset(fi);
    ASsign(fo,out);rewrite(fo);
    While not eof(fi) do
      BEGIN
          readln(fi,f,p);
          If (p<>0) and (f<>0) then
            BEGIN
               Xuly;
               Output;
            END;
      END;
    Close(fi);
    Close(fo);
END;
{*      *       *       *       *}
BEGIN
   input;
END.
