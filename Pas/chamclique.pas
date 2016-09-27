const           id                      ='clique';
                fi                      ='compar$r.inp';
                fo                      ='compar$r.out';

var             path                    :string;
                f,g                     :text;
                a                       :array[1..3000,1..3000]of longint;
                iTest,nTest             :longint;
                err                     :string;

procedure cham;
var c,i,j,n,m,k,dem :longint;
    d,clique    :array[1..3000]of longint;
begin
   fillchar(a,sizeof(a),0);
   readln(f,n,m,k);
   for c:=1 to m do begin
      readln(f,i,j);
      a[i,j]:=1; a[j,i]:=1;
   end;

   dem:=0;
   fillchar(d,sizeof(d),0);

   while not seekeoln(g) do begin
      read(g,c);
      inc(dem);

      if (c=-1)and(dem=1) then begin
        err:='thong bao vo nghiem la sai';
        exit;
      end;

      if (c<=0)or(c>n) then begin
        err:='ten dinh sai';
        exit;
      end;

      if d[c]=1 then begin
        err:='dinh lap lai';
        exit;
      end;

      d[c]:=1;
      clique[dem]:=c;
   end;
   readln(g);

   if dem<>k then
      begin
        err:='sai quy cach';
        exit;
      end;

   for i:=1 to k do
     for j:=1 to k do
        if (i<>j) and (a[clique[i],clique[j]]=0) then
      begin
        err:='clique khong dung';
        exit;
      end;
end;

BEGIN

   // doc lay duong dan
     assign(f,fi); reset(f);
     read(f,path);
     close(f);


   //doc lay dap an
   //file input va output nam trong duong dan path
   assign(f,path+id+'.inp'); reset(f);
   assign(g,id+'.out'); reset(g);
   readln(f,nTest);

   err:='DUNG';
   for iTest:=1 to nTest do begin
      cham;
      if err<>'DUNG' then break;
   end;

   close(f);
   close(g);

   //ghi ket qua
   writeln(err);

   assign(f,fo); rewrite(f);
   if err='DUNG' then writeln(f,'DUNG')
   else begin writeln(f,'SAI'); writeln(f,err); end;
   close(f);
END.
