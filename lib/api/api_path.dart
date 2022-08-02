class ApiPath {
  static const String baseUrl = "https://gymgem.fit";

  static final Uri login = Uri.parse('$baseUrl/trainer/trainer_login');

  static final Uri addUser = Uri.parse('$baseUrl/trainer/add_user');

  static const String profile = '$baseUrl/trainer/get_trainer/';

  static final Uri  updateUser = Uri.parse('$baseUrl/trainer/update_trainer');

  static const String userList = '$baseUrl/trainer/get_trainer_users/';

  static const String workoutList = '$baseUrl/trainer/trainer_workout/';

  static const String mealList = '$baseUrl/trainer/trainer_meal/';

  static final Uri workoutCreate = Uri.parse('$baseUrl/trainer/add_master_workout');

  static final Uri mealCreate = Uri.parse('$baseUrl/trainer/add_master_meal');
  
  static final Uri mealPlanList = Uri.parse('$baseUrl/trainer/get_trainer_meal_plan/');

  static final Uri workPlanList = Uri.parse('$baseUrl/trainer/get_week_workout_plan/');

  static final Uri mealPlanAssign = Uri.parse('$baseUrl/trainer/meal_plan_assign');

  static final Uri workPlanAssign = Uri.parse('$baseUrl/trainer/workout_plan_assign');

  static final Uri scheduleList = Uri.parse('$baseUrl/trainer/modal_meal_plan');

  static final Uri uploadMealPlan = Uri.parse('$baseUrl/trainer/add_meal_plan');

  static final Uri uploadWorkoutPlan = Uri.parse('$baseUrl/trainer/add_workout_plan');

  static final Uri otpVerification = Uri.parse('$baseUrl/trainer/trainer_otp_verification');
  
  static final Uri todayList = Uri.parse('$baseUrl/trainer/day_meal/');

  static final Uri approveOrReject = Uri.parse('$baseUrl/trainer/update_meal_status');
  
  static const String attendanceList = '$baseUrl/trainer/get_attendance_list/';

  static final Uri addAttendance = Uri.parse('$baseUrl/trainer/add_attendance');

  static const String uploadedImage = '$baseUrl/trainer/get_meal_image/';


}
