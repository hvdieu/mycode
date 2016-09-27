CONST
  tfi    =      'demtu.inp';
  tfo    =      'demtu.out';
VAR
  st            :       string;
  i             :       longint;
  fi,fo         :        text;
procedure  nhap;
    begin
    assign(fi,tfi); reset(fi);
      read(fi,st);
    close(fi);
    end;
procedure xoadau;
  begin
     while st[1]=' ' do delete(st,1,1);
  end;
procedure xoacuoi;
  begin
     while st[length(st)]=' ' do delete(st,length(st),1);
  end;
procedure xoagiua;
   begin
     for i:=length(st) downto 1 do
     begin
        if (st[i-1]=' ') and (st[i]=' ') then
        begin
          delete(st,i,1);
        end;
     end;
   end;
procedure inkq;
begin
    assign(fo,tfo);rewrite(fo);
     writeln(fo,st);
    close(fo);
end;
 begin
     nhap;
    xoadau;
    xoacuoi;
    xoagiua;
  end.
