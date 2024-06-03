import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:cubic_task/core/network/api_domain_url.dart';
import 'package:cubic_task/core/network/errors/custom_exception.dart';
import 'package:cubic_task/core/utils/constants/enums/status_code_enums.dart';
import 'package:cubic_task/core/utils/constants/shared_text.dart';

class DioHelper {

  static late Dio dio;

  /// Initializing dio baseUrl
  static init() {
    try {
      dio = Dio(
        BaseOptions(
          baseUrl: ApiDomainUrl.productionApiDomainUrl,
          headers: {
            'Accept': 'application/json',
          },
          receiveDataWhenStatusError: true,
          sendTimeout: const Duration(seconds: 30),
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
        ),
      );


      /// Make Logger With Dio For Request And Response
      if (kDebugMode) {
        dio.interceptors.add(
          LogInterceptor(
            error: true,
            request: true,
            requestBody: true,
            requestHeader: true,
            responseBody: true,
            responseHeader: true,
          ),
        );
      }
    } on DioException catch (exception) {
      /// throw custom exception
      throw CustomException(
        errorMessage: exception.message.toString(),
        statusCode: exception.response!.statusCode!,
      );
    } catch (e) {
      debugPrint("error : ${e.toString()}");
      throw CustomException(errorMessage: e.toString());
    }
  }

  ///use this method to get data from api
  static Future<Response> getData(
      {required String url, Map<String, dynamic>? queryParameters}) async {
    try {
      /// Set User Token In Dio Header
      DioHelper.dio.options.headers
          .addAll({"Authorization": "Bearer ${SharedText.userToken}"});

      return await dio.get(url, queryParameters: queryParameters);
    } on DioException catch (exception) {
      if (exception.type == DioExceptionType.connectionError ||
          exception.type == DioExceptionType.connectionTimeout) {
        throw CustomException(
          errorMessage: "Internet connection failed",
          statusCode: 408,
        );
      }

      /// Show Error In Slack Channel
      sendSlackMessage(
          "==================\n# endpoint : $url \n# status code : ${exception.response?.data['status_code']}\n# error message : ${exception.response?.data['message']} \n# user name : ${SharedText.userModel.name}\n==================\n");

      /// Throw Custom Exception
      throw CustomException(
        errorMessage: exception.response!.data['message'].toString(),
        statusCode: exception.response!.data['status_code'],
      );
    } catch (e) {
      throw CustomException(errorMessage: e.toString());
    }
  }

  ///use this method to send data to api
  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      /// Set User Token In Dio Header
      DioHelper.dio.options.headers
          .addAll({"Authorization": "Bearer ${SharedText.userToken}"});

      final response = await dio.post(url, data: data , queryParameters: queryParameters );

      return response;
    } on DioException catch (exception) {
      if (exception.type == DioExceptionType.connectionError ||
          exception.type == DioExceptionType.connectionTimeout) {
        throw CustomException(
          errorMessage: "Internet connection failed",
          statusCode: 408,
        );
      }


      /// Throw Custom Exception
      throw CustomException(
        errorMessage: exception.response!.data['message'],
        statusCode: exception.response!.statusCode!
      );
    } catch (e) {
      throw CustomException(errorMessage: e.toString() , );
    }
  }

  ///use this method to update data in api
  static Future<Response> putData({
    required String url,
    required Map<String, dynamic>? data,
  }) async {
    try {
      /// Set User Token In Dio Header
      DioHelper.dio.options.headers
          .addAll({"Authorization": "Bearer ${SharedText.userToken}"});
      final response = await dio.put(url, data: data);

      return response;
    } on DioException catch (exception) {
      if (exception.type == DioExceptionType.connectionError ||
          exception.type == DioExceptionType.connectionTimeout) {
        throw CustomException(
          errorMessage: "Internet connection failed",
          statusCode: 408,
        );
      }

      /// Show Error In Slack Channel
      sendSlackMessage(
          "==================\n# endpoint : $url \n# status code : ${exception.response?.data['status_code']}\n# error message : ${exception.response?.data['message']} \n# user name : ${SharedText.userModel.name}\n==================\n");

      /// Throw Custom Exception
      throw CustomException(
        errorMessage: exception.response!.data['message'].toString(),
        statusCode: exception.response!.data['status_code'],
      );
    } catch (e) {
      throw CustomException(errorMessage: e.toString());
    }
  }

  ///use this method to delete data in api
  static Future<Response> deleteData({required String url}) async {
    try {
      /// Set User Token In Dio Header
      DioHelper.dio.options.headers
          .addAll({"Authorization": "Bearer ${SharedText.userToken}"});
      final response = await dio.delete(url);
      return response;
    } on DioException catch (exception) {
      if (exception.type == DioExceptionType.connectionError ||
          exception.type == DioExceptionType.connectionTimeout) {
        throw CustomException(
          errorMessage: "Internet connection failed",
          statusCode: 408,
        );
      }

      /// Show Error In Slack Channel
      sendSlackMessage(
          "==================\n# endpoint : $url \n# status code : ${exception.response?.data['status_code']}\n# error message : ${exception.response!.data['message']} \n# user name : ${SharedText.userModel.name}\n==================\n");

      /// Throw Custom Exception
      throw CustomException(
        errorMessage: exception.response!.data['message'].toString(),
        statusCode: exception.response!.data['status_code'],
      );
    } catch (e) {
      throw CustomException(errorMessage: e.toString());
    }
  }

  handleErrorTypeByStatusCode(int statusCode) {
    switch (statusCode) {
      case 200:
        return NetworkErrorType.success;
      case 400:
        return NetworkErrorType.badRequest;
      case 401:
        return NetworkErrorType.unAuthorized;
      case 404:
        return NetworkErrorType.notFound;
      case 500:
        return NetworkErrorType.serverError;
      default:
        return NetworkErrorType.unExcepted;
    }
  }

  static sendSlackMessage(String messageText) {
    // //Slack's Webhook URL
    // var url =
    //     'https://hooks.slack.com/services/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';
    //
    // var request = {
    //   'text': messageText,
    // };
    //
    // postData(url: url, data: request).then((response) {
    //   debugPrint("The Response Data Is : ${response.data}");
    // });
  }
}
