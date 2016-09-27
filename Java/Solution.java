import java.io.*;
import java.util.*;

public final class Solution {
	public static void main(String[] args) {
		Scanner in = new Scanner(System.in);
		int n = in.nextInt(); in.nextLine();
		//System.out.println(n);
		Map myMap = new HashMap();
		for(int i = 0; i < n; i++) {
			String people = in.nextLine();
			String number = in.nextLine();
			myMap.put(people, number);
		}
		while (in.hasNext()) {
			String people = in.nextLine();
			if (myMap.containsKey(people)) System.out.println(people + "=" + myMap.get(people));
			else System.out.println("Not found");
		}
	}
}