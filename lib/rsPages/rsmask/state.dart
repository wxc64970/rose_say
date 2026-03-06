import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';

class RsmaskState {
  final RxList<RSMaskModel> maskList = <RSMaskModel>[].obs;
  final Rx<RSMaskModel?> selectedMask = Rx<RSMaskModel?>(null);
  final RxBool hasMore = true.obs;
  final RxInt currentPage = 1.obs;
  final RxBool isLoading = false.obs;
  final Rx<EmptyType?> emptyType = Rx<EmptyType?>(null);
}
