const
    tfi   =    'xau.inp';
    tfo   =    'xau.out';
var
    s:string;
    dem,i:longint;
    fi,fo:text;
begin
    assign(fi,tfi);reset(fi);
    read(fi,s);
    close(fi);
    s:=s+' ';
    dem:=0;
    for i:=1 to length(s)-1 do
      if (s[i]<>' ') and (s[i+1] = ' ') then dem:=dem+1;
    assign(fo,tfo);rewrite(fo);
    write(fo,dem);
    close(fo);
end.