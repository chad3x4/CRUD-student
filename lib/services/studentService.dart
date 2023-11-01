import 'package:connectdb/db_helper/repository.dart';
import 'package:connectdb/model/Student.dart';

class StudentService
{
  late Repository _repository;
  StudentService(){
    _repository = Repository();
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