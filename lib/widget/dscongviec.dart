import 'package:b/model/congviec.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/model/congviec.dart';
import 'package:b/main.dart';

class CongViecList extends StatefulWidget {
  final List<Congviec> danhSachCongviec;
  final Function(int) onDelete;
  CongViecList(this.danhSachCongviec, this.onDelete);
  @override
  _CongViecListState createState() => _CongViecListState();
}

class _CongViecListState extends State<CongViecList> {
  //hàm trả về gtri true khi thời gian truyền vào đã quá ngày so với thời gian hiện tại
  bool isOverdue(DateTime date) {
    DateTime now = DateTime.now();
    return date.isBefore(now);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 550,
      child: SingleChildScrollView(
        //cuộn
        child: Column(
          children: widget.danhSachCongviec.map((cv) {
            //ánh xạ map
            int index = widget.danhSachCongviec.indexOf(cv); //ĩndex
            Color tileColor =
                isOverdue(cv.deadline) ? Colors.red : Colors.lightBlue; //chọn màu
            return Container(
              //giãn cách giữa các công việc
              padding:
                  EdgeInsets.symmetric(horizontal: 16.0), //giãn hai bên sườn
              margin: EdgeInsets.only(bottom: 10), //giãn dưới
              child: ListTile(
                shape: RoundedRectangleBorder(
                    // hình vuông
                    borderRadius: BorderRadius.circular(20)), //bo góc hình tròn
                tileColor: tileColor, //màu
                contentPadding: EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 12), //khoảng cách theo chiều dọc và nagng
                leading: Container(
                  // ô chứa id
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        50), // đặt bán kính là 0 để tạo hình vuông
                    border: Border.all(
                      color: Colors.black,
                      width: 3,
                    ),
                  ),
                  alignment: Alignment
                      .center, // đặt giá trị alignment thành Alignment.center để đưa Text vào giữa
                  width: 40, // đặt chiều rộng là 50 để tạo hình vuông
                  height: 40,
                  child: Text(
                    cv.id.toStringAsFixed(0), //số số sau dấu.
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ),
                title: Text(
                  cv.tencv,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'Mô tả:' +
                      cv.motacv +
                      '\n' +
                      "Deadline: " +
                      DateFormat('dd/MM/yyyy').format(cv.deadline),
                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.yellow,
                      fontWeight: FontWeight.bold),
                ),
                trailing: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(0), //cách đều
                  margin: EdgeInsets.symmetric(vertical: 6),
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: IconButton(
                    //icon thùng rác
                    color: Colors.white,
                    iconSize: 18,
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      widget.onDelete(index);
                    },
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
