{$h+}
CONST
        tfi     ='palin.inp';
        tfo     ='palin.ou1';
VAR
        fi,fo   :text;
        s       :string;
        n,t     :longint;
 (*********************************************************************)
Function cong(a,b:string):string;
      Var
        x,y,i,tg,nho:longint;
        c       :string;
      Begin
        while length(a)<length(b) do a:='0'+a;
        while length(b)<length(a) do b:='0'+b;
        nho:=0;c:='';
        for i:=length(a) downto 1 do
          begin
            x:=ord(a[i])-48;
            y:=ord(b[i])-48;
            tg:=x+y+nho;
            nho:=tg div 10;
            c:=chr(tg mod 10+48)+c;
          end;
        if nho<>0 then c:='1'+c;
        exit(c);
      End;
 (***********************************************************************)
Procedure lam;
      Var
        i,j     :longint;
      Begin
        if (length(s)=1) then
          begin
            if s<>'9' then writeln(fo,chr(ord(s[1])+1))
            else writeln(fo,11);
            exit;
          end;
        j:=(n div 2)+1;
        for i:=(n+1) div 2 downto 1 do
          begin
            if s[i]>s[j] then
              begin
                for j:=1 to (n+1) div 2 do write(fo,s[j]);
                for j:=n div 2 downto 1 do write(fo,s[j]);
                writeln(fo);
                exit;
              end
            else if s[i]<s[j] then break;
            inc(j);
          end;
        j:=0;
        for i:=(n+1) div 2 downto 1 do
          if s[i]<>'9' then
            begin
              j:=i;
              break;
            end;
        if j=0 then
          begin
            write(fo,1);
            for i:=2 to n do write(fo,0);
            writeln(fo,1);
            exit;
          end;
        for i:=1 to j-1 do write(fo,s[i]);
        write(fo,chr(ord(s[j])+1));
        for i:=j+1 to (n+1) div 2 do write(fo,0);
        if n mod 2=1 then
          begin
            for i:=(n+1) div 2-1 downto j+1 do write(fo,0);
            if j<=(n+1) div 2-1 then write(fo,chr(ord(s[j])+1));
            for i:=j-1 downto 1 do write(fo,s[i]);
          end
        else
          begin
            for i:=(n+1) div 2 downto j+1 do write(fo,0);
            write(fo,chr(ord(s[j])+1));
            for i:=j-1 downto 1 do write(fo,s[i]);
          end;
        writeln(fo);
      End;
 (*********************************************************************)
BEGIN
      assign(fi,tfi);reset(fi);
      assign(fo,tfo);rewrite(fo);
        readln(fi,t);
        while t<>0 do
          begin
            readln(fi,s);
            n:=length(s);
            lam;
            dec(t);
          end;
      close(fi);
      close(fo);
END.
