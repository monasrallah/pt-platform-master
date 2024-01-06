import 'package:get/get.dart';
import 'package:pt_platform/app/extensions.dart';
import 'package:pt_platform/domain/entities/home_entities/news_entity.dart';

import '../../../../../app/dependency_injection.dart';
import '../../../../../data/home/home_repo/home_repository.dart';
import '../../../../widgets/toasts_messages.dart';

class NewsController extends GetxController {
  BaseHomeRepository baseHomeRepository = instance();

  List<NewsEntity> news = [];

  final RxBool _isLoading = false.obs;

  set isLoading(bool val) => _isLoading.value = val;

  bool get isLoading => _isLoading.value;

  getNews() async {
    isLoading = true;
    (await baseHomeRepository.news()).fold(
        (failure) => showFlutterToast(message: failure.message.orEmpty()),
        (List<NewsEntity> data) => {news = data});
    isLoading = false;
  }

  @override
  void onInit() async {
    await getNews();
    super.onInit();
  }
}
