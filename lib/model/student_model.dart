class Classes {
  int? id;
  String? className;
  Classes({this.id, this.className});
  Classes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    className = json['class'];
  }
}

class Students {
  String? studentName;
  Students({this.studentName});
  factory Students.fromJson(Map<String, dynamic> json) {
    return Students(studentName: json['student']??'');
  }
}
