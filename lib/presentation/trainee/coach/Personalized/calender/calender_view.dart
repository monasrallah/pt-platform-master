import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pt_platform/presentation/trainee/coach/Personalized/calender/getx/calender_controller.dart';
import 'package:pt_platform/presentation/widgets/buttons/custom_elevated_button.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel, EventList;

import '../../../../../resources/color_manager.dart';
import '../../../../../resources/strings_manager.dart';
import '../../../../widgets/buttons/app_back_bar.dart';
import '../../../main_bottom_navigation_bar/main_bottom_navigation_bar.dart';
import '../../getx/coach_controller.dart';

class CalenderView extends GetView<CalenderController> {
  CalenderView({Key? key}) : super(key: key);

//  List<DateTime> _markedDate = [DateTime(2018, 9, 20), DateTime(2018, 10, 11)];
  static final Widget _eventIcon = Container(
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(1000)),
        border: Border.all(color: Colors.blue, width: 2.0)),
    child: const Icon(
      Icons.person,
      color: Colors.amber,
    ),
  );

  final EventList<Event> _markedDateMap = EventList<Event>(
    events: {
      DateTime(2019, 2, 10): [
        Event(
          date: DateTime(2019, 2, 10),
          title: 'Event 1',
          icon: _eventIcon,
          dot: Container(
            margin: const EdgeInsets.symmetric(horizontal: 1.0),
            color: Colors.red,
            height: 5.0,
            width: 5.0,
          ),
        ),
        Event(
          date: DateTime(2019, 2, 10),
          title: 'Event 2',
          icon: _eventIcon,
        ),
        Event(
          date: DateTime(2019, 2, 10),
          title: 'Event 3',
          icon: _eventIcon,
        ),
      ],
    },
  );

  @override
  Widget build(BuildContext context) {
    return MainBottomNavigationBar(
      appBarWidget: appBackBar(title: AppStrings.calendar.tr),
      bodyWidget: buildBody(),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.only(start: 40.w, top: 20.h),
            child: Row(
              children: [
                SizedBox(
                  height: 70.h,
                  width: 70.h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100.r),
                    child: Image.network(
                        Get.find<CoachController>().coachAvatar.value),
                  ),
                ),
                20.horizontalSpace,
                Obx(
                  () => Text(
                    "${Get.find<CoachController>().coachName.value} ${AppStrings.availability.tr}",
                    style: Get.textTheme.bodySmall!.copyWith(fontSize: 20.sp),
                  ),
                ),
              ],
            ),
          ),
          buildCalender(),
          // 20.verticalSpace,
          buildAvailableTimes(),
          50.verticalSpace,
          Obx(
            () => !controller.timeSelected.value
                ? const SizedBox.shrink()
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: CustomElevatedButton(
                      title: AppStrings.confirm.tr,
                      onTap: () {
                        controller.addCoachCalendar();
                      },
                    ),
                  ),
          ),
          20.verticalSpace,
        ],
      ),
    );
  }

  Widget buildCalender() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Obx(
        () => CalendarCarousel(
          onDayPressed: (DateTime date, List<Event> events) async {
            // this.setState(() => _currentDate = date);
            controller.currentDate = date;
            await controller.getCoachCalendar();
          },
          showOnlyCurrentMonthDate: true,
          onRightArrowPressed: () {},
          daysTextStyle: Get.textTheme.bodySmall,
          todayButtonColor: Colors.transparent,
          weekendTextStyle: Get.textTheme.bodySmall,
          minSelectedDate: DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day),
          // maxSelectedDate: DateTime(2019),
          // targetDateTime:  DateTime.now(),
          headerTextStyle: Get.textTheme.bodyMedium,
          iconColor: ColorManager.primary,
          thisMonthDayBorderColor: Colors.transparent,
          // leftButtonIcon: Container(),
          isScrollable: true,
          //  weekDays: null, /// for pass null when you do not want to render weekDays
          //  headerText: Container( /// Example for rendering custom header
          //    child: Text('Custom Header'),
          //  ),
          customDayBuilder: (
            /// you can provide your own build function to make custom day containers
            bool isSelectable,
            int index,
            bool isSelectedDay,
            bool isToday,
            bool isPrevMonthDay,
            TextStyle textStyle,
            bool isNextMonthDay,
            bool isThisMonthDay,
            DateTime day,
          ) {
            /// If you return null, [CalendarCarousel] will build container for current [day] with default function.
            /// This way you can build custom containers for specific days only, leaving rest as default.

            // Example: every 15th of month, we have a flight, we can place an icon in the container like that:
            // if (day.day == 15) {
            //   return const Center(
            //     child: Icon(Icons.local_airport),
            //   );
            // } else {
            //   return null;
            // }
            if (!day.isAfter(DateTime.now()) && !isToday) {
              return Container();
            } else {
              return null;
            }
          },
          weekFormat: false,
          markedDatesMap: _markedDateMap,
          height: 420.0,
          selectedDateTime: controller.currentDate,
          daysHaveCircularBorder: true,

          /// null for not rendering any border, true for circular border, false for rectangular border
        ),
      ),
    );
  }

  Widget buildAvailableTimes() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.availableTimes.tr,
            style: Get.textTheme.bodyMedium,
          ),
          Obx(
            () => controller.isLoading
                ? SizedBox(
                    width: 1.sw,
                    height: 0.15.sh,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                      ],
                    ),
                  )
                : controller.calenders.isEmpty
                    ? SizedBox(
                        height: 0.1.sh,
                        width: 1.sw,
                        child: Center(
                          child: Text(
                            AppStrings.noAvailableTimes.tr,
                            textAlign: TextAlign.center,
                            style: Get.textTheme.bodyMedium,
                          ),
                        ),
                      )
                    : SizedBox(
                        height: 0.1.sh,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: controller.calenders.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Obx(
                              () => Container(
                                width: 0.4.sw,
                                padding: EdgeInsets.symmetric(
                                    vertical: 20.h, horizontal: 15.w),
                                child: InkWell(
                                  onTap: controller.calenders[index].isAvailable
                                      ? () {
                                          controller.timeSelected.value = true;
                                          controller.coachName.value =
                                              controller.coachName.value;
                                          controller.selectedTime.value =
                                              controller.calenders[index].time;
                                          controller.timeIdSelected.value =
                                              controller.calenders[index].id;
                                        }
                                      : null,
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: controller
                                                        .timeIdSelected.value ==
                                                    controller
                                                        .calenders[index].id &&
                                                controller.calenders[index]
                                                    .isAvailable &&
                                                controller.timeSelected.value
                                            ? ColorManager.primary
                                            : Colors.transparent,
                                        border: Border.all(
                                            color: controller.calenders[index]
                                                    .isAvailable
                                                ? ColorManager.primary
                                                : ColorManager.lightRed)),
                                    child:
                                        Text(controller.calenders[index].time),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}
