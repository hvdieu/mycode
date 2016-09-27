const           id                      ='bd';
                fi                      ='compar$r.inp';
                fo                      ='compar$r.out';

var             path                    :string;
                f                       :text;
                a                       :array[1..3,1..20]of longint;
                err                     :string;
                i,j,sobuoc,n            :longint;

procedure cham;
var k,x1,y1,x2,y2,tmp :longint;
begin
   //doc lay ket qua hoc sinh
   assign(f,id+'.out'); reset(f);
   readln(f,sobuoc);
   for k:=1 to sobuoc do begin
      readln(f,x1,y1,x2,y2);

      if (x1>0)and(y1>0) and (x1<=3) and (y1<=n) = false then
        begin
          err:='toa do thu nhat sai';
          break;
        end;

      if (x2>0)and(y2>0) and (x2<=3) and (y2<=n) = false then
        begin
          err:='toa do thu hai sai';
          break;
        end;

      if abs(x1-x2)+abs(y1-y2)<> 1 then
        begin
          err:='hai o khong ke nhau';
          break;
        end;

      if (a[x1,y1] <> 1) and (a[x2,y2] <> 1) then
        begin
          err:='hai o deu khac 1';
          break;
        end;

      tmp:=a[x1,y1];
      a[x1,y1]:=a[x2,y2];
      a[x2,y2]:=tmp;
   end;

   close(f);

   if err = 'DUNG' then begin
       k:=0;
       for i:=1 to 3 do
         for j:=1 to n do begin
           inc(k);
           if k <> a[i,j] then begin
              err:='chua bien doi dung';
              exit;
           end;
         end;
   end;

end;

BEGIN
   // doc lay duong dan
     {
   assign(f,fi); reset(f);
   read(f,path);
   close(f);      }


   //doc lay dap an
   //file input va output nam trong duong dan path
   assign(f,path+id+'.inp'); reset(f);
   readln(f,n);
   for i:=1 to 3 do
     for j:=1 to n do read(f,a[i,j]);
   close(f);

   err:='DUNG';
   cham;

   //ghi ket qua

   writeln(err);

   assign(f,fo); rewrite(f);
   if err='DUNG' then writeln(f,'DUNG')
   else begin writeln(f,'SAI'); writeln(f,err); end;

   close(f);
END.
