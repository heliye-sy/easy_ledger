class User {
  int id;
  String username;
  String email;
  String provider;
  bool confirmed;
  bool blocked;
  String createdAt;
  String? updatedAt;
  num? balance;
  String? avatar;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.provider,
    required this.confirmed,
    required this.blocked,
    required this.createdAt,
    required this.updatedAt,
    this.balance,
    this.avatar
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id : json['id'],
      username : json['username'],
      email : json['email'],
      provider : json['provider'],
      confirmed : json['confirmed'],
      blocked : json['blocked'],
      createdAt : json['createdAt'],
      updatedAt : json['updatedAt'],
      balance : json['balance'],
      avatar : json['avatar'] != null ? json['avatar']['url'] : null
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['email'] = email;
    data['provider'] = provider;
    data['confirmed'] = confirmed;
    data['blocked'] = blocked;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['balance'] = balance;
    if (avatar != null) {
      data['avatar'] = avatar;
    }
    return data;
  }
}

class Ledger {
  int id;
  String name;
  num amount;
  String date;
  String category;
  String payType;
  String? remark;
  String createdAt;
  String updatedAt;
  String? publishedAt;

  Ledger({
    required this.id,
    required this.name,
    required this.amount,
    required this.date,
    required this.category,
    required this.payType,
    this.remark,
    required this.createdAt,
    required this.updatedAt,
    this.publishedAt
  });

  factory Ledger.fromJson(Map<String, dynamic> json) {
    final productAttributes = json['attributes'];
    return Ledger(
      id : json['id'],
      name : productAttributes['name'],
      amount : productAttributes['amount'],
      date : productAttributes['date'],
      category : productAttributes['category'],
      payType : productAttributes['payType'],
      remark : productAttributes['remark'],
      createdAt : productAttributes['createdAt'],
      updatedAt : productAttributes['updatedAt'],
      publishedAt : productAttributes['publishedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['amount'] = amount;
    data['date'] = date;
    data['category'] = category;
    data['payType'] = payType;
    data['remark'] = remark;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['publishedAt'] = publishedAt;
    return data;
  }
}

class Pagination {
  int page;
  int pageSize;
  int pageCount;
  int total;

  Pagination({
    required this.page,
    required this.pageSize,
    required this.pageCount,
    required this.total,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      page: json['page'],
      pageSize: json['pageSize'],
      pageCount: json['pageCount'],
      total: json['total']
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['page'] = page;
    data['pageSize'] = pageSize;
    data['pageCount'] = pageCount;
    data['total'] = total;
    return data;
  }
}
