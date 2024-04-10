import 'dart:io';

String? findCurrentArchitecture() {
  ///suffix details
  ///-------------
  ///b-bloc
  ///g-getx
  ///n- no rest api
  ///rv- riverpod
  ///p-provider
  ///r-rest api
  ///l-layer wise
  ///f-feature wise
  ///---------------
  ///suffix order -> state management + data source type(rest api or not)+ architecture type
  ///example:  'brf' means bloc+rest api+feature wise architecture
  if (File('easy_init_tdd_clean_brf').existsSync()) {
    return "tdd-brf";
  } else if (File('easy_init_mvc_grl').existsSync()) {
    return "mvc-grl";
  } else {
    return null;
  }
}
