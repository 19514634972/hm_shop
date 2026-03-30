
import 'package:dio/dio.dart';
import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/stores/TokenManager.dart';

class DioRequest{
  final _dio=Dio(); //dio请求对象
  //基础拦截器
  DioRequest(){
    _dio.options..baseUrl=GlobalConstants.BASE_URL
      ..connectTimeout=Duration(seconds: GlobalConstants.TIME_OUT)
      ..sendTimeout=Duration(seconds: GlobalConstants.TIME_OUT)
      ..receiveTimeout=Duration(seconds: GlobalConstants.TIME_OUT);
      //拦截器
       _addInterceptors();
  }
  //添加拦截器
void _addInterceptors(){
  _dio.interceptors.add(InterceptorsWrapper(
    onRequest: (request,handler){
      //注入token headers==》Authorization="Bearer token"
      if (tokenManager.getToken().isNotEmpty){ //所有接口携带token
          request.headers={"Authorization":"Bearer ${tokenManager.getToken()}"};
      }
      //在请求前做一些事情
      return handler.next(request);
    },
    onResponse: (response,handler){
      //在响应前做一些事情
      if (response.statusCode! >=200 && response.statusCode! <300){
        //如果状态码不是成功状态码
        return handler.next(response);
      }else{
        //如果状态码不是成功状态码
        return handler.reject(DioException(requestOptions:response.requestOptions)); 
      }
      
    },
    onError: (error,handler){
      //在错误前做一些事情
      ////return handler.reject(error);
      handler.reject(
        DioException(
          requestOptions: error.requestOptions,
          message: error.response?.data["msg"]??""
          ));
    },
  ));
}

Future<dynamic> get(String url,{Map<String,String>? queryParameters, Map<String, dynamic>? params}){
  return  _handleResponse(_dio.get(url,queryParameters: queryParameters ?? params));
}

Future<dynamic>post(String url,{Map<String,dynamic>? data}){
  return _handleResponse(_dio.post(url,data: data));

}
//进一步处理返回结果的函数
//dio工具发出请求返回的数据在Response<dynamic>.data中
//把所有接口的data解放出来,拿到真正数据,判断业务状态码==1继续否则返回错误
Future<dynamic> _handleResponse(Future<Response<dynamic>> task)async{
    try{
      Response<dynamic> res=await task;

      final data=res.data as Map<String,dynamic>;

      if (data["code"]==GlobalConstants.SUCCESS_CODE){
          return data["result"];
   
        }
         // throw Exception(data["msg"] ?? "请求失败");
         throw DioException(
          requestOptions: res.requestOptions,
          message: data["msg"]??"加载数据失败"
          );
      }catch(e){
        //throw Exception(e);
        rethrow;// 不改变原来抛出的异常类型
      }

          
  }

   
  

}


//单例对象
final dioRequset=DioRequest();

