void main(){
  print("hello world");

  var product = Map<String,int >();


  addproduct(String a){
    if (product.containsKey(a)){product[a]=0;}
    product[a]+=1;
    print('你购买了');
    print(a);


  }
  addproduct('dasfasdf');








}