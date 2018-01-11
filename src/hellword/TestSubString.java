package hellword;

public class TestSubString {
  public static void main(String[] args) {
//	String name = "abc.ht";
//	
//	
//	System.out.println(name.substring(name.lastIndexOf('.'),name.length()));
//
//	String name1 = "/swjtu/images/header1.png";
//	System.out.println(name1.substring(6,name1.length()));
	  int page = new TestSubString().getTotalPage(11, 10);
	  System.out.println(page);
  }
  
  public int getTotalPage(int totalRecods,int pageSize) {
		int totalPage = totalRecods/pageSize;
		if(totalRecods%pageSize!=0){
			totalPage++;
		}
		return totalPage;
	}
}
