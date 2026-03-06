import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';
import 'package:rose_say/rsPages/index.dart';

class FollowController extends RSBaseListController<ChaterModel> {
  @override
  Future<void> fetchData() async {
    try {
      final res = await Api.likedList(page, size);
      final newRecords = res?.records ?? [];
      isNoMoreData = newRecords.length < size;
      if (page == 1) dataList.clear();
      dataList.addAll(newRecords);
      emptyType.value = dataList.isEmpty ? EmptyType.noData : null;
    } catch (e) {
      emptyType.value = dataList.isEmpty ? EmptyType.noData : null;
      if (page > 1) page--;
      rethrow;
    }
  }

  @override
  Future<void> onItemTap(ChaterModel session) async {
    RoutePages.pushChat(session.id);
  }

  @override
  Future<void> collect(ChaterModel role) async {
    final id = role.id;
    if (id == null) {
      return;
    }
    RSLoading.show();

    if (role.collect == true) {
      final res = await Api.cancelCollectRole(id);
      if (res) {
        role.collect = false;
        Get.find<RsdiscoverController>().followEvent.value = (
          FollowEvent.unfollow,
          id,
          DateTime.now().millisecondsSinceEpoch,
        );
      }
    } else {
      final res = await Api.collectRole(id);
      if (res) {
        role.collect = true;
        Get.find<RsdiscoverController>().followEvent.value = (
          FollowEvent.follow,
          id,
          DateTime.now().millisecondsSinceEpoch,
        );

        if (!RS.storage.isShowGoodCommentDialog) {
          DialogWidget.showPositiveReview();
          RS.storage.setShowGoodCommentDialog(true);
        }
      }
    }
    await fetchData();
    RSLoading.close();
  }
}
