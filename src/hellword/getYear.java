package hellword;

import java.util.Calendar;

public class getYear {
   public static void main(String[] args) {
	   Calendar cal = Calendar.getInstance();
	   int year = cal.get(Calendar.YEAR);
	   System.out.println(year);
}
}
