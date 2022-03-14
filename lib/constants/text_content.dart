import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextContent {
  static const String username = 'Tên đăng nhập';
  static const String password = 'Mật khẩu';
  static const String validateUsername = 'Tên đăng nhập không được bỏ trống.';
  static const String validatePassword = 'Mật khẩu không được bỏ trống.';
  static const String validateSignIn = 'Sai tên đăng nhập hoặc mật khẩu.';
  static const String internetErrorTitle = 'Lỗi kết nối';
  static const String internetError = 'Vui lòng kiểm tra lại Internet.';
  static const String errorResponseFail =
      'vui lòng kiểm tra lại thông tin hoặc thử lại sau ít phút.';
  static const String titleAuthScreen = 'Đăng nhập hệ thống';
  static const String titleHomeScreen = 'Trang chính';
  static const String titleGiaoChiTietScreen = 'Đơn hàng vận chuyển';
  static const String titleProblemScreen = 'Báo cáo vấn đề';
  static const String titleLddScreen = 'Lệnh điều động';
  static const String titleChuyenXeScreen = 'Chuyến xe';
  static const String titleChangePassword = 'Đổi mật khẩu';
  static const String addressLine = 'Địa chỉ : ';
  static const String phoneNumber = 'Số điện thoại : ';
  static const String totalCarton = 'Số thùng : ';
  static const String btnDaToi = 'Đã tới';
  static const String btnSuCo = 'Sự cố';
  static const String btnGiaoChiTiet = 'Giao chi tiết';
  static const String btnSaiLechHang = 'Sai lệch hàng';
  static const String btnNguoiNhan = 'Người nhận';
  static const String btnGiaoThung = 'Giao thùng';
  static const String btnGiaoHub = 'Giao biker(Hub)';
  static const String titleNVGN = 'Nhân viên giao nhận';

  // Change Password
  static const String validateOldPassword = 'Mật khẩu củ không được bỏ trống.';
  static const String validateNewPassword = 'Mật khẩu mới không được bỏ trống.';
  static const String validateConfirmNewPassword =
      'Xác nhận mật khẩu mới\nkhông được bỏ trống.';
  static const String validateConfirmNewPassword1 =
      'Xác nhận mật khẩu mới\n phải khớp với mật khẩu mới.';

  // Change Pasword
  static const String btnDaNhan = 'Đã nhận';
  static const String btnDangCho = 'Đang chờ';
  static const String titleNoShipment = 'Hiện tại đang không chuyến đang chờ.';
  static const String titleNoShipment1 = 'Hiện tại đang không chuyến đã nhận.';
  static const String btnTuChoi = 'Từ chối';
  static const String btnNhanChuyen = 'Nhận chuyến';
  static const String btnBatDau = 'Bắt đầu';
  static const String btnCheckStop = 'Kiểm tra điểm giao';
  static const String errorWhenStartShipment =
      'Hiện tại bạn đang có chuyến, không thể nhận thêm chuyến mới.';
  static const String attachImage = 'Vui lòng đính kèm ít nhất một hình (*)';

  // GetX Snackbar
  static void getXSnackBar(String title, String message, bool isDismiss) {
    Get.showSnackbar(GetSnackBar(
      duration: 2.seconds,
      titleText: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      message: message,
      isDismissible: isDismiss,
      snackPosition: SnackPosition.BOTTOM,
    ));
  }

  // GetX Snackbar
  static const String btnDenKho = 'Đến\nkho';
  static const String btnDenHub = 'Đến\nhub';
  static const String btnLayHang = 'Lấy\nhàng';
  static const String btnLayXong = 'Lấy\nxong';
  static const String btnRoiKho = 'Rời\nkho';

  static const String titleWarningDaToi = 'Lưu ý';
  static const String waringDaToi =
      'Hệ thống ghi nhận bạn giao hàng không đúng giờ. Lưu ý nhập app theo thời gian thực tế cho lần giao sau!';
  static const String noShipment = 'Hiện tại bạn chưa có chuyến.';
  static const String vuiLongBamDaToi = 'Vui lòng bấm "Đã tới"';
  static const String ghiChu = 'Ghi chú';
  static const String btnSendReport = 'Gửi báo cáo';
  static const String tenNguoiNhan = 'Tên người nhận';
  static const String sdtNguoiNhan = 'SĐT người nhận';
  static const String titleLichSuGiaoHang = 'Lịch sử giao hàng';
  static const String titleChungTu = 'Chứng từ';
  static const String titlePhi = 'Phí';
  static const String titleGiaoBu = 'Giao bù';
  static const String btnDeNghi1 = 'Đề nghị tạm ứng';
  static const String btnDeNghi2 = 'Đề nghị thanh toán';
  static const String btnGopY = 'Góp ý';
  static const String thieu = 'Thiếu';
  static const String du = 'Dư';
  static const String traVe = 'Trả về';
  static const String hong = 'Hỏng';
  static const String nhietDoKem = 'Nhiệt độ kém';
  static const String SlKho = 'SL từ kho : ';
  static const String SlCH = 'SL giao CH : ';
  static const String maSanPham = 'Mã sản phẩm : ';
  static const String btnXacNhanKhayRo = 'Xác nhận đã giao / nhận từ CH';
  static const String historyTab = 'Lịch sử';
  static const String deliveryTab = 'Đã giao';
  static const String tamTinh = 'Tạm tính : ';
  static const String rightTime = 'Đúng giờ';
  static const String notRightTime = 'Trể giờ';
  static const String duKien = 'Dự kiến:';
  static const String hoanThanh = 'Hoàn thành:';
  static const String total = 'Tổng';
  static const String noLdd = 'Hiện tại bạn chưa có lệnh điều động.';
  static const String imageUrl =
      'https://apideli.aba.com.vn:44567/Attachments3/';
  static const String noFeedback = 'Hiện tại bạn không có góp ý nào.';
  static const String radioBtn = 'Chứng từ, chuyến xe';
  static const String radioBtn1 = 'Khác';
  static const String createNewPaymentOrder = 'Tạo mới đề nghị thanh toán';
  static const String paymentOrderNote =
      '(*) Lưu ý: phí nhiên liệu, phí cầu đường, phí kiểm dịch, Phí vá võ, vá xe thì mới cần hình ảnh, còn lại có thể không cần.';
  static const String paymentOrderPickShipment =
      'Chọn chuyến cần đề nghị thanh toán';
  static const String paymentOrderPickFeeType =
      'Chọn loại phí cần đề nghị thanh toán';
  static const String paymentOrderAmount = 'Số tiền cần thanh toán';
  static const String note = 'Ghi chú (nếu có)';
  static const String warningFee =
      'Vui lòng chụp ít nhất một hình đối với PHÍ NHIÊN LIỆU, PHÍ CẦU ĐƯỜNG,PHÍ KIỂM TRA,PHÍ VÁ VỎ, SỬA XE';
  static const String warningFee1 =
      'Vui lòng nhập ghi chú đối với phí Khác, phí Ngoài và phí gửi xe';
  static const String warningFee2 =
      'Số tiền tạm ứng không được để trống hoặc nhỏ hơn 500';
  static const String noImageFound = 'Không có hình ảnh để hiển thị.';
  static const String btnClose = 'Đóng';
  static const String title = 'Tiêu đề: ';
  static const String content = 'Nội dung: ';
  static const String totalRemain = 'Tổng còn lại: ';
  static const String totalShipment = 'Tổng chuyến: ';
  static const String btnShowImage = 'Hiển thị hình ảnh';
  static const String textNone = 'Không có';
  static const String btnConfirm = 'Đồng ý';
  static const String titleGas = 'Yêu cầu cấp dầu';
}
