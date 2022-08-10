class ShopModel {
  String? name;
  var rating;
  int? discount;
  int? discountWas;
  int? isUpto;
  String? category;
  String? logo;

  ShopModel(
      {this.name,
        this.rating,
        this.discount,
        this.discountWas,
        this.isUpto,
        this.category,
        this.logo});

  ShopModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    rating = json['rating'];
    discount = json['discount'];
    discountWas = json['discountWas'];
    isUpto = json['isUpto'];
    category = json['category'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['rating'] = this.rating;
    data['discount'] = this.discount;
    data['discountWas'] = this.discountWas;
    data['isUpto'] = this.isUpto;
    data['category'] = this.category;
    data['logo'] = this.logo;
    return data;
  }
}