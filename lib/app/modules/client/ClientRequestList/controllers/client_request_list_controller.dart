import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pharmix/app/data/models/request.dart';
import 'package:pharmix/app/data/models/request_type.dart';
import 'package:pharmix/app/data/providers/request_provider.dart';

class ClientRequestListController extends GetxController {
  final requestProvider = RequestProvider();
  late final PagingController<int, Request> pagingController;
  RxList<TypeModel> requestStatus = RxList([]);
  Rxn<TypeModel> selectedStatus = Rxn();
  bool _isFetching = false;
  bool _hasLoadedFirstPage = false;
  @override
  void onInit() {
    super.onInit();
    if (requestStatus.isEmpty) {
      loadTRequestTypes();
    }
    _initPagingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void refresh() => pagingController.refresh();

  void loadTRequestTypes() async {
    requestStatus.value = [
      TypeModel(label: "En attente", filter: 'enattent', count: 3),
      TypeModel(label: "Traités", filter: 'traite', count: 8),
      TypeModel(label: "Annulées", filter: 'annule', count: 3)
    ];
    selectedStatus.value = requestStatus.first;
  }

  void updateRequestStatus(TypeModel status) async {
    selectedStatus.value = status;
    _hasLoadedFirstPage = false;
    _isFetching = false;
    pagingController.cancel();
    pagingController.refresh();
  }

  void _initPagingController() {
    pagingController = PagingController<int, Request>(
      getNextPageKey: (state) =>
          state.lastPageIsEmpty ? null : state.nextIntPageKey,
      fetchPage: _fetchPage,
    );
  }

  Future<List<Request>> _fetchPage(int pageKey) async {
    print("arrive ici");
    if (_hasLoadedFirstPage && pageKey == 1) {
      return [];
    }
    if (_isFetching) return [];
    _isFetching = true;
    final newItems = await requestProvider.fetchClientRequests(
        pageKey: pageKey, filter: selectedStatus.value?.filter);
    _isFetching = false;
    _hasLoadedFirstPage = true;
    return newItems;
  }
}
