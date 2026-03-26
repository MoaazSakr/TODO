import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:todo/core/cache/cache_helper.dart';
import 'package:todo/core/cache/cache_keys.dart';
import 'package:todo/features/auth/data/login_response_model.dart';
import 'package:todo/features/auth/data/user_model.dart';
import '../../features/home/data/task_model.dart';

abstract class APIHelper {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://ntitodo-production-779a.up.railway.app/api/',
    receiveDataWhenStatusError: true,
  ))..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await CacheHelper.getValue(CacheKeys.accessToken);
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401) {
            bool isRefreshed = await refreshToken(); 
            if (isRefreshed) {
              final newToken = await CacheHelper.getValue(CacheKeys.accessToken);
              e.requestOptions.headers['Authorization'] = 'Bearer $newToken';
              try {
                final retryDio = Dio();
                final retryResponse = await retryDio.fetch(e.requestOptions);
                return handler.resolve(retryResponse);
              } catch (retryError) {
                return handler.next(e);
              }
            }
          }
          return handler.next(e);
        },
      ),
    );

  static Future<bool> refreshToken() async {
    try {
      final refreshTokenStr = await CacheHelper.getValue(CacheKeys.refreshToken);
      if (refreshTokenStr == null) return false;

      final refreshDio = Dio(BaseOptions(baseUrl: 'https://ntitodo-production-779a.up.railway.app/api/'));
      final response = await refreshDio.post('refresh', data: FormData.fromMap({
        'refresh_token': refreshTokenStr,
      }));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final newAccessToken = response.data['access_token'];
        final newRefreshToken = response.data['refresh_token'] ?? refreshTokenStr;
        
        await CacheHelper.setValue(CacheKeys.accessToken, newAccessToken);
        await CacheHelper.setValue(CacheKeys.refreshToken, newRefreshToken);
        return true;
      }
      return false;
    } catch (e) {
      return false; 
    }
  }

  static Future<Either<String, UserModel>> login({
    required String username,
    required String password,
  }) async {
    try {
      var loginResponse = await _dio.post(
        'login',
        data: FormData.fromMap({
          'username': username,
          'password': password,
        }),
      );
      var loginResponseModel = LoginResponseModel.fromJson(loginResponse.data as Map<String, dynamic>);

      await CacheHelper.setValue(CacheKeys.accessToken, loginResponseModel.accessToken!);
      await CacheHelper.setValue(CacheKeys.refreshToken, loginResponseModel.refreshToken!);

      return Right(loginResponseModel.userModel!);
    } catch (e) {
      if (e is DioException) {
        var errorResponse = e.response?.data as Map<String, dynamic>?;
        return Left(errorResponse?['message'] ?? 'حدث خطأ غير معروف أثناء تسجيل الدخول');
      } else {
        return Left('حدث خطأ بالاتصال.\nحاول مرة أخرى لاحقاً');
      }
    }
  }

  static Future<Either<String, UserModel>> register({
    required String username,
    required String password,
  }) async {
    try {
      // 1. نقوم بإنشاء الحساب في الـ API
      await _dio.post(
        'register',
        data: FormData.fromMap({
          'username': username,
          'password': password,
        }),
      );
      
      // 2. التريك السحري: بما أن الـ Register مش بيرجع توكن، هنعمل Login تلقائي!
      // الدالة دي هتروح تجيب التوكن، تحفظه في الكاش، وترجع بيانات المستخدم بأمان
      var loginResult = await login(username: username, password: password);
      
      return loginResult.fold(
        (error) => Left(error),
        (userModel) => Right(userModel),
      );

    } catch (e) {
      if (e is DioException) {
        var errorResponse = e.response?.data as Map<String, dynamic>?;
        return Left(errorResponse?['message'] ?? 'حدث خطأ غير معروف أثناء إنشاء الحساب');
      } else {
        return Left('حدث خطأ بالاتصال.\nحاول مرة أخرى لاحقاً');
      }
    }
  }

  static Future<Either<String, String>> logout() async {
    try {
      var response = await _dio.post('logout');
      var successResponse = response.data as Map<String, dynamic>;
      
      await CacheHelper.removeValue(CacheKeys.accessToken);
      await CacheHelper.removeValue(CacheKeys.refreshToken);

      return Right(successResponse['message'] ?? 'تم تسجيل الخروج بنجاح');
    } catch (e) {
      await CacheHelper.removeValue(CacheKeys.accessToken);
      await CacheHelper.removeValue(CacheKeys.refreshToken);
      return const Right('تم تسجيل الخروج محلياً');
    }
  }

  static Future<Either<String, UserModel>> getUserData() async {
    try {
      var response = await _dio.get('get_user_data');
      var userData = response.data as Map<String, dynamic>;
      UserModel user = UserModel.fromJson(userData['user'] ?? userData);
      return Right(user);
    } catch (e) {
      if (e is DioException) {
        var errorResponse = e.response?.data as Map<String, dynamic>?;
        return Left(errorResponse?['message'] ?? 'حدث خطأ أثناء جلب بيانات المستخدم');
      } else {
        return Left('حدث خطأ بالاتصال.\nحاول مرة أخرى لاحقاً');
      }
    }
  }

  static Future<Either<String, String>> updateProfile({
    required String username,
  }) async {
    try {
      var response = await _dio.put(
        'update_profile',
        data: FormData.fromMap({'username': username}),
      );
      var successResponse = response.data as Map<String, dynamic>;
      return Right(successResponse['message'] ?? 'تم تحديث الملف الشخصي بنجاح');
    } catch (e) {
      if (e is DioException) {
        var errorResponse = e.response?.data as Map<String, dynamic>?;
        return Left(errorResponse?['message'] ?? 'حدث خطأ أثناء تحديث الملف الشخصي');
      } else {
        return Left('حدث خطأ بالاتصال.\nحاول مرة أخرى لاحقاً');
      }
    }
  }

  static Future<Either<String, String>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String newPasswordConfirm,
  }) async {
    try {
      var response = await _dio.post(
        'change_password',
        data: FormData.fromMap({
          'current_password': currentPassword,
          'new_password': newPassword,
          'new_password_confirm': newPasswordConfirm,
        }),
      );
      var successResponse = response.data as Map<String, dynamic>;
      return Right(successResponse['message'] ?? 'تم تغيير كلمة المرور بنجاح');
    } catch (e) {
      if (e is DioException) {
        var errorResponse = e.response?.data as Map<String, dynamic>?;
        return Left(errorResponse?['message'] ?? 'حدث خطأ أثناء تغيير كلمة المرور');
      } else {
        return Left('حدث خطأ بالاتصال.\nحاول مرة أخرى لاحقاً');
      }
    }
  }

  static Future<Either<String, String>> deleteUser() async {
    try {
      var response = await _dio.delete('delete_user');
      var successResponse = response.data as Map<String, dynamic>;
      
      await CacheHelper.removeValue(CacheKeys.accessToken);
      await CacheHelper.removeValue(CacheKeys.refreshToken);

      return Right(successResponse['message'] ?? 'تم حذف الحساب بنجاح');
    } catch (e) {
      if (e is DioException) {
        var errorResponse = e.response?.data as Map<String, dynamic>?;
        return Left(errorResponse?['message'] ?? 'حدث خطأ أثناء حذف الحساب');
      } else {
        return Left('حدث خطأ بالاتصال.\nحاول مرة أخرى لاحقاً');
      }
    }
  }

  static Future<Either<String, List<TaskModel>>> getTasks() async {
    try {
      var response = await _dio.get('my_tasks');
      var tasksResponse = response.data as Map<String, dynamic>;
      
      List<TaskModel> tasks = [];
      if (tasksResponse['tasks'] != null) {
        for (var taskJson in tasksResponse['tasks']) {
          tasks.add(TaskModel.fromJson(taskJson));
        }
      }
      return Right(tasks);
    } catch (e) {
      if (e is DioException) {
        var errorResponse = e.response?.data as Map<String, dynamic>?;
        return Left(errorResponse?['message'] ?? 'حدث خطأ أثناء جلب المهام');
      } else {
        return Left('حدث خطأ بالاتصال.\nحاول مرة أخرى لاحقاً');
      }
    }
  }

  static Future<Either<String, String>> addTask({
    required String title,
    required String description,
    String? group,
    String? endTime,
  }) async {
    try {
      Map<String, dynamic> data = {
        'title': title,
        'description': description,
      };
      
      if (group != null) data['group'] = group;
      if (endTime != null) data['end_time'] = endTime;

      var response = await _dio.post(
        'new_task',
        data: FormData.fromMap(data),
      );
      var successResponse = response.data as Map<String, dynamic>;
      return Right(successResponse['message'] ?? 'تم إضافة المهمة بنجاح');
    } catch (e) {
      if (e is DioException) {
        var errorResponse = e.response?.data as Map<String, dynamic>?;
        return Left(errorResponse?['message'] ?? 'حدث خطأ أثناء إضافة المهمة');
      } else {
        return Left('حدث خطأ بالاتصال.\nحاول مرة أخرى لاحقاً');
      }
    }
  }

  static Future<Either<String, String>> updateTask({
    required int taskId,
    required String title,
    required String description,
    String? group,
    String? endTime,
  }) async {
    try {
      Map<String, dynamic> data = {
        'title': title,
        'description': description,
      };

      if (group != null) data['group'] = group;
      if (endTime != null) data['end_time'] = endTime;

      var response = await _dio.put(
        'tasks/$taskId',
        data: FormData.fromMap(data),
      );
      var successResponse = response.data as Map<String, dynamic>;
      return Right(successResponse['message'] ?? 'تم تحديث المهمة بنجاح');
    } catch (e) {
      if (e is DioException) {
        var errorResponse = e.response?.data as Map<String, dynamic>?;
        return Left(errorResponse?['message'] ?? 'حدث خطأ أثناء تحديث المهمة');
      } else {
        return Left('حدث خطأ بالاتصال.\nحاول مرة أخرى لاحقاً');
      }
    }
  }

  static Future<Either<String, String>> deleteTask({required int taskId}) async {
    try {
      var response = await _dio.delete('tasks/$taskId');
      var successResponse = response.data as Map<String, dynamic>;
      return Right(successResponse['message'] ?? 'تم حذف المهمة بنجاح');
    } catch (e) {
      if (e is DioException) {
        var errorResponse = e.response?.data as Map<String, dynamic>?;
        return Left(errorResponse?['message'] ?? 'حدث خطأ أثناء حذف المهمة');
      } else {
        return Left('حدث خطأ بالاتصال.\nحاول مرة أخرى لاحقاً');
      }
    }
  }
}