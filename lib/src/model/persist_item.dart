class PersistItem{
  String? itemName;
  double? weight;
  String? itemSize;
  int? qty;
  double? meltPer;
  String? stamp;
  String? hook;
  String? designSample;
  String? sizeSample;
  String? refNo;
  String? remark;
  int? days;
  String? dueDate;

  PersistItem(
      this.itemName,
      this.weight,
      this.itemSize,
      this.qty,
      this.meltPer,
      this.stamp,
      this.hook,
      this.designSample,
      this.sizeSample,
      this.refNo,
      this.remark,
      this.days,
      this.dueDate);

  PersistItem.fromJson(Map<String, dynamic>json):itemName=json['itemName']
  ,weight=json['weight']
  ,itemSize=json['itemSize']
  ,qty=json['qty']
  ,meltPer=json['meltPer']
  ,stamp=json['stamp']
  ,hook=json['hook']
  ,designSample=json['designSample']
  ,sizeSample=json['sizeSample']
  ,refNo=json['refNo']
  ,remark=json['remark']
  ,days=json['days']
  ,dueDate=json['dueDate'];
}