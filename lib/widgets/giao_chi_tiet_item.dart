import 'package:flutter/material.dart';
import 'package:flutter_aba_delivery_app_getx/constants/text_content.dart';
import 'package:flutter_aba_delivery_app_getx/controllers/giao_chi_tiet_controller.dart';
import 'package:get/get.dart';

import '../widgets/btn_cong_tru.dart';

class GiaoChiTietItem extends StatelessWidget {
  final String itemName, divUnit;
  final int soBich, mIndex;
  final bool isChecked;
  final Function onChangedValue;

  const GiaoChiTietItem({
    Key? key,
    required this.itemName,
    required this.divUnit,
    required this.soBich,
    required this.mIndex,
    required this.isChecked,
    required this.onChangedValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GiaoChiTietController giaoChiTietController =
        Get.find<GiaoChiTietController>();

    const mTextStyle = TextStyle(
      color: Colors.blueGrey,
      fontWeight: FontWeight.w600,
    );

    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.orange),
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      margin: const EdgeInsets.all(8),
      child: Obx(
        () => GestureDetector(
          onTap: () {
            giaoChiTietController.phieuGiaoHangList[mIndex - 1].isShowDetail =
                !giaoChiTietController
                    .phieuGiaoHangList[mIndex - 1].isShowDetail;

            giaoChiTietController.phieuGiaoHangList.refresh();
          },
          child: ListTile(
            title: Text(
              '${(mIndex).toString()}. $itemName : $soBich $divUnit',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.blueGrey,
              ),
            ),
            subtitle: giaoChiTietController
                    .phieuGiaoHangList[mIndex - 1].isShowDetail
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${TextContent.maSanPham}${giaoChiTietController.phieuGiaoHangList[mIndex - 1].itemCode}',
                        style: mTextStyle,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        onChanged: (val) {
                          giaoChiTietController
                                .phieuGiaoHangList[mIndex - 1].notes = giaoChiTietController.noteControllers[mIndex - 1].text;
                          giaoChiTietController.phieuGiaoHangList.refresh();
                        },
                        controller: giaoChiTietController.noteControllers[mIndex - 1],
                        decoration: const InputDecoration(
                          labelText: TextContent.ghiChu,
                          prefixIcon: Icon(
                            Icons.edit,
                            color: Colors.blueGrey,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 1),
                          ),
                        ),
                        textInputAction: TextInputAction.done,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${TextContent.SlKho}${giaoChiTietController.phieuGiaoHangList[mIndex - 1].slTuKho.toInt()}',
                              style: mTextStyle,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '${TextContent.SlCH}${giaoChiTietController.phieuGiaoHangList[mIndex - 1].slGiaoCH.toInt()}',
                              style: mTextStyle,
                            ),
                          ),
                        ],
                      ),
                      GetBuilder<GiaoChiTietController>(
                        init: GiaoChiTietController(),
                        builder: (cont) => BtnCongTru(
                          checkBoxValue: giaoChiTietController
                              .phieuGiaoHangList[mIndex - 1].cbThieu,
                          checkBoxTitle: TextContent.thieu,
                          currentValue: giaoChiTietController
                              .phieuGiaoHangList[mIndex - 1].valueCbThieu,
                          onMinus: () {
                            giaoChiTietController.btnTruThieu(mIndex - 1, 1);
                          },
                          onChangedCheckBox: (value) {
                            giaoChiTietController.onChangedCbThieu(
                                mIndex - 1, 1, value);
                          },
                          onPlus: () {
                            giaoChiTietController.btnCongThieu(mIndex - 1, 1);
                          },
                        ),
                      ),
                      GetBuilder<GiaoChiTietController>(
                        init: GiaoChiTietController(),
                        builder: (cont) => BtnCongTru(
                          checkBoxValue: giaoChiTietController
                              .phieuGiaoHangList[mIndex - 1].cbDu,
                          checkBoxTitle: TextContent.du,
                          currentValue: giaoChiTietController
                              .phieuGiaoHangList[mIndex - 1].valueCbDu,
                          onMinus: () {
                            giaoChiTietController.btnTruThieu(mIndex - 1, 2);
                          },
                          onChangedCheckBox: (value) {
                            giaoChiTietController.onChangedCbThieu(
                                mIndex - 1, 2, value);
                          },
                          onPlus: () {
                            giaoChiTietController.btnCongThieu(mIndex - 1, 2);
                          },
                        ),
                      ),
                      GetBuilder<GiaoChiTietController>(
                        init: GiaoChiTietController(),
                        builder: (cont) => BtnCongTru(
                          checkBoxValue: giaoChiTietController
                              .phieuGiaoHangList[mIndex - 1].cbTraVe,
                          checkBoxTitle: TextContent.traVe,
                          currentValue: giaoChiTietController
                              .phieuGiaoHangList[mIndex - 1].valueCbTraVe,
                          onMinus: () {
                            giaoChiTietController.btnTruThieu(mIndex - 1, 3);
                          },
                          onChangedCheckBox: (value) {
                            giaoChiTietController.onChangedCbThieu(
                                mIndex - 1, 3, value);
                          },
                          onPlus: () {
                            giaoChiTietController.btnCongThieu(mIndex - 1, 3);
                          },
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
            trailing: Checkbox(
              checkColor: Colors.white,
              value: isChecked,
              onChanged: (val) {
                onChangedValue();
              },
            ),
          ),
        ),
      ),
    );
  }
}
