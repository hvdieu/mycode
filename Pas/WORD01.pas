{$H+}
Uses math;
Const 	inp = 'testdata.in';
		out = 'word01.out';
		maxn = 10001;
		oo = 691;

Var		ntest,n,m,i,count,lmax : longint;
		s : ansistring;
		f,trace : array [0..1001] of longint;
        free : array ['a'..'z','a'..'z',1..100] of boolean;
        a : array [1..maxn] of string;
		d : array ['a'..'z'] of longint;
		dd : array ['a'..'z','a'..'z',0..oo] of longint;
		dem : array ['a'..'z'] of integer;

procedure push(tt : longint; s : string); inline;
	var i,j,t,x : longint;
		ch : char;
begin
	t := 0;
	fillchar(dem,sizeof(dem),0);
    if length(s)=1 then
    	begin
    		d[s[1]] := tt;
    		exit;
    	end;
    fillchar(dem,sizeof(dem),0);
    free[s[1],s[length(s)],length(s)] := true;
    for i := 2 to length(s)-1 do inc(dem[s[i]]);
    x := 0;
    for ch := 'a' to 'z' do x := (x*101+dem[ch]+1) mod oo;
    if dd[s[1],s[length(s)],x]=0 then dd[s[1],s[length(s)],x] := tt
     else dd[s[1],s[length(s)],x]:=n+1;
end;

procedure nhap; inline;
	var i,j : longint;
		ss : string;
		begin
			readln(s);
			readln(n);
			fillchar(d,sizeof(d),0);
			fillchar(dd,sizeof(dd),0);
            fillchar(free,sizeof(free),false);
            fillchar(trace,sizeof(trace),0);
			lmax := 0;
			for i := 1 to n do
				begin
					readln(ss);
					lmax := max(lmax,length(ss));
					a[i] := ss;
					push(i,ss);
				end;
		end;

procedure main(); inline;
	var i,j,t,k,x : longint;
		ch : char;
		res : string;
		ok : boolean;
begin
	fillchar(f,sizeof(f),0);
	f[0] := 1;
	for i := 1 to length(s) do
		begin
			if d[s[i]]<>0 then
				begin
					f[i] := f[i-1];
					trace[i] := d[s[i]];
				end;
			fillchar(dem,sizeof(dem),0);
			for j := i-1 downto max(1,i-lmax+1) do
             if free[s[j],s[i],i-j+1] then
				begin
					x := 0;
					for ch := 'a' to 'z' do x := (x*101+dem[ch]+1) mod oo;
					if dd[s[j],s[i],x]<>0 then
						begin
                            if dd[s[j],s[i],x]<=n then
							begin
                              f[i] := f[i]+f[j-1];
							  trace[i] := dd[s[j],s[i],x];
                            end else if f[j-1]>=1 then f[i] := 2;
							if f[i] >= 2 then
								begin
									f[i] := 2;
									break;
								end;
						end;
                    inc(dem[s[j]]);
				end
             else inc(dem[s[j]]);
		end;
	if f[length(s)]=0 then writeln('impossible')
	 else if f[length(s)]>1 then writeln('ambiguous')
	  else
	    begin
	    	res := '';
            i := length(s);
            while i > 0 do
              begin
                  res := ' '+a[trace[i]]+res;
                  i := i - length(a[trace[i]]);
              end;
            delete(res,1,1);
	    	writeln(res);
	    end;
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(ntest);
	while ntest >0 do
	begin
		dec(ntest);
		nhap;
		main;
	end;
end.
