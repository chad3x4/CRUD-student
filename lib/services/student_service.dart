import 'package:connectdb/db_utils/operations.dart';
import 'package:connectdb/model/student.dart';

class StudentService
{
  late Operations _repository;
  StudentService(){
    _repository = Operations();
  }
  //Save User
  saveStudent(Student student) async{
    return await _repository.insertData('students', student.studentMap());
  }
  //Read All Users
  readAllStudents() async{
    return await _repository.readData('students');
  }
  //Edit User
  updateStudent(Student student) async{
    return await _repository.updateData('students', student.studentMap());
  }

  deleteStudent(studentId) async {
    return await _repository.deleteDataById('students', studentId);
  }

}