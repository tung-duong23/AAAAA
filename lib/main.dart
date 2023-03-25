import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'widget/dscongviec.dart';
import 'widget/addcv.dart';
import 'model/congviec.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      //tắt chữ debug
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

final dateFormat = DateFormat('dd/MM/yyyy'); //ép kiểu cho ngày tháng

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _searchController =
      TextEditingController(); //khai báo đối search
  List<Congviec> _filteredCongViec = [];
  final List<Congviec> danhSachCongviec = [
    Congviec(
      id: 1,
      tencv: 'Dự án Website ứng dụng trực tuyến',
      motacv: 'Hoàn thành 90%',
      deadline: dateFormat.parse('24/06/2023'), // ép kiểu
    ),
    Congviec(
      id: 2,
      tencv: 'Dự án phàn mềm quản lí khách sạn',
      motacv: 'Hoàn thành 70%',
      deadline: dateFormat.parse('24/02/2023'),
    ),
    Congviec(
      id:3,
      tencv: 'Dự án Blockchain eth',
      motacv: 'Hoàn thành 50%',
      deadline: dateFormat.parse('25/4/2023'),
    ),
  ];

  @override
  void initState() {
    //sao chép hết nội dung của danh sách cv
    _filteredCongViec.addAll(danhSachCongviec);
    super.initState(); //gọi
  }

  @override
  void dispose() {
    // được sử dụng để giải phóng tài nguyên của _searchController
    _searchController.dispose();
    super.dispose();
  }

  void _filterCongViec(String query) {
    List<Congviec> filteredCongViec = []; //copy
    filteredCongViec.addAll(danhSachCongviec);

    if (query.isNotEmpty) {
      //nếu query không rỗng
      filteredCongViec.retainWhere((congViec) => //duyệt từng phần tử
          congViec.tencv.toLowerCase().contains(query
              .toLowerCase())); //chuyển về chữ thường duyệt phần tử xem có giống query
    }

    setState(() {
      _filteredCongViec.clear(); //xóa hết các phần tử cũ
      _filteredCongViec.addAll(filteredCongViec); //copy tất cả
    });
  }

  void addNewCongviec(
      String tencv, String motacv, String deadline) //thêm phần tử
  {
    final dateFormat = DateFormat('dd/MM/yyyy');
    final newCongviec = Congviec(
      id: danhSachCongviec.length + 1,
      tencv: tencv,
      motacv: motacv,
      deadline: dateFormat.parse(deadline),
    );
    setState(() {
      danhSachCongviec.add(newCongviec);
      _filteredCongViec.add(newCongviec);
    });
  }

  void deleteCongViec(int index) {
    setState(() {
      danhSachCongviec.removeAt(index); //xóa id
      _filteredCongViec.removeAt(index);
      for (int i = index; i < danhSachCongviec.length; i++) {
        //giảm id mỗi cái sau vị trí đi 1
        danhSachCongviec[i].id--;
      }
    });
  }

  void startAddNewCongviec(BuildContext context) {
    showModalBottomSheet(
      //cửa sổ hiển thị từ dưới lên hiển thị chỗ nhập dữ liệu
      context: context,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: Newcv(addNewCongviec),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 226, 226, 226),
      //thanh tiêu đề
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        title: Row(
          mainAxisAlignment:
              //căn chỉnh các đối tượng
              MainAxisAlignment.spaceBetween,
          children: [
            //căn chỉnh text
            Expanded(
              child: Text(
                'MY TASKS',
                textAlign: TextAlign.center,
              ),
            ),
            //cotainer chứa ảnh
            Container(
              height: 50,
              width: 50,
              child: ClipRRect(
                //bo góc của ảnh
                borderRadius: BorderRadius.circular(30),
                child: Image.asset('assets/images/mc.jpg'),
              ),
            ),
          ],
        ),
      ),
      //nút drawer
      drawer: Drawer(
        //thanh chức năng
        child: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 70,
                child: DrawerHeader(
                  child: Container(
                    child: Text(
                      'WORK LIST',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(Size(400, 50)),
                ),
                child: Text("Danh sách công việc chưa đến hạn"),
                onPressed: () {
                  setState(() {
                    // Kết quả của phương thức where là một Iterable chứa các phần tử của danh sách danhSachCongviec thỏa mãn điều kiện trên.Cuối cùng, phương thức toList() được gọi để chuyển đổi Iterable sang List
                    _filteredCongViec = danhSachCongviec
                        .where((congViec) =>
                            congViec.deadline.isAfter(DateTime.now()))
                        .toList();
                  });
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(Size(400, 50)),
                ),
                child: Text("Danh sách công việc đã quá deadline"),
                onPressed: () {
                  setState(() {
                    _filteredCongViec = danhSachCongviec
                        .where((congViec) =>
                            congViec.deadline.isBefore(DateTime.now()))
                        .toList();
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),

      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: "Tìm kiếm công việc",
                hintText: "Nhập từ khóa...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
              onChanged: (value) {
                //. Khi người dùng nhập hoặc thay đổi dữ liệu trong Textfield, hàm _filterCongViec(value) sẽ được gọi với giá trị mới của Textfield là tham số đầu vào.
                _filterCongViec(value);
              },
            ),
          ),
          Expanded(
            //tự điều chỉnh kích cỡ
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  CongViecList(_filteredCongViec, deleteCongViec),
                ],
              ),
            ),
          ),
        ],
      ),
      //nút thêm dữ liệu
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat, //căn giữa
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => startAddNewCongviec(context),
      ),
    );
  }
}
