class Student {
  int? id;
  String? name;
  String? addr;
  String? curr_class;
  String? gpa;

  studentMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id;
    mapping['name'] = name;
    mapping['address'] = addr;
    mapping['class'] = curr_class;
    mapping['gpa'] = gpa;
    return mapping;
  }
}