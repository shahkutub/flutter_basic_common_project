class AppApi {
  // static var baseurl = 'http://192.168.68.130/bmms/';
  //static var baseurl = 'https://bmms.codespecies.com/';
  //static var baseurl = 'http://192.168.68.135/bmms/';
  //static var baseurl = 'http://bmms.nanoit.biz/';
  static var baseurl = 'http://103.139.234.88:9006/';
  static var base2url = '${baseurl}v1';

  static var registerurl = '$base2url/user/sign-up';
  static var loginurl = '$base2url/user/login';
  static var logout = '$base2url/user/logout';
  static var categoryurl = '$base2url/category';
  static var mineralurl = '$base2url/category/';
  static var visiturl = '$base2url/visitor';
  static var photoGalUrl = '$base2url/gsbgallery/list';
  static var myappointmentUrl = '$base2url/my-appointment';
  static var sendCode = '$base2url/email/verification-notification';
  static var verifycodesubmit = '$base2url/verify-code-submit';
}