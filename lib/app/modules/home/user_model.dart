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
  List<Ledger>? ledgers;
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
    this.ledgers,
    this.avatar
  });

  factory User.fromJson(Map<String, dynamic> json) {
    List<Ledger> ledgers = [];
    if (json['ledgers'] != null) {
      json['ledgers'].forEach((v) {
        ledgers.add(Ledger.fromJson(v));
      });
    }
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
      ledgers : ledgers,
      avatar : json['avatar']['url'],
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
    if (ledgers != null) {
      data['ledgers'] = ledgers?.map((v) => v.toJson()).toList();
    }
    if (avatar != null) {
      data['avatar'] = avatar;
    }
    return data;
  }
}

class Ledger {
  int id;
  String name;
  double amount;
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
    return Ledger(
      id : json['id'],
      name : json['name'],
      amount : json['amount'],
      date : json['date'],
      category : json['category'],
      payType : json['payType'],
      remark : json['remark'],
      createdAt : json['createdAt'],
      updatedAt : json['updatedAt'],
      publishedAt : json['publishedAt'],
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
