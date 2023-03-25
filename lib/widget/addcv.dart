import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Newcv extends StatefulWidget {
  final Function addcv; //thêm widget

  Newcv(this.addcv);

  @override
  State<Newcv> createState() => _NewcvState();
}

class _NewcvState extends State<Newcv> {
  final tenControl =
      TextEditingController(); //khai báo đối tượng text editing để lưu trữ giá trị người dùng nhập vào
  final motacontrol = TextEditingController();
  final ngaythangcontrol = TextEditingController();
  void submitData() {
    final enten = tenControl.text; //lấy giá trị người dùng nhập vào bằng .text
    final enmota = motacontrol.text;
    final enngaythang = ngaythangcontrol.text;
    if (enten.isEmpty || enmota.isEmpty || enngaythang.isEmpty)
      return; // nếu 1 trong những thuộc tính trống thì ko thực hiện

    widget.addcv(
      enten,
      enmota,
      enngaythang,
    );

    Navigator.of(context)
        .pop(); //khi ấn thêm dữ liệu nó sẽ quay lại màn hình menu
  }

  DateTime currentDate = DateTime.now(); //lấy thời gian hiện tại
  @override
  Widget build(BuildContext context) {
    return Card(
      // cart và các thuộc tính
      elevation: 5, // độ sâu của card

      child: Container(
        height: 700,
        padding: EdgeInsets.all(10), //cách đều các dối tượng
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, //căn giữa
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                  labelText: 'Tên công việc'), //đặt nhãn cho textfile
              controller: tenControl, //kết nối textfile với tencontrol
              onSubmitted: (_) => submitData(), //ấn vào thì thực hiện lệnh
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Mô tả công việc'),
              controller: motacontrol,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration:
                  InputDecoration(labelText: 'Thời hạn hoàn thành(DeadLine)'),
              controller: ngaythangcontrol,
              readOnly: true, //ko hien bàn phím
              onTap: () async {
                // Hiển thị picker ngày tháng năm khi người dùng chọn trường này
                final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: currentDate,
                    firstDate: DateTime(1950),
                    lastDate: DateTime(2050));
                if (pickedDate != null) {
                  // Cập nhật giá trị cho trường ngày tháng năm sinh
                  setState(() {
                    ngaythangcontrol.text =
                        DateFormat('dd/MM/yyyy').format(pickedDate);
                  });
                }
              },
            ),
            TextButton(
              child: Text('Thêm Công việc'),
              onPressed: () {
                submitData();
              },
            ),
          ],
        ),
      ),
    );
  }
}
