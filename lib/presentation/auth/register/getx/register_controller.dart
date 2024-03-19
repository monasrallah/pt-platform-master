import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pt_platform/app/extensions.dart';
import 'package:pt_platform/domain/entities/auth_entities/auth_entity.dart';
import 'package:pt_platform/domain/entities/auth_entities/category_entity.dart';
import 'package:pt_platform/providers/notifications_provider.dart';

import '../../../../app/app_controller.dart';
import '../../../../app/dependency_injection.dart';
import '../../../../app/functions.dart';
import '../../../../app/storage/app_prefs.dart';
import '../../../../data/auth/auth_repo/auth_repository.dart';
import '../../../../domain/parameters/auth_parameter/device_params.dart';
import '../../../../domain/parameters/auth_parameter/register_params.dart';
import '../../../../resources/local_messages_strings_manager.dart';
import '../../../widgets/toasts_messages.dart';

class RegisterController extends GetxController {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController socialMediaLink = TextEditingController();
  TextEditingController potentialClients = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController category = TextEditingController();

  final RxBool isPasswordVisible = false.obs;
  final RxBool isConfirmPasswordVisible = false.obs;
  final RxBool _isLoading = false.obs;
  final RxBool _isCategoryLoading = false.obs;
  final RxBool isPasswordValid = true.obs;
  final RxBool isFirstNameValid = true.obs;
  final RxBool isLastNameValid = true.obs;
  final RxBool isConfirmPasswordValid = true.obs;
  final RxBool isEmailValid = true.obs;
  final RxBool isMobileValid = true.obs;
  final RxBool isSocialMediaLinkValid = true.obs;
  final RxBool isPotentialClientsValid = true.obs;
  final RxBool _rememberMe = false.obs;
  final RxString _countryCode = "".obs;

  final RxList<String> categories = <String>[].obs;

  RxList<int> categoriesId = <int>[].obs;

  String get countryCode => _countryCode.value;

  set countryCode(String value) {
    _countryCode.value = value;
  }

  set isCategoryLoading(bool val) => _isCategoryLoading.value = val;

  bool get isCategoryLoading => _isCategoryLoading.value;

  set isLoading(bool val) => _isLoading.value = val;

  bool get isLoading => _isLoading.value;

  bool isAllTraineeValid() {
    isFirstNameValid.value = firstName.text.isNotEmpty;
    isLastNameValid.value = lastName.text.isNotEmpty;

    _passwordValid();
    _confirmPasswordValid();
    return (isFirstNameValid.value &&
        isLastNameValid.value &&
        _passwordValid() &&
        _confirmPasswordValid());
  }

  bool isAllCoachValid() {
    isFirstNameValid.value = firstName.text.isNotEmpty;
    isLastNameValid.value = lastName.text.isNotEmpty;
    isMobileValid.value = mobile.text.isNotEmpty;
    isSocialMediaLinkValid.value = socialMediaLink.text.isNotEmpty;
    isPotentialClientsValid.value = potentialClients.text.isNotEmpty;
    _passwordValid();
    _confirmPasswordValid();
    return (isFirstNameValid.value &&
        isLastNameValid.value &&
        isMobileValid.value &&
        isSocialMediaLinkValid.value &&
        isPotentialClientsValid.value &&
        _passwordValid() &&
        _confirmPasswordValid());
  }

  bool _checkEmailValid() {
    isEmailValid.value =
        (email.text.length > 2 && checkEmailValidity(email.text));
    return isEmailValid.value;
  }

  bool _passwordValid() {
    isPasswordValid.value =
        (password.text.length > 7 && checkPasswordValidity(password.text));
    return isPasswordValid.value;
  }

  bool _confirmPasswordValid() {
    isConfirmPasswordValid.value = confirmPassword.text == password.text;
    return isPasswordValid.value;
  }

  String? fcmToken;

  getFcmToken() async {
    return await instance<AppPreferences>().getFcmToken();
  }

  getCategoryString(List<CategoryEntity> data) {
    data.map((e) => categories.add(e.name)).toList();
  }

  getCategoryId(List<CategoryEntity> data) {
    data.map((e) => categoriesId.add(e.id)).toList();
  }

  getCategory() async {
    final BaseAuthRepository authRepository = instance();

    isCategoryLoading = true;
    (await authRepository.getAllCategories())
        .fold((failure) => showFlutterToast(message: failure.message.orEmpty()),
            (List<CategoryEntity> data) {
      getCategoryString(data);
      getCategoryId(data);
      return;
    });
    isCategoryLoading = false;
  }

  register() async {
    final BaseAuthRepository authRepository = instance();
    fcmToken = await getFcmToken();
    isLoading = true;
    if (userType.value == "Trainee") {
      print("Trainee");
      if (isAllTraineeValid()) {
        (await authRepository.registerTrainee(RegisterTraineeParams(
                token: token.value,
                firstName: firstName.text,
                lastName: lastName.text,
                password: password.text,
                confirmPassword: confirmPassword.text,
                device: DeviceParams(
                    playerId:
                        Get.find<NotificationsProvider>().userNotificationToken,
                    platform: platform(),
                    timezone: Get.find<AppController>().timeZone,
                    appVersion: Get.find<AppController>().version))))
            .fold(
                (failure) =>
                    showFlutterToast(message: failure.message.orEmpty()),
                (data) => Get.find<AppController>().onItemTapped(0));
      } else {
        showFlutterToast(
            message:
                AppLocalMessagesStringsManager().requiredFieldsMustNotBeEmpty);
      }
    } else {
      print("Coach");
      if (isAllCoachValid()) {
        (await authRepository.registerCoach(RegisterCoachParams(
                token: token.value,
                firstName: firstName.text,
                lastName: lastName.text,
                mobile: mobile.text,
                categories: categoriesId,
                password: password.text,
                confirmPassword: confirmPassword.text,
                socialMediaLink: socialMediaLink.text,
                potentialTrainees: potentialClients.text,
                device: DeviceParams(
                    playerId:
                        Get.find<NotificationsProvider>().userNotificationToken,
                    platform: platform(),
                    timezone: Get.find<AppController>().timeZone,
                    appVersion: Get.find<AppController>().version))))
            .fold(
                (failure) =>
                    showFlutterToast(message: failure.message.orEmpty()),
                (AuthCoachEntity data) =>
                    showFlutterToast(message: "منوافقلك بعدين"));
        // Get.offAllNamed(Routes.coachHomeRoute);
      } else {
        showFlutterToast(
            message:
                AppLocalMessagesStringsManager().requiredFieldsMustNotBeEmpty);
      }
    }
    isLoading = false;
  }

  bool get rememberMe => _rememberMe.value;

  set rememberMe(bool value) {
    _rememberMe.value = value;
  }

  onPressRememberMe() {
    rememberMe = !rememberMe;
  }

  RxString userType = "".obs;
  RxString token = "".obs;

  @override
  onInit() async {
    super.onInit();
    await getCategory();
    userType.value = Get.arguments[0];
    token.value = Get.arguments[1];

    firstName.addListener(() {
      isFirstNameValid.value = firstName.text.isNotEmpty;
    });
    lastName.addListener(() {
      isLastNameValid.value = lastName.text.isNotEmpty;
    });
    password.addListener(() {
      _passwordValid();
    });
    email.addListener(() {
      _checkEmailValid();
    });
  }
}
