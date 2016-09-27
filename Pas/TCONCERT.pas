{$INLINE OFF}
Uses math;
Const
	inp = 'TCONCERT.INP';
	out = 'TCONCERT.OUT';
	maxn = 	400001;
	maxm = 1000001;
	oo = 1000000000;

Type	arr = array [0..4] of longint;
        arr1 = array [0..4] of int64;

Var
	n,m,mm : longint;
	a,c,id : array [1..maxn*2] of longint;
	head : array [1..maxm] of longint;
	ke,next : array [1..2*maxn] of longint;
	res : arr;
    num,s2,x : arr;
    s1 : qword;

procedure noi(u,v : longint); inline;
begin
	inc(mm);
	ke[mm] := v; next[mm] := head[u]; head[u] := mm;
end;

procedure nhap; inline;
	var i,j : longint;
begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(m,n);
	for i := 1 to n do
    begin
      read(a[i],a[i+n],c[i]); inc(a[i+n]);
	  id[i] := i; id[i+n] := i+n;
	  noi(a[i],i); noi(a[i+n],i+n);
    end;
end;

procedure cong(var a,b : arr); inline;
var
    i,j,x,l : longint;
    nho : longint;
        begin
            l := max(a[0],b[0]);
            nho := 0;
            for i := 1 to l do
              begin
                  if a[0] >= i then inc(nho,a[i]);
                  if b[0] >= i then inc(nho,b[i]);
                  a[i] := nho mod oo;
                  nho := nho div oo;
              end;
            a[0] := l;
            if nho <> 0 then
              begin
                  inc(a[0]); a[a[0]] := nho;
              end;
        end;

procedure tru(var a,b : arr);
var
    nho,x : int64;
    i : longint;
        begin
            nho := 0;
            for i := 1 to a[0] do
              begin
                 a[i] := a[i]-b[i]-nho;
                 if a[i] >= 0 then nho := 0
                 else
                   begin
                       nho := 1;
                       a[i] := a[i]+oo;
                   end;
              end;
            while (a[0] > 1) and (a[a[0]]=0) do dec(a[0]);
        end;
{***************************************************************************}
function nhan(a,b : arr) : arr; inline;
var c : arr1;
    i,j : longint;
    x,nho : int64;
        begin
             fillchar(c,sizeof(c),0);
             fillchar(nhan,sizeof(nhan),0);
             c[0] := a[0]+b[0]-1;
             for i := 1 to a[0] do
              for j := 1 to b[0] do
               c[i+j-1] := c[i+j-1] + int64(a[i])*b[j];
             nho := 0;
             for i := 1 to c[0] do
               begin
                   x := c[i] + nho;
                   nho := x div oo;
                   c[i] := x mod oo;
                   nhan[i] := c[i];
               end;
             nhan[0] := c[0];
             if nho <> 0 then
               begin
                   inc(nhan[0]);
                   nhan[nhan[0]] := nho;
               end;
        end;

procedure ghi(a : arr); inline;
var i : longint;
    s : string;
        begin
            write(a[a[0]]);
            for i := a[0]-1 downto 1 do
              begin
                  str(a[i],s);
                  while length(s) < 9 do s := '0'+s;
                  write(s);
              end;
            writeln;
        end;

function convert(a : qword) : arr; inline;
	var b : arr;
begin
    fillchar(convert,sizeof(convert),0);
	if a=0 then
		begin
			convert[0] := 1; convert[1] := 0;
            exit;
		end;
	convert[0] := 0;
	while a<>0 do
		begin
			inc(convert[0]);
			convert[convert[0]] := a mod oo;
			a := a div oo;
		end;
end;

procedure main();
	var i,j,ii : longint;
begin
    res[0] := 1; res[1] := 0;
    s1 := 0; s2[0] := 1; s2[1] := 0;
    i := 0;
	for ii := 1 to m+1 do
		begin
			j := head[ii];
			while j<>0 do
				begin
					inc(i); id[i] := ke[j]; a[i] := ii;
					if (i>1) and (a[i]<>a[i-1]) then begin
            			x := convert(a[i]-a[i-1]);
						num := nhan(s2,x);
		    			cong(res,num);
		    		end;
					if id[i]<=n then
						begin
                    		x := convert(s1*c[id[i]]);
							cong(s2,x);
							s1 := s1+c[id[i]];
						end
					else begin
						s1 := s1-c[id[i]-n];
                		x := convert(s1*c[id[i]-n]);
						tru(s2,x);
					end;
					j := next[j];
          		end;
		end;
    ghi(res);
end;

begin
	nhap;
	main;
end.
