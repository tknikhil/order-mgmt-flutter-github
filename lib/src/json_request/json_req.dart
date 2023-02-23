import 'dart:convert';

class JsonReq {
  String loginEncode(String username, String password) {
    return json.encode({
      "data": {
        "loginData": {'userName': username, 'password': password}
      }
    });
  }

  String saveItem(
      String itemName,
      double weight,
      String itemSize,
      int qty,
      double meltPer,
      String stamp,
      String hook,
      String designSample,
      String sizeSample,
      String refNo,
      List<String> imageData,
      String remark,
      int days) {
    print({
      "data": {
        "ordersDtls":
        {
          "itemName": itemName,
          "weight": weight,
          "qty": qty,
          "itemSize": itemSize,
          "meltPer": meltPer,
          "stamp": stamp,
          "hook": hook,
          "remark": remark,
          "refNo": refNo,
          "designSample": designSample,
          "sizeSample": sizeSample,
          "imageData":imageData,
          "days": days
        }
      }
    });
    return json.encode({
      "data": {
        "ordersDtls":
          {
            "itemName": itemName,
            "weight": weight,
            "qty": qty,
            "itemSize": itemSize,
            "meltPer": meltPer,
            "stamp": stamp,
            "hook": hook,
            "remark": remark,
            "refNo": refNo,
            "designSample": designSample,
            "imageData":imageData,
            "sizeSample": sizeSample,
            "days": days
          }
      }
    });

  }
}
