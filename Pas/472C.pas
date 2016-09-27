uses math;
Const
    inp = 'ad.inp';
    out = 'asd.out';
    maxn = 100001;

Var
    a,b,c : array [1..maxn] of string;
    n,i,j : longint;
    p,pos : array [1..maxn] of longint;
    s1,s2,m1 : string;
    ch : char;

procedure swap(var x,y : string);
    var temp : string;
begin
    temp := x; x := y; y := temp;
end;

function cmp(s1,s2 : string) : boolean;
    var i : longint;
begin
    for i := 1 to min(length(s1),length(s2)) do
     if s1[i] > s2[i] then exit(true)
      else if s1[i]<s2[i] then exit(false);
    if length(s1) > length(s2) then exit(true)
     else exit(false);
end;

procedure main;
    var i,j : longint;
        a1,a2 : string;
begin
    for i := 1 to n do pos[p[i]] := i;
    m1 := '0';
    for i := 1 to n do
      begin
           j := p[i];
           if (cmp(a[j],m1)=false) and (cmp(b[j],m1)=false) then
            begin
                writeln('NO');
                halt;
            end;
           if cmp(a[j],m1) then m1 := a[j] else m1 := b[j];
      end;
    writeln('YES');
end;

begin
  //  assign(input,inp); reset(input);
  //  assign(output,out); rewrite(output);
    readln(n);
    for i := 1 to n do
      begin
          s1 := ''; s2 := '';
          read(ch);
          while ch<>' ' do
            begin
                s1 := s1+ch;
                read(ch);
            end;
          readln(s2);
          a[i] := s1; b[i] := s2;
          if a[i] > b[i] then swap(a[i],b[i]);
      end;
    for i := 1 to n do read(p[i]);
    main;
end.