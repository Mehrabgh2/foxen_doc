Map<int, String> serverErrorsCode = {
  0: 'empty token error',
  1: 'timeout error',
};

Map<String, String> authServerErrorsStrings = {
  // login
  'not_valid_username': '.نام کاربری یا رمز عبور صحیح نیست',
  'length_5_to_10': '.نام کاربری یا رمز عبور صحیح نیست',
  'password_length_not_6_to_20': '.نام کاربری یا رمز عبور صحیح نیست',
  'username_or_password': '.نام کاربری یا رمز عبور صحیح نیست',
  // signup
  'device_has_owner': '.ردیاب مورد نظر قبلا ثبت شده است',
  'device_not_found': '.ردیابی با این مشخصات یافت نشد',
  'duplicate_username': '.نام کاربری قبلا استفاده شده است',
  'duplicate_national_code': '.کد ملی قبلا استفاده شده است',
  'duplicate_email': '.ایمبل قبلا استفاده شده است',
  'duplicate_phone': '.شماره تلفن همراه مورد نظر قبلا ثبت شده است',
  'length_not_5_to_15': '.نام کاربری وارد شده صحیح نیست',
  'not_valid_password': '.رمز عبور وارد شده صحیح نیست',
  // OTP
  'Expired_code': '.کد تایید منقضی شده است',
  'code_not_equal': '.کد تایید وارد شده صحیح نیست',
  // forget password
  'user_not_found_with_that_phone_number': '.کاربری با این شماره یافت نشد',
  'length_not_11': '.کاربری با این شماره یافت نشد',
  'verification_code_is_wrong': '.کد تایید وارد شده صحیح نیست',
  'auth_error': '.کد تایید وارد شده صحیح نیست',
  'password_not_change': '.عملیات تغییر رمز عبور با مشکل مواجه شد',
  // core
  'empty': '.تمامی فیلد ها را پر کنید',
  'server_error': '.در حال حاضر سرور در دسترس نیست',
  'invalid_json': '.مقادیر ورودی صحیح نیست',
};
Map<String, String> carServerErrorsStrings = {
  // bookmark
  'wrong_value_for_bookMark': '.مقدار اشتباه برای نشان کردن',
  'permission': '.خطای دسترسی',
};
