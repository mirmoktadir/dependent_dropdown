import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import '../../../../config/theme/my_fonts.dart';
import '../../../data/models/branch_model.dart';
import '../../../data/models/department_by_branch.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('HomeView'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 1st dropdown
              Text(
                "Branch",
                style: TextStyle(
                  fontSize: MyFonts.headline6TextSize,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 55.h,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: theme.hintColor.withOpacity(.5),
                  ),
                ),
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButtonHideUnderline(
                    child: Obx(() => DropdownButton<BranchData>(
                          hint: Text(
                            "--Select Branch--",
                            style: TextStyle(
                              color: theme.hintColor,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          isExpanded: true,
                          menuMaxHeight: 215.h,
                          value: controller.branchSelected,
                          items: controller.branchList.map((e) {
                            return DropdownMenuItem<BranchData>(
                              value: e,
                              child: Text(
                                e.name.toString(),
                                style: TextStyle(
                                  color: theme.hintColor,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            controller.dptSelected = null;
                            controller.branchSelected = newValue!;

                            controller.getDptByBranch(newValue.id);

                            (context as Element).markNeedsBuild();
                          },
                        )),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              ///2nd Dropdown

              Text(
                "Department Name",
                style: TextStyle(
                  fontSize: MyFonts.headline6TextSize,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 55.h,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: theme.hintColor.withOpacity(.5),
                  ),
                ),
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButtonHideUnderline(
                    child: Obx(() => DropdownButton<DptData>(
                          hint: Text(
                            "--Select Department--",
                            style: TextStyle(
                              color: theme.hintColor,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          isExpanded: true,
                          menuMaxHeight: 215.h,
                          value: controller.dptSelected,
                          items: controller.dptByBranchList.map((e) {
                            return DropdownMenuItem<DptData>(
                              value: e,
                              child: Text(
                                e.name.toString(),
                                style: TextStyle(
                                  color: theme.hintColor,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            controller.dptSelected = newValue!;

                            (context as Element).markNeedsBuild();
                          },
                        )),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ));
  }
}
