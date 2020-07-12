void main(){

  Map<String,int> map13 = {"a":1,"b":2,"c":3};
  map13.forEach((String key,int value){
    print("$key  $value");
    map13["c"] = 4;

  });


}