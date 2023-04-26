class ConcoxCommandRequest {
  ConcoxCommandRequest({
    this.deviceId,
    this.type,
    this.option,
  });

  num? deviceId;
  num? type;
  ConcoxCommandRequestOption? option;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['deviceId'] = deviceId;
    data['type'] = type;
    data['option'] = option != null ? option!.toJson() : null;
    return data;
  }
}

class ConcoxCommandRequestOption {
  ConcoxCommandRequestOption({
    this.a,
    this.b,
    this.c,
    this.m,
    this.r,
    this.t1,
    this.t2,
    this.phoneNumer,
    this.phoneNumer1,
    this.phoneNumer2,
    this.phoneNumer3,
  });

  String? a;
  num? b;
  num? c;
  num? m;
  num? r;
  num? t1;
  num? t2;
  String? phoneNumer;
  String? phoneNumer1;
  String? phoneNumer2;
  String? phoneNumer3;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['A'] = a;
    data['B'] = b;
    data['C'] = c;
    data['M'] = m;
    data['R'] = r;
    data['T1'] = t1;
    data['T2'] = t2;
    data['phonenumber'] = phoneNumer;
    data['phonenumber1'] = phoneNumer1;
    data['phonenumber2'] = phoneNumer2;
    data['phonenumber3'] = phoneNumer3;
    return data;
  }
}
