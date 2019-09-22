class HomeBannerEntity {
	List<HomeBannerResult> result;

	HomeBannerEntity({this.result});

	HomeBannerEntity.fromJson(Map<String, dynamic> json) {
		if (json['result'] != null) {
			result = new List<HomeBannerResult>();(json['result'] as List).forEach((v) { result.add(new HomeBannerResult.fromJson(v)); });
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

class HomeBannerResult {
	String sId;
	String pic;
	String title;
	String url;
	String status;

	HomeBannerResult({this.sId, this.pic, this.title, this.url, this.status});

	HomeBannerResult.fromJson(Map<String, dynamic> json) {
		sId = json['_id'];
		pic = json['pic'];
		title = json['title'];
		url = json['url'];
		status = json['status'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['_id'] = this.sId;
		data['pic'] = this.pic;
		data['title'] = this.title;
		data['url'] = this.url;
		data['status'] = this.status;
		return data;
	}
}
