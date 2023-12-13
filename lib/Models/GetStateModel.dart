/// error : false
/// message : "Data Get Sucessfully"
/// data : [{"id":"1","name":"Madhya Pradesh"}]

class GetStateModel {
  GetStateModel({
      bool? error, 
      String? message, 
      List<StataData>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  GetStateModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(StataData.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<StataData>? _data;
GetStateModel copyWith({  bool? error,
  String? message,
  List<StataData>? data,
}) => GetStateModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  List<StataData>? get data => _data;

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

/// id : "1"
/// name : "Madhya Pradesh"

class StataData {
  StataData({
      String? id, 
      String? name,}){
    _id = id;
    _name = name;
}

  StataData.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  String? _id;
  String? _name;
  StataData copyWith({  String? id,
  String? name,
}) => StataData(  id: id ?? _id,
  name: name ?? _name,
);
  String? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }
}