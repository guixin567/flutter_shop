class RightCategoryEntity {
	List<RightCategoryResult> result;

	RightCategoryEntity({this.result});

	RightCategoryEntity.fromJson(Map<String, dynamic> json) {
		if (json['result'] != null) {
			result = new List<RightCategoryResult>();(json['result'] as List).forEach((v) { result.add(new RightCategoryResult.fromJson(v)); });
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

class RightCategoryResult {
	String pid;
	String sId;
	String pic;
	String sort;
	String title;
	String status;

	RightCategoryResult({this.pid, this.sId, this.pic, this.sort, this.title, this.status});

	RightCategoryResult.fromJson(Map<String, dynamic> json) {
		pid = json['pid'];
		sId = json['_id'];
		pic = json['pic'];
		sort = json['sort'];
		title = json['title'];
		status = json['status'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['pid'] = this.pid;
		data['_id'] = this.sId;
		data['pic'] = this.pic;
		data['sort'] = this.sort;
		data['title'] = this.title;
		data['status'] = this.status;
		return data;
	}
}
