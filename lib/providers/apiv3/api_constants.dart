// ignore_for_file: constant_identifier_names

class API {
  //Base URL
  static const BASE_URL = "https://payall.thedigitalkranti.com";
  static const IMAGE_URL = "https://payall.thedigitalkranti.com/public/";

  //Auth Services
  static const REGISTER = "$BASE_URL/api/v2/auth/signup";
  static const VERIFY_OTP = "$BASE_URL/api/v2/auth/confirm_code";
  static const RESEND_CODE = "$BASE_URL/api/v2/auth/resend_code";
  static const LOGIN = "$BASE_URL/api/v2/auth/login";
  static const LOGOUT = "$BASE_URL/api/v2/auth/logout";

  //User and Services
  static const USER_DETAILS = "$BASE_URL/api/v2/auth/user";
  static const SERVICES_LIST = "$BASE_URL/api/v2/service/service-list";
  static const SERVICE_TYPE = "$BASE_URL/api/v2/service/service-type";
  static const FIND_MOBILE_OPERATOR =
      "$BASE_URL/api/v2/recharge/find-mobile-operator";
  static const FIND_MOBILE_PLANS = "$BASE_URL/api/v2/recharge/mobile-plans";

  // resCodes
  static const reqLoginCode = 1001;
  static const reqRegisterCode = 1002;
  static const verifyOtpCode = 1003;
  static const resendOtpCode = 1004;
  static const reqUserInfoCode = 1005;
  static const reqUserLogOut = 1006;
  static const findMobileOperator = 1007;
}
