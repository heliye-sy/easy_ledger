import 'package:intl/intl.dart';
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
  Avatar?  avatar;

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
      avatar : json['avatar'] != null ? Avatar.fromJson(json['avatar']) : null
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['username'] = username;
    data['avatar'] = avatar?.id;
    data['balance'] = balance;
    return data;
  }
}

class Avatar {
  int id;
  String url;

  Avatar({
    required this.id,
    required this.url,
  });

  factory Avatar.fromJson(Map<String, dynamic> json) {
    return Avatar(
        id: json['id'],
        url: json['url']
    );
  }
}

class Ledgers{
  List<Ledger> data;
  Pagination meta;

  Ledgers({
   required this.data,
   required this.meta,
  });

  factory Ledgers.fromJson(Map<String, dynamic> json) {
    return Ledgers(
        data: (json['data'] as List).map((ledger) => Ledger.fromJson(ledger)).toList(),
        meta: Pagination.fromJson(json['meta']['pagination']),
    );
  }
}

class Ledger {
  int id;
  String name;
  String amount;
  DateTime date;
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
    required this.payType,
    this.remark,
    required this.createdAt,
    required this.updatedAt,
    this.publishedAt
  });

  factory Ledger.fromJson(Map<String, dynamic> json) {
    final productAttributes = json['attributes'];
    final Map<String, String> mio = {
      'out': '-',
      'in': '+'
    };
    DateFormat formatter = DateFormat("yyyy-MM-ddTHH:mm:ss");
    return Ledger(
      id : json['id'],
      name : productAttributes['name'],
      amount : '${mio[productAttributes['category']]!}${productAttributes['amount']}',
      date : formatter.parse(productAttributes['date']),
      payType : productAttributes['payType'],
      remark : productAttributes['remark'],
      createdAt : productAttributes['createdAt'],
      updatedAt : productAttributes['updatedAt'],
      publishedAt : productAttributes['publishedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, String> mio = {
      '-': 'out',
      '+': 'in'
    };
    DateFormat formatter = DateFormat("yyyy-MM-ddTHH:mm:ss.000Z");
    final data = <String, dynamic>{};
    data['name'] = name;
    data['category'] = mio[amount[0]];
    data['amount'] = amount.substring(1);
    data['date'] = formatter.format(date);
    data['payType'] = payType;
    data['remark'] = remark;
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
