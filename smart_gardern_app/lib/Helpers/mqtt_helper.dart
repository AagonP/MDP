// This file is used only for functions that help mapping the json string into Map in flutter

Map mqttDecode(String jsonString) {
  var split = jsonString.split(",");
  Map data = {
    "id": split[0].split(":")[1].split("\"")[1],
    "name": split[1].split(":")[1].split("\"")[1],
    "data": split[2].split(":")[1].split("\"")[1],
    "unit": split[3].split(":")[1].split("\"")[1],
  };
  return data;
}

String mqttEncode(Map data) {
  String id = "\"id\":\"${data['id']}\"";
  String name = "\"id\":\"${data['name']}\"";
  String value = "\"id\":\"${data['data']}\"";
  String unit = "\"id\":\"${data['unit']}\"";
  return "$id,$name,$value,$unit";
}
