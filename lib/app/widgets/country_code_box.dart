import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:country_code_picker/country_code_picker.dart';

CountryCodePicker contryCodeBox({RxString? selectedCode}) {
  return CountryCodePicker(
    onChanged: (countryCode) {
      selectedCode!.value = countryCode.dialCode!;
    },
    initialSelection: "Cote d'Ivoire",
    favorite: const ["Cote d'Ivoire"],
    enabled: true,
    closeIcon: Icon(
      Icons.close,
      color: Theme.of(Get.context!).primaryColor,
    ),
    textStyle: TextStyle(
      color: Theme.of(Get.context!).primaryColor,
    ),
    margin: const EdgeInsets.only(right: 5.0),
    padding: const EdgeInsets.all(0.0),
    flagWidth: 25,
  );
}
