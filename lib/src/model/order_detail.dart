
class OrderDetail{
  late String? refNo;
  late String? formatedDueDate;
  late String? itemName;
  late String? status;


  OrderDetail(this.refNo, this.formatedDueDate, this.itemName, this.status);

  OrderDetail.fromJson(Map<String, dynamic>json):refNo=json['refNo'],formatedDueDate=json['formatedDueDate'],itemName=json['itemName'],status=json['status'];

  @override
  String toString() {
    return 'OrderDetail{refNo: $refNo, orderDate: $formatedDueDate, itemName: $itemName, status: $status}';
  }
}