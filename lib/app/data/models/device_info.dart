import 'package:pharmix/app/utils/helpers/storage_helper.dart';

class DeviceInfo {
  final String? model;
  final String? brand;
  DeviceInfo({this.brand, this.model});
  factory DeviceInfo.fromJson({required Map<String, String> data}) =>
      DeviceInfo(model: data['model'], brand: data['brand']);

  Map<String, dynamic> toJson() => {'model': model, 'brand': brand};

  static void saveDeviceInfo({required Map<String, String> deviceInfos}) {
    StorageHelper.set('device_infos', deviceInfos);
  }

  static DeviceInfo getDeviceInfo() {
    Map<String, String> data = StorageHelper.get('device_infos');
    return DeviceInfo.fromJson(data: data);
  }
}
