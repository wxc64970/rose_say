import 'package:rose_say/rsCommon/index.dart';

enum ChatTab { chatted, liked }

class ConversationController extends RSBaseListController<RSConversationModel> {
  @override
  Future<void> fetchData() async {
    try {
      final newRecords = await Api.sessionList(page, size) ?? [];
      // LogUtil.d('Fetched ${newRecords.length} conversations for page $page');

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
  Future<void> onItemTap(RSConversationModel session) async {
    RoutePages.pushChat(session.characterId);
  }

  @override
  Future<void> collect(RSConversationModel item) async {}
}
