/// error : true
/// message : "Data Get Successfully !"
/// data : [{"id":"17","date":"2023-12-05","time":"18:29","location":"itarsi,bhopal,banglore","price":"488,785,266","url":"test.com","created_at":"2023-12-05 18:28:38"}]

class GeteggModel {
  GeteggModel({
      bool? error, 
      String? message, 
      List<Data>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  GeteggModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<Data>? _data;
GeteggModel copyWith({  bool? error,
  String? message,
  List<Data>? data,
}) => GeteggModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "17"
/// date : "2023-12-05"
/// time : "18:29"
/// location : "itarsi,bhopal,banglore"
/// price : "488,785,266"
/// url : "test.com"
/// created_at : "2023-12-05 18:28:38"

class Data {
  Data({
      String? id, 
      String? date, 
      String? time, 
      String? location, 
      String? price, 
      String? url, 
      String? createdAt,}){
    _id = id;
    _date = date;
    _time = time;
    _location = location;
    _price = price;
    _url = url;
    _createdAt = createdAt;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _date = json['date'];
    _time = json['time'];
    _location = json['location'];
    _price = json['price'];
    _url = json['url'];
    _createdAt = json['created_at'];
  }
  String? _id;
  String? _date;
  String? _time;
  String? _location;
  String? _price;
  String? _url;
  String? _createdAt;
Data copyWith({  String? id,
  String? date,
  String? time,
  String? location,
  String? price,
  String? url,
  String? createdAt,
}) => Data(  id: id ?? _id,
  date: date ?? _date,
  time: time ?? _time,
  location: location ?? _location,
  price: price ?? _price,
  url: url ?? _url,
  createdAt: createdAt ?? _createdAt,
);
  String? get id => _id;
  String? get date => _date;
  String? get time => _time;
  String? get location => _location;
  String? get price => _price;
  String? get url => _url;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['date'] = _date;
    map['time'] = _time;
    map['location'] = _location;
    map['price'] = _price;
    map['url'] = _url;
    map['created_at'] = _createdAt;
    return map;
  }

}