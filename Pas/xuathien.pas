var n,m,s,i,cs : integer;
    sl : array [0..9] of integer;
    fi,fo : text;

begin
    assign(fi,'xuathien.inp'); reset(fi);
    assign(fo,'xuathien.out'); rewrite(fo);
    readln(fi,m,n);
    s := m+n;
    while s > 0 do
      begin
          cs := s mod 10;
          sl[cs] := sl[cs]+1;
          s := s div 10;
      end;
    for i := 0 to 9 do
      if sl[i] <> 0 then
        begin
            writeln(fo,'SO LAN XUAT HIEN CHU SO ',i,': ',sl[i]);
        end;
    close(fi); close(fo);
end.