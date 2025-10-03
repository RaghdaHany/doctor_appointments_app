import 'package:doctor_appointments_app/components/buttons/main_button.dart';
import 'package:doctor_appointments_app/core/constants/app_assets.dart';
import 'package:doctor_appointments_app/core/constants/app_colors.dart';
import 'package:doctor_appointments_app/core/constants/app_strings.dart';
import 'package:doctor_appointments_app/core/extensions/navigation.dart';
import 'package:doctor_appointments_app/core/routers/routes.dart';
import 'package:doctor_appointments_app/core/utils/text_styles.dart';
import 'package:doctor_appointments_app/features/auth/data/models/doctor_data.dart';
import 'package:doctor_appointments_app/features/patient/doctor_profile/widgets/phone_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DoctorProfileDataScreen extends StatefulWidget {
  const DoctorProfileDataScreen({super.key, required this.doctorData});
  final DoctorData doctorData;

  @override
  State<DoctorProfileDataScreen> createState() =>
      _DoctorProfileDataScreenState();
}

class _DoctorProfileDataScreenState extends State<DoctorProfileDataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        foregroundColor: AppColors.primaryColor,
        title: Text(AppStrings.doctorDetails, style: TextStyles.getHeadLine1()),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.primaryColor,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 130,

                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(4, 4),
                      blurRadius: 5,
                      color: AppColors.greyColor.withValues(alpha: .8),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: AppColors.primaryColor,
                            child: CircleAvatar(
                              backgroundColor: AppColors.primaryColor,
                              radius: 38,
                              backgroundImage:
                                  (widget.doctorData.image != null)
                                      ? NetworkImage(widget.doctorData.image!)
                                      : const AssetImage(
                                        AppAssets.userImageSvg,
                                      ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Dr. ${widget.doctorData.name ?? ''}",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyles.getHeadLine1(fontSize: 18),
                                ),
                                Text(
                                  widget.doctorData.specialization ?? '',
                                  style: TextStyles.getBody(),
                                ),
                                const SizedBox(height: 10),

                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.location_on_outlined, size: 15),
                                    Expanded(
                                      child: Text(
                                        widget.doctorData.address ?? '',
                                        style: TextStyles.getSmall(),
                                        maxLines: 2,
                                        overflow:
                                            TextOverflow
                                                .ellipsis, // Truncates with ..
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              Text(AppStrings.aboutMe, style: TextStyles.getHeadLine1(fontSize: 19)),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.doctorData.bio ?? '',
                      style: TextStyles.getBody(),
                      maxLines: 5,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              Text(
                AppStrings.workingHoursText,
                style: TextStyles.getHeadLine1(fontSize: 18),
              ),
              const SizedBox(height: 10),

              Row(
                children: [
                  Icon(Icons.timer_outlined),
                  Gap(10),

                  Text(
                    '${widget.doctorData.openHour} - ${widget.doctorData.closeHour}',
                    style: TextStyles.getBody(),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              Text(AppStrings.contactingInfo, style: TextStyles.getHeadLine1(fontSize: 18)),

              PhoneWidget(phone: widget.doctorData.phone1!),

              if(widget.doctorData.phone2 != '')
              PhoneWidget(phone: widget.doctorData.phone2!)
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: MainButton(
            text: AppStrings.bookNow,
            onPressed: () {
              context.pushWithExtra(Routes.bookAppointmentRoute, extra: widget.doctorData);
            },
          ),
        ),
      ),
    );
  }
}
