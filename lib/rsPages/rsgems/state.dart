import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';

class RsgemsState {
  final Rx<RSSkModel> chooseProduct = RSSkModel().obs;
  late ConsumeFrom from;
  RxList<RSSkModel> list = <RSSkModel>[].obs;
}
