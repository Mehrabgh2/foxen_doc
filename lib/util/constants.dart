class Constants {
  // mapbox styles
  static const String DARK_GOOGLE_STYLE =
      '[{"elementType": "geometry","stylers": [{"color": "#242f3e"}]},{"elementType": "labels.text.fill","stylers": [{"color": "#746855"}]},{"elementType": "labels.text.stroke","stylers": [{"color": "#242f3e"}]},{"featureType": "administrative.locality","elementType": "labels.text.fill","stylers": [{"color": "#d59563"}]},{"featureType": "poi","elementType": "labels.text.fill","stylers": [{"color": "#d59563"}]},{"featureType": "poi.park","elementType": "geometry","stylers": [{"color": "#263c3f"}]},{"featureType": "poi.park","elementType": "labels.text.fill","stylers": [{"color": "#6b9a76"}]},{"featureType": "road","elementType": "geometry","stylers": [{"color": "#38414e"}]},{"featureType": "road","elementType": "geometry.stroke","stylers": [{"color": "#212a37"}]},{"featureType": "road","elementType": "labels.text.fill","stylers": [{"color": "#9ca5b3"}]},{"featureType": "road.highway","elementType": "geometry","stylers": [{"color": "#746855"}]},{"featureType": "road.highway","elementType": "geometry.stroke","stylers": [{"color": "#1f2835"}]},{"featureType": "road.highway","elementType": "labels.text.fill","stylers": [{"color": "#f3d19c"}]},{"featureType": "transit","elementType": "geometry","stylers": [{"color": "#2f3948"}]},{"featureType": "transit.station","elementType": "labels.text.fill","stylers": [{"color": "#d59563"}]},{"featureType": "water","elementType": "geometry","stylers": [{"color": "#17263c"}]},{"featureType": "water","elementType": "labels.text.fill","stylers": [{"color": "#515c6d"}]},{"featureType": "water","elementType": "labels.text.stroke","stylers": [{"color": "#17263c"}]}]';
  // mapbox styles
  static const String LIGHT_MAPBOX_STYLE =
      'mapbox://styles/mehrabghasab/cl9u4zd9x002014qjkg8ti9tt';
  static const String DARK_MAPBOX_STYLE =
      'mapbox://styles/mehrabghasab/cl9u4ueq200ar15khn6px8xvg';
  static const String SATELITE_MAPBOX_STYLE =
      'mapbox://styles/mehrabghasab/cl9u59mu1001e15s5p10vsbqp';
  static const String LIGHT_TRAFFIC_MAPBOX_STYLE =
      'mapbox://styles/mehrabghasab/cl9v9rl3x000914ln07bwpxsm';
  static const String DARK_TRAFFIC_MAPBOX_STYLE =
      'mapbox://styles/mehrabghasab/cl9v9rdn7004914mitk15yddz';
  static const String SATELITE_TRAFFIC_MAPBOX_STYLE =
      'mapbox://styles/mehrabghasab/cl9v9ryrj005a14mu72wa02nr';
  // variables
  static const requestTimeout = 30000;
  static const websocketTimeout = 30000;
  static const paginationLimit = 20;
  // urls
  static const String IMAGE_FOLDER_NAME = 'TODO';
  static const String BASE_URL = 'https://fms.arshinco.com/server1';
  static const String SUPPORT_VIDEOS_BASE_URL =
      'https://arshinco.com/foxen-app/help/';
  static const String SOCKET_BASE_URL = 'wss://fms.arshinco.com';

  static const String GET_USER_INFO_URL = '/users/Info';
  static const String LOGIN_URL = '/sign-in';
  static const String CHECK_LICENSE_URL = '/devicesPg/exists/check/';
  static const String SIGNUP_URL = '/sign-up';
  static const String VERIFY_OTP_URL = '/users/verify/phone/';
  static const String FORGET_PASSWORD_SEND_OTP_URL = '/users/forgot-password/';
  static const String FORGET_PASSWORD_SUBMIT_OTP_URL =
      '/users/forgot-password/';
  static const String FORGET_PASSWORD_NEW_PASSWORD_URL =
      '/users/reset-password';
  static const String RESET_PASSWORD_NEW_PASSWORD_URL = '/users/password/';
  static const String VEHICLE_BOOKMARK_URL = '/vehicle/bookmark/';
  static const String VEHICLE_SECURITY_HISTORY_URL =
      '/vehicle/device/security/history/';
  static const String VEHICLE_ADD_URL = '/vehicle/app/';
  static const String VEHICLE_ODOMETER_HISTORY_URL = '/odometer/';
  static const String VEHICLE_ADD_ODOMETER_URL = '/odometer/';
  static const String VEHICLE_APP_SETTING = '/app/appSetting/';
  static const String VEHICLE_NOTIFICATION_SETTING = '/vehicleAccount/setting/';
  static const String VEHICLE_CONCOX_NOTIFICATION_SETTING =
      '/devices/concox-command';
  static const String VEHICLE_IDENTIFICATION = '/vehicle/identification/';
  static const String VEHICLE_CLASSIFICATION = '/vehicle/classification/';
  static const String DEVICE_SIM_NUMBER = '/devicesPg/editSimno/';
  static const String GET_NOTIFICATIONS = '/notifications/';
}
