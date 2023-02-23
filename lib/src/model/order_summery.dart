class OrderSummery{
  String? itemUnit;
  String itemName;
  double? weight;
  int? qty;
  String? itemSize;
  double? meltPer;
  String? hook;
  String? refNo;
  String? designSample;
  String? sizeSample;
  int? days;
  String? stamp;
  String? dueDate;
  String? workshop;
  String? status;
  String? orderDate;
  String? custName;
  String? type;


  OrderSummery(
      this.itemUnit,
      this.itemName,
      this.weight,
      this.qty,
      this.itemSize,
      this.meltPer,
      this.hook,
      this.refNo,
      this.designSample,
      this.sizeSample,
      this.days,
      this.dueDate,
      this.workshop,
      this.status,
      this.orderDate,
      this.custName,
      this.type,
      this.stamp);

  OrderSummery.fromJson(Map<String,dynamic> json):itemUnit=json['itemUnit']
  ,itemName=json['itemName']
  ,weight=json['weight']
  ,qty=json['qty']
  ,stamp=json['stamp']
  ,itemSize=json['itemSize']
  ,meltPer=json['meltPer']
  ,hook=json['hook']
  ,refNo=json['refNo']
  ,designSample=json['designSample']
  ,sizeSample=json['sizeSample']
  ,days=json['days']
  ,dueDate=json['formatedDueDate']
  ,workshop=json['wrkshpCode']
  ,status=json['status']
  ,orderDate=json['formatedOrdrDate']
  ,custName=json['custName']
  ,type=json['type'];


}