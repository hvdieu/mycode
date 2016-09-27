procedure doicho(i,j : longint);
        begin
            writeln(2,' ',i);
            writeln(3,' ',j);
            writeln(4,' ',i);
        end;

begin
      assign(output,'PSGAME.OUT'); rewrite(output);
      writeln(45);
      doicho(5,6); doicho(4,5); doicho(3,4); doicho(2,3); doicho(1,2);
      doicho(2,3); doicho(3,4); doicho(4,5); doicho(5,6);
      doicho(2,3); doicho(3,4); doicho(4,5);
      doicho(3,4); doicho(2,3);
      doicho(3,4);
end.