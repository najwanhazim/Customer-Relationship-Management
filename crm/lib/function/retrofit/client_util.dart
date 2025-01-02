import 'package:dio/dio.dart';
// import 'package:drift/native.dart';

String? clientReturn(Object obj) {
  switch (obj.runtimeType) {
    case DioError:
      final res = (obj as DioError).response;
      if (res != null) {
        if (res.data != null) {
          if (res.data is Map) {
            final response = Map<String, dynamic>.from(res.data);
            switch (response["detail"].runtimeType) {
              case String:
                return response["detail"];
              default:
                return res.statusMessage;
            }
          }
          return res.statusMessage;
        } else {
          return res.statusMessage;
        }
      } else {
        return obj.error.toString();
      }
    // case SqliteException:
    //   final res = obj as SqliteException;
    //   if (res.extendedResultCode == 2067) {
    //     return "Record already exist";
    //   } else {
    //     return res.message;
    //   }
    case String:
      return obj as String;
      
    default:
      return "An error occurred";
  }
}
