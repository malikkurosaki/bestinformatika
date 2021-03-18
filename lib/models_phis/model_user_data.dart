class ModelUserData {
  Data data;
  String token;

  ModelUserData({this.data, this.token});

  ModelUserData.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class Data {
  int id;
  String name;
  String email;
  dynamic emailVerifiedAt;
  String createdAt;
  String updatedAt;
  List<Company> company;

  Data(
      {this.id,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt,
      this.company});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['company'] != null) {
      company = new List<Company>();
      json['company'].forEach((v) {
        company.add(new Company.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.company != null) {
      data['company'] = this.company.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Company {
  int id;
  String name;
  String logo;
  String email;
  String phone;
  String address;
  List<Properties> properties;

  Company(
      {this.id,
      this.name,
      this.logo,
      this.email,
      this.phone,
      this.address,
      this.properties});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    if (json['properties'] != null) {
      properties = new List<Properties>();
      json['properties'].forEach((v) {
        properties.add(new Properties.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    if (this.properties != null) {
      data['properties'] = this.properties.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Properties {
  String type;
  List<Outlets> outlets;

  Properties({this.type, this.outlets});

  Properties.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['outlets'] != null) {
      outlets = new List<Outlets>();
      json['outlets'].forEach((v) {
        outlets.add(new Outlets.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.outlets != null) {
      data['outlets'] = this.outlets.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Outlets {
  int id;
  String name;
  int companyId;
  int type;
  String url;
  String email;
  String phone;
  String address;
  String logo;
  String createdAt;
  String updatedAt;
  String logoUrl;

  Outlets(
      {this.id,
      this.name,
      this.companyId,
      this.type,
      this.url,
      this.email,
      this.phone,
      this.address,
      this.logo,
      this.createdAt,
      this.updatedAt,
      this.logoUrl});

  Outlets.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    companyId = json['company_id'];
    type = json['type'];
    url = json['url'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    logo = json['logo'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    logoUrl = json['logo_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['company_id'] = this.companyId;
    data['type'] = this.type;
    data['url'] = this.url;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['logo'] = this.logo;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['logo_url'] = this.logoUrl;
    return data;
  }
}
