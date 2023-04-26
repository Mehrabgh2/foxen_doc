import 'package:hive_flutter/adapters.dart';

part 'foxen_user.g.dart';

@HiveType(typeId: 0)
class FoxenUser {
  @HiveField(0)
  String? token;
  @HiveField(1)
  User? user;

  FoxenUser({
    this.token,
    this.user,
  });

  factory FoxenUser.fromJson(Map<String, dynamic> json) {
    final token = json['token'] ?? '';
    final user = User.fromJson(json['user'] ?? json);
    return FoxenUser(token: token, user: user);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['token'] = token;
    data['user'] = user == null ? null : user!.toJson();
    return data;
  }
}

@HiveType(typeId: 1)
class User {
  @HiveField(0)
  int? id;
  @HiveField(1)
  int? accountId;
  @HiveField(2)
  String? firstname;
  @HiveField(3)
  String? lastname;
  @HiveField(4)
  String? username;
  @HiveField(5)
  String? nationalcode;
  @HiveField(6)
  UserProperties? email;
  @HiveField(7)
  UserProperties? phone;
  @HiveField(8)
  String? address;
  @HiveField(9)
  int? roleId;
  @HiveField(10)
  String? registertimestamp;
  @HiveField(11)
  String? userType;
  @HiveField(12)
  String? photo;
  @HiveField(13)
  String? access;
  @HiveField(14)
  int? itemPerPage;
  @HiveField(15)
  String? restriction;

  User({
    this.id,
    this.accountId,
    this.firstname,
    this.lastname,
    this.username,
    this.nationalcode,
    this.email,
    this.phone,
    this.address,
    this.roleId,
    this.registertimestamp,
    this.userType,
    this.photo,
    this.access,
    this.itemPerPage,
    this.restriction,
  });

  factory User.fromJson(Map<dynamic, dynamic> json) {
    final id = json['_id'];
    final accountId = json['account_id'];
    final firstname = json['firstname'];
    final lastname = json['lastname'];
    final username = json['username'];
    final nationalcode = json['nationalcode'];
    final email = json['email'] == null
        ? null
        : UserProperties.fromJson(Map<String, dynamic>.from(json['email']));
    final phone = json['phone'] == null
        ? null
        : UserProperties.fromJson(Map<String, dynamic>.from(json['phone']));
    final address = json['address'];
    final roleId = json['role_id'];
    final registertimestamp = json['registertimestamp'];
    final userType = json['usertype'];
    final photo = json['photo'];
    final access = json['access'];
    final itemPerPage =
        json['setting'] != null && json['setting']['itemPerPage'] != null
            ? json['setting']['itemPerPage']
            : json['itemPerPage'];
    final restriction = json['restriction'];
    return User(
        id: id,
        accountId: accountId,
        firstname: firstname,
        lastname: lastname,
        username: username,
        nationalcode: nationalcode,
        email: email,
        phone: phone,
        address: address,
        roleId: roleId,
        registertimestamp: registertimestamp,
        userType: userType,
        photo: photo,
        access: access,
        itemPerPage: itemPerPage,
        restriction: restriction);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = id;
    data['account_id'] = accountId;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['username'] = username;
    data['nationalcode'] = nationalcode;
    data['email'] = email == null ? null : email!.toJson();
    data['phone'] = phone == null ? null : phone!.toJson();
    data['address'] = address;
    data['role_id'] = roleId;
    data['registertimestamp'] = registertimestamp;
    data['userType'] = userType;
    data['photo'] = photo;
    data['itemPerPage'] = itemPerPage;
    data['access'] = access;
    data['restriction'] = restriction;
    return data;
  }
}

@HiveType(typeId: 2)
class UserProperties {
  @HiveField(0)
  String? name;
  @HiveField(1)
  bool? isVerified;

  UserProperties({
    this.name,
    this.isVerified,
  });

  factory UserProperties.fromJson(Map<String, dynamic> json) {
    final name = json['value'];
    final isVerified = json['isVerified'];
    return UserProperties(name: name, isVerified: isVerified);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['value'] = name;
    data['isVerified'] = isVerified;
    return data;
  }
}
