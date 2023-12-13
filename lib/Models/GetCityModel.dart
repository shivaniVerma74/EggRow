/// error : false
/// message : "Data Get Sucessfully"
/// data : [{"id":"1","state_id":"1","name":"Indore"},{"id":"2","state_id":"1","name":"Bhopal"}]

class GetCityModel {
  GetCityModel({
      bool? error, 
      String? message, 
      List<CityData>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  GetCityModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(CityData.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<CityData>? _data;
GetCityModel copyWith({  bool? error,
  String? message,
  List<CityData>? data,
}) => GetCityModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  List<CityData>? get data => _data;

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
/// state_id : "1"
/// name : "Indore"

class CityData {
  CityData({
      String? id, 
      String? stateId, 
      String? name,}){
    _id = id;
    _stateId = stateId;
    _name = name;
}

  CityData.fromJson(dynamic json) {
    _id = json['id'];
    _stateId = json['state_id'];
    _name = json['name'];
  }

  String? _id;
  String? _stateId;
  String? _name;
  CityData copyWith({String? id,
  String? stateId,
  String? name,
}) => CityData(id: id ?? _id,
  stateId: stateId ?? _stateId,
  name: name ?? _name,
);
  String? get id => _id;
  String? get stateId => _stateId;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['state_id'] = _stateId;
    map['name'] = _name;
    return map;
  }

}