class WanUrls {
  static const String BASE_URL = "https://www.wanandroid.com/";

  static const String HOME_BANNER = BASE_URL + "banner/json";

  //方法：POST
  // 参数：
  // 	username，password
  static const String LOGIN = BASE_URL + "user/login";
  static const String LOGOUT = BASE_URL + "user/logout/json";

  //方法：POST
  // 参数
  // 	username,password,repassword
  static const String REGISTER = BASE_URL + "user/register";


  //方法：GET
  //参数：无
  static const String NAVI = BASE_URL + "navi/json";

  static const String HOME_LIST = BASE_URL + "article/list/";
  static const String PROJECT_NEWEST = BASE_URL + "article/listproject/";
  static const String PROJECT_CLASSIFY = BASE_URL + "project/tree/json";
  static const String PROJECT_LIST = BASE_URL + "project/list/";
  static const String SEARCH_LIST = BASE_URL + "article/query/";
  static const String TREES_LIST = BASE_URL + "tree/json";
  static const String TREES_DETAIL_LIST = BASE_URL + "article/list/";
  static const String MP_WECHAT_NAMES = BASE_URL + "wxarticle/chapters/json";
  static const String MP_WECHAT_LIST = BASE_URL + "wxarticle/list/";
  static const String AVATAR = "https://api.adorable.io/avatars/200/";
  static const String AVATAR_GITHUB = "https://github.com/identicons/";
  static const String AVATAR_CODING =
      "https://coding.net/static/fruit_avatar/Fruit-";
  static const String AVATAR_LEGO = "https://randomuser.me/api/portraits/lego/";
  static const String COLLECTED_ARTICLE = BASE_URL + "lg/collect/list/";
  static const String COLLECT_IN_ARTICLE = BASE_URL + "lg/collect/";
  static const String COLLECT_OUT_ARTICLE = BASE_URL + "lg/collect/add/json";
  static const String UNCOLLECT_ARTICLE = BASE_URL + "lg/uncollect_originId/";

  static const String DEFAULT_PROJECT_IMG =
      "wanandroid.com/resources/image/pc/default_project_img.jpg";
}