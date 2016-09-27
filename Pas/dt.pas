CONST
  tfi    =      'demtu1.inp';
  tfo    =      'demtu1.out';
VAR
  st,st1        :       string;
  i,x,dem,k     :       longint;
  fi,fo         :        text;
begin
    ASSIGN(fi,tfi);reset(fi);
     read(fi,st);
    close(fi);
    st1:=' ';
    for i:=1 to x do
      begin
       x:=pos(st1,st);
       delete(st,x,1);
      end;
    k:=length(st);
    assign(fo,tfo);rewrite(fo);
     write(fo,k);
    close(fo);
end.