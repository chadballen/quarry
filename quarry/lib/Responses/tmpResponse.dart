class TmpResponse {
  final String id;
  final int value;

  TmpResponse({this.id, this.value});

  factory TmpResponse.fromJson(Map<String, dynamic> json) {
    return TmpResponse(
      id: json['id'].toString(),
      value: json['value'],
    );
  }
}
