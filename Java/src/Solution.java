import java.io.*;
import java.util.*;

public class Solution {
    public static void main(String[] args) {
        Scanner in = new Scanner(System.in);
        ArrayList st[] = new ArrayList[20000];
        int n = in.nextInt();
        for(int i = 0; i < n; i++) {
            int d = in.nextInt();
            st[i] = new ArrayList();
            for(int j = 0; j < d; j++) {
                int x = in.nextInt();
                st[i].add(x);
            }
        }
        int q = in.nextInt();
        for(int i = 0; i < q; i++) {
            int x = in.nextInt();
            int y = in.nextInt();
         //   System.out.println(x + " " + y);
            if (y > st[x-1].size()) System.out.println("ERROR!");
            else System.out.println(st[x-1].get(y-1));
        }
    }
}
a = object;
b = a;
b .dosomethingl