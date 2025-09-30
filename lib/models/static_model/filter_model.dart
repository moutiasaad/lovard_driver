import 'package:flutter/material.dart';

import 'package:lovard_delivery_app/shared/language/extension.dart';

List<Map<String, dynamic>> filterModel = [
  {
    "id": 1,
    "value": "filter.lowHigh",
    "icon": Icons.add,
  },
  {
    "id": 2,
    "value": "filter.highLow",
    "icon": Icons.add,
  },
];

List<Map<String, dynamic>> getFilterModel(BuildContext context) {
  return filterModel.map((e) {
    return {
      "id": e["id"],
      "value": context.translate(e["value"]),
      "icon": e["icon"],
    };
  }).toList();
}

int getIdByName(BuildContext context, String name) {
  for (var item in getFilterModel(context)) {
    if (item['value'] == name) {
      return item['id'];
    }
  }
  return 0;
}
