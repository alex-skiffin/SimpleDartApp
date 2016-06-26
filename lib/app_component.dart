// Copyright (c) 2016, alex-skiffin. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';

import 'package:Wrike_test/employee.dart';
import 'package:angular2/core.dart';
import 'dart:collection';
import 'package:js/js.dart' as js;
import 'dart:js';
import 'package:angular2/angular2.dart';

@Component(selector: 'my-app', templateUrl: 'app_component.html')
class AppComponent {
  var employees = new List<Employee>();
  var cities;
  var departments;

  AppComponent() {
    loadData();
  }

  void loadData() {
    var url = "https://gist.githubusercontent.com/bunopus/f48fbb06578003fb521c7c1a54fd906a/raw/e5767c1e7f172c6375f064a9441f2edd57a79f15/test_users.json";
    var request = HttpRequest.getString(url).then(onDataLoaded);
  }
  void sortByName() {
    employees.sort((a, b) => a.name.compareTo(b.name));
  }
  void sortByAge() {
    employees.sort((a, b) => a.age.compareTo(b.age));
  }
  void sortByGender() {
    employees.sort((a, b) => a.gender.compareTo(b.gender));
  }
  void sortByDepartment() {
    employees.sort((a, b) => a.department.compareTo(b.department));
  }
  void sortByAddress() {
    employees.sort((a, b) => a.address.city.compareTo(b.address.city));
  }
  void onDataLoaded(String responseText) {
    var uniqueCities = new LinkedHashMap<String, bool>();
    var uniqueDepartments = new LinkedHashMap<String, bool>();
    var jsonString = responseText;
    var temp = new EmployeeImpl.fromJsonString(jsonString);

    for (var s in temp) {
      uniqueCities[s.department] = true;
      uniqueDepartments[s.address.city] = true;
      employees.add(s);
    }
    cities = uniqueCities.keys.toList();
    departments = uniqueDepartments.keys.toList();
    employees.sort((a, b) => a.name.compareTo(b.name));

    /*var object = new JsObject(context['#example']);
    //object.dataTable();
    object.callMethod('dataTable', ['JavaScript']);*/
  }
}