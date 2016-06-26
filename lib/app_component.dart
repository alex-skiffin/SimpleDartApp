// Copyright (c) 2016, alex-skiffin. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'package:Wrike_test/employee.dart';
import 'package:angular2/core.dart';
import 'dart:collection';
import 'package:angular2/angular2.dart';

@Component(selector: 'my-app', templateUrl: 'app_component.html')
class AppComponent {
  var employees = new List<Employee>();
  var cities;
  var departments;
  bool descName, descAge, descGender, descDepart, descAddress;

  AppComponent() {
    loadData();
  }

  void loadData() {
    var url =
        "https://gist.githubusercontent.com/bunopus/f48fbb06578003fb521c7c1a54fd906a/raw/e5767c1e7f172c6375f064a9441f2edd57a79f15/test_users.json";
    var request = HttpRequest.getString(url).then(onDataLoaded);
  }

  void sortByName() {
    if (descName)
      employees.sort((a, b) => a.name.compareTo(b.name));
    else
      employees.sort((a, b) => b.name.compareTo(a.name));
    descName = !descName;
  }

  void sortByAge() {
    if (descAge)
      employees.sort((a, b) => a.age.compareTo(b.age));
    else
      employees.sort((a, b) => b.age.compareTo(a.age));
    descAge = !descAge;
  }

  void sortByGender() {
    if (descGender)
      employees.sort((a, b) => a.gender.compareTo(b.gender));
    else
      employees.sort((a, b) => b.gender.compareTo(a.gender));
    descGender = !descGender;
  }

  void sortByDepartment() {
    if (descDepart)
      employees.sort((a, b) => a.department.compareTo(b.department));
    else
      employees.sort((a, b) => b.department.compareTo(a.department));
    descDepart = !descDepart;
  }

  void sortByAddress() {
    if (descAddress)
      employees.sort((a, b) => a.address.city.compareTo(b.address.city));
    else
      employees.sort((a, b) => b.address.city.compareTo(a.address.city));
    descAddress = !descAddress;
  }

  void onDataLoaded(String responseText) {
    var uniqueCities = new LinkedHashMap<String, int>();
    var uniqueDepartments = new LinkedHashMap<String, int>();
    var jsonString = responseText;
    var temp = new EmployeeImpl.fromJsonString(jsonString);

    for (var s in temp) {
      uniqueCities[s.department] = uniqueCities[s.department] == null
          ? 0
          : uniqueCities[s.department] + 1;
      uniqueDepartments[s.address.city] = uniqueCities[s.address.city] == null
          ? 0
          : uniqueCities[s.address.city] + 1;
      employees.add(s);
    }
    cities = uniqueCities.keys.toList();
    departments = uniqueDepartments.keys.toList();
    employees.sort((a, b) => a.name.compareTo(b.name));
  }
}