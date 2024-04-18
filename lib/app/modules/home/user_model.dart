class User {
  int? id;
  String? username;
  String? email;
  String? provider;
  bool? confirmed;
  bool? blocked;
  String? createdAt;
  String? updatedAt;
  double? balance;
  List<Ledgers>? ledgers;
  String? avatar;

  User({
    this.id,
    this.username,
    this.email,
    this.provider,
    this.confirmed,
    this.blocked,
    this.createdAt,
    this.updatedAt,
    this.balance,
    this.ledgers,
    this.avatar,
      });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    provider = json['provider'];
    confirmed = json['confirmed'];
    blocked = json['blocked'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    balance = (json['balance'] as num?)?.toDouble();
    if (json['ledgers'] != null) {
      ledgers = <Ledgers>[];
      json['ledgers'].forEach((v) {
        ledgers?.add(Ledgers.fromJson(v));
      });
    };
    avatar = json['avatar'];
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
    if (ledgers != null) {
      data['ledgers'] = ledgers?.map((v) => v.toJson()).toList();
    }
    data['avatar'] = avatar;
    return data;
  }
}

class Ledgers {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  String? publishedAt;
  double? amount;
  String? date;
  String? category;
  String? remark;
  String? payType;

  Ledgers(
      {this.id,
      this.name,
      this.createdAt,
      this.updatedAt,
      this.publishedAt,
      this.amount,
      this.date,
      this.category,
      this.remark,
      this.payType});

  Ledgers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    publishedAt = json['publishedAt'];
    amount = (json['amount'] as num?)?.toDouble();
    date = json['date'];
    category = json['category'];
    remark = json['remark'];
    payType = json['payType'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['publishedAt'] = publishedAt;
    data['amount'] = amount;
    data['date'] = date;
    data['category'] = category;
    data['remark'] = remark;
    data['payType'] = payType;
    return data;
  }
}
