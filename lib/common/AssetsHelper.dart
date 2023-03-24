class AssetsHelper {
  const AssetsHelper._();

  static const mSplashBg = "splash_bg";
  static const mSplashFun = "splash_fun";
  static const mSplashFuture = "splash_flutter";
  static const mSplashBgDark = "splash_bg_dark";
  static const mSplashAndroid = "splash_android";

  static const mUserAvatar = "user_avatar";
  static const mLoginLauncher = "login_launcher";


  static String getPngImg(String name) {
    return "assets/images/${name}.png";
  }
}
