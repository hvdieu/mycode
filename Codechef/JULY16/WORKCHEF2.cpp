#include<bits/stdc++.h>
using namespace std;
long long l,r;
int k;
long long dp[512][2520][19][2];
long long modul[20];
vector<int> digits;
long long ans=0;
int cnt;
long long calc(int mask,int modus,int digsleft,int isequal)
{
    cnt++;
	int temp=0;
	long long ans=0;
	if(digsleft>=0)
	{
	    if(dp[mask][modus][digsleft][isequal]!=(-1))
	    {
		    return dp[mask][modus][digsleft][isequal];
	    }
	}
	if(digsleft==-1)
	{
    	if(mask!=0)
    	{
    		for(int i=1;i<=9;i++)
    		{
    			if(((1<<(i-1))&mask)&&(modus%i)==0)
    			{
    				temp++;
    			}
    		}
    		if(temp>=k)
    		{
    			return 1;
    		}
    		else
    		{
    		    return 0;
    		}
    	}
    	else
    	{
    	    return 0;
    	}
	}
	if(isequal)
	{
		if(digits[digsleft]==0)
		{
			ans+=calc(mask,modus,digsleft-1,1);
		}
		else
		{
		    ans+=calc(mask,modus,digsleft-1,0);
			for(int i=1;i<digits[digsleft];i++)
			{
				ans+=calc(mask|(1<<(i-1)),(modus+(i*modul[digsleft]))%2520,digsleft-1,0);
			}
			ans+=calc(mask|(1<<(digits[digsleft]-1)),(modus+(digits[digsleft]*modul[digsleft]))%2520,digsleft-1,1);
			//printf("%lld ",ans);
		}
	}
	else
	{
		ans+=calc(mask,modus,digsleft-1,0);
		for(int i=1;i<=9;i++)
		{
			ans+=calc(mask|(1<<(i-1)),(modus+(i*modul[digsleft]))%2520,digsleft-1,0);
		}
	}
	dp[mask][modus][digsleft][isequal]=ans;
	return dp[mask][modus][digsleft][isequal];
}

int main()
{
    freopen("in.txt", "r", stdin);
	int q;
	scanf("%d",&q);
	modul[0]=1;
	for(int i=1;i<=19;i++)
	{
		modul[i]=(modul[i-1]*10)%2520;
	}
	while(q--)
	{
		for(int i=0;i<512;i++)
		{
		    for(int j=0;j<2520;j++)
		    {
		        for(int k=0;k<19;k++)
		        {
		            for(int l=0;l<2;l++)
		            {
		                dp[i][j][k][l]=-1;
		            }
		        }
		    }
		}
		scanf("%lld %lld %d",&l,&r,&k);
		digits.clear();
		while(r)
		{
			digits.push_back(r%10);
			r/=10;
		}
		int sz=digits.size();
		sz--;
		long long ans1=0;
		for(int i=0;i<digits[sz];i++)
		{
		    if(i==0)
		    {
		        ans1+=calc(0,0,sz-1,0);
		    }
		    else
		    {
		        ans1+=calc(1<<(i-1),(i*modul[sz])%2520,sz-1,0);
		    }
		}
		ans1+=calc(1<<(digits[sz]-1),(digits[sz]*modul[sz])%2520,sz-1,1);
		for(int i=0;i<512;i++)
		{
		    for(int j=0;j<2520;j++)
		    {
		        for(int k=0;k<19;k++)
		        {
		            for(int l=0;l<2;l++)
		            {
		                dp[i][j][k][l]=-1;
		            }
		        }
		    }
		}
		l--;
		digits.clear();
		long long yu=l;
		while(yu)
		 {
			 digits.push_back(yu%10);
			  yu/=10;
		 }
		   sz=digits.size();
		    sz--;
		long long ans2=0;
		if(l!=0)
		{
		    for(int i=0;i<digits[sz];i++)
		    {
		        if(i==0)
		        {
		            ans2+=calc(0,0,sz-1,0);
		        }
		        else
		        {
		            ans2+=calc(1<<(i-1),(i*modul[sz])%2520,sz-1,0);
		        }
	    	}
		    ans2+=calc(1<<(digits[sz]-1),(digits[sz]*modul[sz])%2520,sz-1,1);
		}
	    printf("%lld\n",ans1-ans2);

	}
	printf("%d\n", cnt);
}
