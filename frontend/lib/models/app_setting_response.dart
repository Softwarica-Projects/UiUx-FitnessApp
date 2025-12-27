class AppSettingResponse {
  int? id;
  String? siteName;

  AppSettingResponse({
    this.id,
    this.siteName,
  });

  AppSettingResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    siteName = json['site_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['site_name'] = this.siteName;
    return data;
  }
}
