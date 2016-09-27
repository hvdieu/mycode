{$H+}
Uses math;
Const
	inp = 'piramida.inp';
	out = 'piramida.out';
	maxn = 1000001;

Var
	s : string;
	m,q,i : longint;
	n,x : int64;
	d : array ['A'..'Z'] of longint;
    line : array [1..50000] of int64;
    kt : array [1..50000] of char;
    tt : array [1..50000] of longint;
	ch,sp : char;
    t : int64;

function query(x : int64; ch : char) : int64;
	var t,sl,res : int64;
begin
	t := (((x mod m) * ((x-1) mod m)) div 2) mod m;
	t := min(m-t,x);
	sl := (x-t) div m;
	res := 0;
	res := res + sl*d[m][ch];
	res := res + d[t][ch];
	t := x - t - sl*m;
	res := res + d[m][ch] - d[m-t][ch];
	exit(Res);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n);
	readln(s);
	m := length(s);
	for i := 1 to m do
	  begin
	  	for ch := 'A' to 'Z' do d[i][ch] := d[i-1][ch];
	  	inc(d[i][s[i]]);
	  end;	
	readln(q);
    for i := 1 to q do
      begin
          readln(line[i],sp,kt[i]);
          t := (((x mod m) * ((x-1) mod m)) div 2) mod m;
	      t := min(m-t,x);
      end;
end.
