import 'package:get/get.dart';
import 'package:getx_standard/app/service/base_controller.dart';

import '../../../data/models/branch_model.dart';
import '../../../data/models/department_by_branch.dart';
import '../../../service/api_urls.dart';
import '../../../service/dio_client.dart';

class HomeController extends GetxController with BaseController {
  BranchData? branchSelected;
  DptData? dptSelected;

  final branchList = RxList<BranchData>();
  final dptByBranchList = RxList<DptData>();

  ///BRANCH LIST

  getBranchList() async {
    showLoading('Loading...');
    var response = await DioClient().get(ApiUrl.branchList, {
      "Authorization": "Bearer 52|ydG3LJrl9fUNgTJQxnfZnXbdukXng2huDLYc24tY"
    }).catchError(handleError);
    if (response == null) return;

    branchList.assignAll(
        (response["data"] as List).map((e) => BranchData.fromJson(e)).toList());

    hideLoading();
  }

  ///DPT BY BRANCH

  getDptByBranch(int? branchId) async {
    showLoading('Loading...');
    var response = await DioClient().get('${ApiUrl.deptByBranch}$branchId', {
      "Authorization": "Bearer 52|ydG3LJrl9fUNgTJQxnfZnXbdukXng2huDLYc24tY"
    }).catchError(handleError);
    if (response == null) return;

    dptByBranchList.assignAll(
        (response["data"] as List).map((e) => DptData.fromJson(e)).toList());

    hideLoading();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    await getBranchList();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
