uses math;
const
	inp = 'vmsubstr.inp';
	out = 'vmsubstr.out';

var
	n,q,i,s1,s2 : longint;
	s,a : string;
	d : array [0..52,0..52] of longint;
	dd : array [0..52] of boolean;

procedure main;
	var i,j,c1,c2,res : longint;
begin
	for i := 2 to n do
	  begin
	  	c1 := ord(s[i])-ord('A'); c2 := ord(s[i-1])-ord('A');
	  	if c1 > 25 then c1 := ord(s[i])-ord('a')+26;
	  	if c2 > 25 then c2 := ord(s[i-1])-ord('a')+26;
	  	inc(d[c2][c1]);
	  end;
	readln(q);
    s1 := ord(s[1])-ord('A');
    if s1 > 25 then s1 := ord(s[1])-ord('a')+26;
    s2 := ord(s[2])-ord('A');
    if s2 > 25 then s2 := ord(s[2])-ord('a')+26;
	while q > 0 do
	  begin
	  	dec(q);
	  	fillchar(dd,sizeof(dd),false);
	  	readln(a); res := 0;
	  	for i := 1 to length(a) do
	  	  begin
	  	  	c1 := ord(a[i])-ord('A');
	  	  	if (c1 > 25) then c1 := ord(a[i])-ord('a')+26;
	  	  	dd[c1] := true;
	  	  end;
	  	for c1 := 0 to 51 do
	  	 for c2 := 0 to 51 do
	  	  if (dd[c2] = false) and (dd[c1] = true) then inc(res,d[c1][c2]);
	  	if (dd[s1] = true)then inc(res);
	  	writeln(res);
 	  end;
end;

begin
  //assign(input,inp); reset(input);
  //assign(output,out); rewrite(output);
	readln(n);
	readln(s);
	main;
end.
