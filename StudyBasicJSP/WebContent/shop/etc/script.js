function checkForm(writeform) {

	if(!writeform.product_kind.value){
	  alert("상품의 분류를 선택하십시오");
	  writeform.product_kind.focus();
	  return false;
	}
	
	if(!writeform.product_title.value){
	  alert("상품의 제목을 입력하십시오");
	  writeform.product_title.focus();
	  return false;
	}
	
	if(!writeform.product_price.value){
	  alert("상품의 가격을 입력하십시오");
	  writeform.product_price.focus();
	  return false;
	}
        
	if(!writeform.product_count.value){
	  alert("상품의 수량을 입력하십시오");
	  writeform.product_count.focus();
	  return false;
	}
	
	if(!writeform.brand.value){
	  alert("브랜드를 입력하십시오");
	  writeform.brand.focus();
	  return false;
	}
	
	if(!writeform.product_content.value){
	  alert("상품의 설명을 입력하십시오");
	  writeform.product_content.focus();
	  return false;
	}
		
	writeform.action = "productRegisterPro.jsp";
    writeform.submit();
	
 } 
 
 function updateCheckForm(writeform){

	if(!writeform.product_kind.value){
	  alert("상품의 분류를 선택하십시오");
	  writeform.product_kind.focus();
	  return false;
	}
	if(!writeform.product_title.value){
	  alert("상품의 제목을 입력하십시오");
	  writeform.product_title.focus();
	  return false;
	}
	
	if(!writeform.product_price.value){
	  alert("상품의 가격을 입력하십시오");
	  writeform.product_price.focus();
	  return false;
	}
        
	if(!writeform.product_count.value){
	  alert("상품의 수량을 입력하십시오");
	  writeform.product_count.focus();
	  return false;
	}
	
	if(!writeform.brand.value){
	  alert("브랜드를 입력하십시오");
	  writeform.brand.focus();
	  return false;
	}
	
	if(!writeform.product_content.value){
	  alert("상품의 설명을 입력하십시오");
	  writeform.product_content.focus();
	  return false;
	}
		
	writeform.action = "productUpdatePro.jsp";
    writeform.submit();
	
 } 
 