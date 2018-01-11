package hellword;

public class StringIndexOf {

	public static void main(String[] args) {
		String s = "/a/cms/newsCenter?id=34";
		String s1[]= s.split("/");
		System.out.println(s1);
		String s2 = s1[s1.length-1];
		System.out.println(s2);
		if(s2.indexOf("?")!=-1){
			String s3 = s2.substring(0, s2.indexOf("?"));
			System.out.println(s3);
		}
	}

}
