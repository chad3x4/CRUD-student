import 'package:connectdb/model/student.dart';
import 'package:flutter/material.dart';

class ViewStudent extends StatefulWidget {
  final Student student;

  const ViewStudent({Key? key, required this.student}) : super(key: key);

  @override
  State<ViewStudent> createState() => _ViewStudentState();
}

class _ViewStudentState extends State<ViewStudent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Xem thông tin"),
        ),
        body: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Thông tin chi tiết",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.blueGrey,
                    fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Text('Họ và tên',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.w600)),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text(widget.student.name ?? '', style: const TextStyle(fontSize: 16)),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Text('Địa chỉ',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.w600)),
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(widget.student.addr ?? '', style: const TextStyle(fontSize: 16)),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Text('Lớp',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.w600)),
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(widget.student.curr_class ?? '', style: const TextStyle(fontSize: 16)),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Text('GPA',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.w600)),
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(widget.student.gpa ?? '', style: const TextStyle(fontSize: 16)),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
  }
}