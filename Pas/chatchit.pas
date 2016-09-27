program chatchit;
const
        fi      =       '';
        fo      =       '';
var
        f:text;
        s,kq:ansistring;
        n:longint;
{       -       -       }
procedure nhap;
  begin
    assign(f,fi);
    reset(f);
    read(f,s);
    s:=s+' ';
    n:=length(s);
    close(f);
  end;
{       -       -       }
function doi(s:ansistring):ansistring;
var
        i:longint;
  begin
    i:=1;
    doi:='';
         if s='k' then exit('khong')
    else if s='ko' then exit('khong')
    else if s='ng' then exit('nguoi')
    else if s='n' then exit('nhieu')
    else if s='dc' then exit('duoc')
    else if s='hok' then exit('khong')
    else if s='ntn' then exit('nhu the nao')
    else if s='kq' then exit('ket qua')
    else
      begin
        while i<=length(s) do
          begin
                 if s[i]='j' then doi:=doi+'gi'
            else if s[i]='w' then doi:=doi+'qu'
            else if s[i]='f' then doi:=doi+'ph'
            else if (s[i]='d') and (s[i+1]='z') then
              begin
                doi:=doi+'d';
                inc(i);
              end
            else if s[i]='z' then doi:=doi+'d'
            else doi:=doi+s[i];
            inc(i);
          end;
      end;
  end;
{       -       -       }
procedure xuli;
var
        s1:ansistring;
        i:longint;
  begin
    i:=0;
    kq:='';
    while i<length(s) do
      begin
        s1:='';
        inc(i);
        if (ord(s[i])>=97) and (ord(s[i])<=122) then
          begin
            while (ord(s[i])>=97) and (ord(s[i])<=122)do
              begin
                s1:=s1+s[i];
                inc(i);
              end;
            dec(i);
          end;
        if s1<>'' then kq:=kq+doi(s1)
                  else kq:=kq+s[i];
      end;
  end;
{       -       -       }
procedure xuat;
  begin
    assign(f,fo);
    rewrite(f);
    write(f,copy(kq,1,length(kq)-1));
    close(f);
  end;
{       -       -       }
BEGIN
  nhap;
  xuli;
  xuat;
END.


