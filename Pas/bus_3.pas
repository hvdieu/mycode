program bai1;
uses crt;
const
         tfi    =       'bus.inp';
         tfo    =       'bus.out';
var
         fi,fo  :       text;
         i,j,n,d,k,sh :       longint;
         s,t      :        array[0..10000] of longint;
BEGIN
   assign(fi,tfi);reset(fi);
     read(fi,n,d,t[0]);
       for i:=1 to n do   read(fi,s[i]);
     close(fi);
        for i:=1 to n do
             t[j]:=t[0]+j*d;

            assign(fo,tfo);rewrite(fo);
                 for i:=1 to n do
                  for j:=0 to n do
                    if s[i]<=t[j] then
                      begin
                          sh:=j;
                          inc(sh);

                           break;
                      end;
                   write(fo,sh,' ');
               close(fo);

END.