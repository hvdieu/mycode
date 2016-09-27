var
  a: array[1..500000] of longint;
  c: array[1..5] of shortint = (1, 3, 5, 7, 9);
  x: array[1..8] of byte;
  i, k, d, d1, d2, j, n: longint;
  s: string;
function find(x, m: longint): longint;
  var mid, l, r: longint;
  begin
    if x <= a[1] then exit(1);
    if x > a[m] then exit(m+1);
    l := 1; r := m;
    repeat
      mid := (l+r) div 2;
      if x <= a[mid] then r := mid else l := mid;
    until l+1 = r;
    exit(r);
  end;
 
procedure num(i: byte);
  var
    j: byte;
    t, tmps: longint;
  begin
    if i = k+1 then
      begin
        t := 1; tmps := 0;
        for j := k downto 1 do
          begin
            inc(tmps, x[j]*t);
            t := t*10;
          end;
        inc(d);
        a[d] := tmps;
        exit;
      end;
    for j := 1 to 5 do
      begin
        x[i] := c[j];
        num(i+1);
      end;
  end;
begin
  assign(input, ''); reset(input);
  assign(output, ''); rewrite(output);
  d := 0;
  for k := 1 to 8 do num(1);
  repeat
    readln(s);
    if s = '[END]' then break;
    readln(n);
    if n > 3 then
      begin
        d1 := find(n, d)-1;
        d2 := find(n-a[d1], d1);
        if a[d1]+a[d2] = n then writeln(n)
        else
          begin
            j := d1-1;
            while a[j] + a[d2] > n do dec(j);
            writeln(a[j+1]+a[d2]);
          end;
      end
    else
      if n mod 2 = 0 then writeln(n)
      else writeln(n+1);
    readln;
  until false;
  close(input); close(output);
end.