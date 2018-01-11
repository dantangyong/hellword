package hellword;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;

public class TxtTest {
	private static int a =1;
	/**
     * 读取txt文件的内容
     * @param file 想要读取的文件对象
     * @return 返回文件内容
     */
    public static String txt2String(File file){
        StringBuilder result = new StringBuilder();
        try{
            BufferedReader br = new BufferedReader(new FileReader(file));//构造一个BufferedReader类来读取文件
            String s = null;
            while((s = br.readLine())!=null){//使用readLine方法，一次读一行
                result.append(System.lineSeparator()+s);
            }
            br.close();    
        }catch(Exception e){
            e.printStackTrace();
        }
       
        return result.toString();
    }
    

public static void writeToFile2(String content){    
    try {
       
        File file = new File("C:/Users/Administrator/Desktop/newbadwords.txt");
        //文件不存在时候，主动穿件文件。
        if(!file.exists()){
            file.createNewFile();
        }
        FileWriter fw = new FileWriter(file,true);
        BufferedWriter bw = new BufferedWriter(fw);
        
        String id = "dfsbrtbrtbrt"+(a++);
        bw.write("\""+id+"\""+"   "+"\""+content+"\""+"   "+"\""+"2017-12-18 14:00:12"+"\""+"   "+"\""+"2017-12-18 14:00:12"+"\""+"\r\n");
        bw.close();
        fw.close();
        System.out.println("写入"+content);
         
    } catch (Exception e) {
        // TODO: handle exception
    }
}
    
    public static void main(String[] args){
        File file = new File("C:/Users/Administrator/Desktop/badword.txt");
        String result = txt2String(file);
        String news[] =result.toString().split(",");
        for(String s:news){
        	writeToFile2(s);
        }
       
        
    }
}
