//tạo class lưu trữ các trường thông tin;
class Congviec {
  int id;
  final String tencv;
  final String motacv;
  final DateTime deadline;

  Congviec({
    required this.id, //required là bắt buộc phải truyền tham số ;
    required this.tencv,
    required this.motacv,
    required this.deadline,
  });
}
