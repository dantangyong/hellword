package com.mht.define.portal.cms.utils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
public class SolrDvidePage {
				
	//这个方法较为完善 page当前页,last最后一页,maxSizeNum为上一页和下一页之间的页数
	
	 public static List<Map<String, Object>> input(int page,int last,int maxSizeNum){
		 List<Map<String,Object>> list = new ArrayList<>();
		 
		if(page <= last){
		 if(maxSizeNum >  0){
			 if(last > 0 ){
				 if(page !=1){
					 System.out.print("上一页"+(page-1)+"\t");
					 Map<String, Object> map=new HashMap<>();
					 map.put("上一页", page-1);
					 list.add(map);
				 }
				 if(last<=maxSizeNum){
					 for(int i=1;i<=last;i++){
						 if(page !=i){
							 System.out.print(i+"\t");
							 Map<String, Object> map=new HashMap<>();
							 map.put("其他页", i);
							 list.add(map);
						 }
						 else{
							 System.out.print("当前页"+i+"\t");
							 Map<String, Object> map=new HashMap<>();
							 map.put("当前页", page);
							 list.add(map);
						 }
					 }
				 }
				 if(last>maxSizeNum){
					 int avgNum=maxSizeNum/2+1;
					 if(page<=avgNum){
						 for(int i=1;i<=maxSizeNum;i++){
							 if(page !=i){
								 System.out.print(i+"\t");
								
								 Map<String, Object> map=new HashMap<>();
								 map.put("其他页", i);
								 list.add(map);
								 
							 }
							 else{
								 System.out.print("当前页"+i+"\t");
								 Map<String, Object> map=new HashMap<>();
								 map.put("当前页", page);
								 list.add(map);
							 }
						 }
					 }
					 if(page>avgNum){
						 if(last-page >= avgNum){
							 for(int i=page-maxSizeNum/2;i<=(page-maxSizeNum/2)+maxSizeNum-1;i++){
								 if(page !=i){
									 System.out.print(i+"\t");
									 Map<String, Object> map=new HashMap<>();
									 map.put("其他页", i);
									 list.add(map); 
								 }
								 else{
									 
									 System.out.print("当前页"+i+"\t");
									 Map<String, Object> map=new HashMap<>();
									 map.put("当前页", page);
									 list.add(map);
								 }
							 }
						 }
						//if(last-page <= avgNum) {
						 else{
							 for(int i=page-(maxSizeNum-1-(last-page));i<=last;i++){
								 if(page !=i){
									 System.out.print(i+"\t");
									 Map<String, Object> map=new HashMap<>();
									 map.put("其他页", i);
									 list.add(map);
								 }
								 else{
									 System.out.print("当前页"+i+"\t");
									 Map<String, Object> map=new HashMap<>();
									 map.put("当前页", page);
									 list.add(map);
									 
								 }
							 }
						}
					 }
						 
					 }
				 }
				 if(page != last){
					 System.out.print("下一页"+(page+1)+"\t");
					 Map<String, Object> map=new HashMap<>();
					 map.put("下一页", page+1);
					 list.add(map);
				 }
			 }
		   }
		return list;
		
		}
	 
public static void main(String[] args) {

input(4,4,1);	

	
		
	}
}
