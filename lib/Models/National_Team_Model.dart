class Countries {
  String? id;
  String? name;
  String? country;
  String? continent;
  String? competitions;
  String? alias;
  String? flag;

  Countries(
      {this.id,
      this.name,
      this.country,
      this.continent,
      this.competitions,
      this.alias,
      this.flag});

  Countries.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    country = json['country'];
    continent = json['continent'];
    competitions = json['competitions'];
    alias = json['alias'];
    flag = json['flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['country'] = this.country;
    data['continent'] = this.continent;
    data['competitions'] = this.competitions;
    data['alias'] = this.alias;
    data['flag'] = this.flag;
    return data;
  }
}
