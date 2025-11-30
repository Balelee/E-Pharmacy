import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pharmix/app/data/models/request.dart';
import 'package:pharmix/app/data/models/request_type.dart';
import 'package:pharmix/app/data/providers/request_provider.dart';
import 'package:pharmix/app/utils/helpers/dialog_helper.dart';

class ClientRequestListController extends GetxController {
  final requestProvider = RequestProvider();
  late final PagingController<int, Request> pagingController;
  RxList<TypeModel> requestStatus = RxList([]);
  Rxn<TypeModel> selectedStatus = Rxn();
  bool _isFetching = false;
  bool _hasLoadedFirstPage = false;
  RxString sucessMessage = RxString('');
  @override
  void onInit() {
    super.onInit();

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

  Future<void> loadTRequestTypes() async {
    requestStatus.value = await requestProvider.loadRequestStatus();
    selectedStatus.value = requestStatus.first;
  }

  void updateRequestStatus(TypeModel status) async {
    selectedStatus.value = status;
    _refreshPagination();
  }

  void _refreshPagination() {
    _hasLoadedFirstPage = false;
    _isFetching = false;
    pagingController.cancel();
    pagingController.refresh();
  }

  void _initPagingController() {

    pagingController = PagingController<int, Request>(
      getNextPageKey: (state)  {
        
        final totalLoaded = state.items?.length ?? 0;
        if (totalLoaded == 0) return 1;
        if (totalLoaded % 10 != 0) return null;
        return state.nextIntPageKey;
      },
      fetchPage: _fetchPage,
    );
  }

  Future<List<Request>> _fetchPage(int pageKey) async {
    if (requestStatus.isEmpty) {
      await loadTRequestTypes();
    }
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

  Future<void> cancelRequest({required String requestId}) async {
    bool? isCanceled = await DialogHelper.showConfirmationDialog(
      title: "Confirmation",
      message: "Voullez-vous vraiment annuler cette requette?",
      onConfirm: () {},
    );

    if (isCanceled != null && isCanceled == true) {
      await requestProvider
          .cancelRequest(
        requestId: requestId,
        message: (value) {
          sucessMessage.value = value;
        },
      )
          .whenComplete(() {
        _refreshPagination();
      });
    }
  }
}
