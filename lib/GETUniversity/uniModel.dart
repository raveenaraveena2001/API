class University {
  String? country;
  List<String>? webPages;
  String? alphaTwoCode;
  List<String>? domains;
  Null? stateProvince;
  String? name;

  University(
      {this.country,
        this.webPages,
        this.alphaTwoCode,
        this.domains,
        this.stateProvince,
        this.name});

  University.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    webPages = json['web_pages'].cast<String>();
    alphaTwoCode = json['alpha_two_code'];
    domains = json['domains'].cast<String>();
    stateProvince = json['state-province'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    data['web_pages'] = this.webPages;
    data['alpha_two_code'] = this.alphaTwoCode;
    data['domains'] = this.domains;
    data['state-province'] = this.stateProvince;
    data['name'] = this.name;
    return data;
  }
}
