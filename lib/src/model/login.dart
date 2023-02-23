
class Login{
  late String? userCode;
  late int? groupNo;
  late String userName;
  Login(this.userCode, this.groupNo, this.userName);

  Login.fromJson(Map<String, dynamic>json):userCode=json['userCode'],groupNo=json['groupNo'],userName=json['userName'];
}