class ResultBody{
  late int? errNo;
  late String? errMsg;

  ResultBody(this.errNo, this.errMsg);

  ResultBody.fromJson(Map<String, dynamic>json):errNo=json['errNo'],errMsg=json['errMsg'];
}