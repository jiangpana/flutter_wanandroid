class WanUrls {
  static const String BASE_URL = "https://www.wanandroid.com/";

  static const String HOME_BANNER = BASE_URL + "banner/json";


  static const String ARTICLE_LIST = BASE_URL + "article/list/";

  static const String WENDA_LIST = BASE_URL + "wenda/list/";
  //方法：GET
  //参数：无
  static const String NAVI = BASE_URL + "navi/json";

  //方法：GET
  // 参数： 页码：拼接在链接中，从0开始。
  static const String COLLECTED_ARTICLE = BASE_URL + "lg/collect/list/";


  //方法：POST
  // 参数：
  // 	username，password
  static const String LOGIN = BASE_URL + "user/login";

  static const String LOGOUT = BASE_URL + "user/logout/json";

  //方法：POST
  // 参数
  // 	username,password,repassword
  static const String REGISTER = BASE_URL + "user/register";


  static const String USERINFO = BASE_URL + "user/lg/userinfo/json";



}