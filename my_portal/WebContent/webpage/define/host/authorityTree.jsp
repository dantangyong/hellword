<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
<title>数据选择</title>
<meta name="decorator" content="blank" />
<%@include file="/webpage/include/treeview.jsp"%>
</head>
<body>
    <input type="hidden" id="id" value="${id}"/>
	<div id="ztree" class="ztree" style="padding: 15px 20px;"></div>
	<script type="text/javascript">
    var tree;
    var setting = {
        data : {
            simpleData : {
                enable : true,
                idKey : "id",
                //pIdKey : "pId",
                //rootPId : '0'
            }
        },
        check: {
            enable: true,
            chkStyle: "checkbox",
            chkboxType: { "Y": "p", "N": "s" }
        },
        callback : {
            /*onClick : function(event, treeId, treeNode) {
                var id = treeNode.pId == '0' ? '' : treeNode.pId;
                
            }*/
        	onCheck:function(event, treeId, treeNode){
        		//alert(treeNode.checked);
        		if(treeNode.checked){
        			//寻找首页权限并选中,先获取到根节点，然后遍历整个树
        			var root=getRoot(treeNode);
        			//alert(root.name);
        			var home=findHomePageAuth(root);
        			//console.log(home);
        			if(home){
        				if(!home.checked){
        					//home.checked=true;
        					tree.checkNode(home, true, true);
        				}
        			}
        		}
        	}
        }
    };
    
    function findHomePageAuth(root){
    	var children=root.children;
    	if(children&&children.length){
    		for(var i=0;i<children.length;i++){
    			var page=children[i];
    			if(page.obj.home){
    				return page;
    			}
    		}
    		return null;
    	}else{
    		return null;
    	}
    }
    
    function getRoot(treeNode){
    	var parent=treeNode.getParentNode();
    	if(!parent){
    		return treeNode;
    	}else{
    		return getRoot(parent);
    	}
    }

    function refreshTree() {
        $.getJSON("${ctx}/plugin/host/plugins/api/authorityTreeData?id="+$("#id").val(), function(data) {
        	//console.log(data);
        	tree=$.fn.zTree.init($("#ztree"), setting, data);
        	//tree.expandAll(true);
        });
    }
    refreshTree();
</script>
</body>