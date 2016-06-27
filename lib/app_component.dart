// Copyright (c) 2016, alex-skiffin. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'package:Wrike_test/employee.dart';
import 'package:angular2/core.dart';
import 'dart:collection';

@Component(selector: 'my-app', templateUrl: 'app_component.html')
class AppComponent {
  var employeesFull = new List<Employee>();
  var employees = new List<Employee>();
  var cities = new List<String>();
  var departments = new List<String>();
  bool descName, descAge, descGender, descDepart, descAddress;
  int maleC, femaleC;
  var genderFilter = new List<String>();
  var departFilter = new List<String>();
  var cityFilter = new List<String>();

  AppComponent() {
    genderFilter.add("male");
    genderFilter.add("female");
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
      uniqueDepartments[s.department] = uniqueDepartments[s.department] == null
          ? 1
          : uniqueDepartments[s.department] + 1;
      uniqueCities[s.address.city] = uniqueCities[s.address.city] == null
          ? 1
          : uniqueCities[s.address.city] + 1;
      employeesFull.add(s);
    }

    employees = employeesFull;

    uniqueCities.forEach((x, y) {
      cityFilter.add(x);
      return cities.add(x + " (" + y.toString() + ")");
    });
    uniqueDepartments.forEach((x, y) {
      departFilter.add(x);
      return departments.add(x + " (" + y.toString() + ")");
    });
    maleC = employees.where((e) => e.gender == 'male').length;
    femaleC = employees.where((e) => e.gender == 'female').length;
    employees.sort((a, b) => a.name.compareTo(b.name));
  }

  showLessCity(Event cityEvent) {
    if (cityEvent.target.checked)
      cityFilter.add(cityEvent.target.defaultValue
          .substring(0, cityEvent.target.defaultValue.length - 4));
    else
      cityFilter.remove(cityEvent.target.defaultValue
          .substring(0, cityEvent.target.defaultValue.length - 4));
    ApplyFilter();
  }

  showLessDepart(Event departEvent) {
    if (departEvent.target.checked)
      departFilter.add(departEvent.target.defaultValue
          .substring(0, departEvent.target.defaultValue.length - 4));
    else
      departFilter.remove(departEvent.target.defaultValue
          .substring(0, departEvent.target.defaultValue.length - 4));
    ApplyFilter();
  }

  showLessGender(Event genderEvent) {
    if (genderEvent.target.checked)
      genderFilter.add(genderEvent.target.defaultValue);
    else
      genderFilter.remove(genderEvent.target.defaultValue);
    ApplyFilter();
  }

  void ApplyFilter() {
    employees = employeesFull
        .where((x) =>
            genderFilter.contains(x.gender) &&
            departFilter.contains(x.department) &&
            cityFilter.contains(x.address.city))
        .toList();
  }
}
