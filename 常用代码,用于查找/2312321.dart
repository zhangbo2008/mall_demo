void main(){


  var product = Map<String,int >();


  addproduct(String a){

    if (!product.containsKey(a))
    {product[a]=0;}
//    print(product[a]);
    product[a]+=1;
    print('你购买了');
    print(a);


  }
  addproduct('dasfasdf');








}