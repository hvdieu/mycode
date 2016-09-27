Const    inp = '';
         out = '';
         maxn = 61;
Var      fi,fo  :       text;
         a,b,t,res,kq,sub,sub1    :       string;
         m,n,i,k        :       integer;
         x              :       array [1..maxn] of char;
         dem,d    :       array ['0'..'9'] of integer;
         ok1,ok2,ok : boolean;
         j,ch      :       char;

BEGIN
       Assign(fi,inp); reset(fi);
       Assign(fo,out); rewrite(fo);
       readln(fi,a);
       readln(fi,b);
       close(fi);
       n := length(b);
       for i := 1 to n do inc(dem[b[i]]);
       x[1] := '0';
       ok1 := false;
       for i := 1 to n do
          BEGIN
               if ok1 = false then
               BEGIN
                for j := a[i] to '9' do
                   BEGIN
                        if dem[j] > 0 then
                            BEGIN
                                 ok2 := false;
                                 dec(dem[j]);
                                 if j > a[i] then
                                  BEGIN
                                       x[i] := j;
                                       ok1 := true;
                                       break;
                                  END
                                  else
                                 BEGIN
                                 sub := '';
                                 for k := i+1 to n do
                                          sub := sub + a[k];
                                 sub1 := '';
                                 for ch := '9' downto '0' do
                                   if dem[ch] > 0 then
                                     BEGIN
                                          for k := 1 to dem[ch] do sub1 := sub1 + ch;
                                     END;
                                 if sub < sub1 then ok2 := true;
                                 if ok2 then
                                   BEGIN
                                        x[i] := j;
                                        if x[i] > a[i] then ok1 := true;
                                        break
                                   END
                                     else inc(dem[j]);
                                 END;
                            END;
                   END;
               END
                  else
                     BEGIN
                          for j := '0' to '9' do
                            if dem[j] > 0 then
                               BEGIN
                                    x[i] := j;
                                    dec(dem[j]);
                                    break;
                               END;
                     END;
          END;
       if x[1] = '0' then write(fo,0)
       else
       for i := 1 to n do write(fo,x[i]);
       writeln(fo);
       fillchar(dem,sizeof(dem),0);
       for i := 1 to n do inc(dem[b[i]]);
       ok1 := false;
       for i := 1 to n do
          BEGIN
                if ok1= false then
                    BEGIN
                          for j := a[i] downto '0' do
                             BEGIN
                                   if dem[j] > 0 then
                                      BEGIN
                                           ok2 := false;
                                           dec(dem[j]);
                                           if j < a[i] then
                                             BEGIN
                                                 x[i] := j;
                                                 ok1 := true;
                                                 break;
                                             END
                                             else begin
                                           sub := '';
                                           for k := i+1 to n do sub := sub + a[k];
                                           sub1 := '';
                                           for ch := '0' to '9' do
                                             if dem[ch] > 0 then
                                               for k := 1 to dem[ch] do sub1 := sub1 + ch;
                                           if sub1 < sub then ok2 := true;
                                           if ok2 then
                                              BEGIN
                                                x[i] := j;
                                                if x[i] < a[i] then ok1 := true;
                                                break;
                                              END
                                                else inc(dem[j]);
                                              end;

                                      END;
                             END;
                    END
                       else
                          BEGIN
                                for j := '9' downto '0' do
                                   BEGIN
                                         if dem[j] > 0 then
                                            BEGIN
                                                x[i] := j;
                                                dec(dem[j]);
                                                break;
                                            END;
                                   END;
                          END;
          END;

       if x[1] = '0' then write(fo,0)
       else
       for i := 1 to n do write(fo,x[i]);
       close(fo);
END.

