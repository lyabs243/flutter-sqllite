

class Article{

  int id;
  String name;
  int item;
  var price;
  String shop;
  String image;

  void fromMap(Map<String, dynamic> map){
    this.id = map['id'];
    this.name = map['name'];
    this.item = map['item'];
    this.price = map['price'];
    this.shop = map['shop'];
    this.image = map['image'];
  }

  Map<String,dynamic> toMap(){
    Map<String,dynamic> map = {
      'name': this.name,
      'item': this.item,
      'price': this.price,
      'shop': this.shop,
      'image': this.image
    };

    if(this.id != null){
      map['id'] = this.id;
    }

    return map;
  }

}