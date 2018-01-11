package hellword;

public class EscapeXml {
   public static void main(String[] args) {
	String s ="<str name=Total Rows Fetched>22</str><str name=Total Documents Processed>22</str><str name=Total Documents Skipped>0</str><str name=Full Dump Started>2017-12-05 06:33:17</str><str name=>Indexing completed. Added/Updated: 22 documents. Deleted 0 documents.</str><str name=Committed>2017-12-05 06:33:17</str><str name=Time taken>0:0:0.40</str></lst></response>";
	System.out.println(s.indexOf("Indexing"));
  }
}
