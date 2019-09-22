class ProductEntity {
	List<ProductResult> result;

	ProductEntity({this.result});

	ProductEntity.fromJson(Map<String, dynamic> json) {
		if (json['result'] != null) {
			result = new List<ProductResult>();(json['result'] as List).forEach((v) { result.add(new ProductResult.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.result != null) {
      data['result'] =  this.result.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class ProductResult {
	int price;
	String oldPrice;
	String sId;
	String pic;
	String title;
	String cid;
	String sPic;

	ProductResult({this.price, this.oldPrice, this.sId, this.pic, this.title, this.cid, this.sPic});

	ProductResult.fromJson(Map<String, dynamic> json) {
		price = json['price'];
		oldPrice = json['old_price'];
		sId = json['_id'];
		pic = json['pic'];
		title = json['title'];
		cid = json['cid'];
		sPic = json['s_pic'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['price'] = this.price;
		data['old_price'] = this.oldPrice;
		data['_id'] = this.sId;
		data['pic'] = this.pic;
		data['title'] = this.title;
		data['cid'] = this.cid;
		data['s_pic'] = this.sPic;
		return data;
	}
}
