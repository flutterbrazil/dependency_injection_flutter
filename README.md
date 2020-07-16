<img src="https://github.com/flutterbrazil/dependency_injection_flutter/blob/master/res/flutter_brazil_icon.png?raw=true" width="450">


# Dependency Injection for Flutter

 [![Pub](https://img.shields.io/pub/v/dependency_injection_flutter)](https://pub.dev/packages/dependency_injection_flutter)
 [![style: effective dart](https://img.shields.io/badge/style-effective_dart-40c4ff.svg)](https://pub.dev/packages/effective_dart)
 [![GitHub stars](https://img.shields.io/github/stars/flutterbrazil/dependency_injection_flutter?style=social)](https://github.com/flutterbrazil/dependency_injection_flutter)


### Injecting

#### To inject a singleton:

The Singleton instance will be unique. And every time you try to fetch,  
Injector will return the very same instance.

```dart
  Injector.instance.inject<MyInstanceType>(()=>MyInstance());
```

By default, all injections made by the inject method will have  
the type of a Singleton, but you can change it with tye type arg.

#### Injecting a lazy singleton

A lazy singleton will only be instantiated once will call it from Injector.
It helps a lot in saving RAM.

```dart
  Injector.instance.inject<MyInstanceType>(()=>MyInstance(), type: InjectionType.lazySingleton);
```

#### To inject a factory:

A factory is the instance type that will return **always** as a brand new instance.  
It can be useful to get a service for example.

```dart
  Injector.instance.registerFactory<MyInstanceType>(()=>MyInstance(), type: InjectionType.factory);
```


####  and get all of them with:

```dart
  var myInstance = Injector.instance.get<MyInstanceType>();
```

You may want to get them with args*:

```dart
  var myInstance = Injector.instance.get<MyInstanceType>(args: {
    'my_key': 1
  });
  //output: '1'
  print(myInstance.args['my_key'].toString());
```

*In order to do this, you have to implement this in your class:

```dart
class MyClass implements InjectionArgs {
  
  @override
  Map<String, dynamic> args = <String, dynamic> {};
  
}
```

and then you can use:

```dart

var myService = Injector.instance.get<MyService>(args: {
  'api_client': APIClient()
});

class MyService implements InjectionArgs {
  
  final _apiClientKey = 'api_client';
  
  @override
  Map<String, dynamic> args = <String, dynamic> {};
  
  Future<Response> getFoo() async {
    
    final client = args[_apiClientKey];
    return await client.get('api-my_foo_url.com/foo');
    
  }
  
}
```

#### Testing with Injector

One of the great qualities of Injector is to provide an easy way to
test your code in unit tests.


In your class test, at the setUpAll body, use:

```dart

  Injector injector;

  setUpAll(() {
    injector = Injector.instance;
    
    injector.inject<MyServiceInterface>(()=> MyMockedService());
    
  });
  
  test("Testing the get all", () {
    
    // Since you injected the MyServiceInterface
    // it will return a class of MyServiceInterface type, 
    // but with the MyMockedService implementation.
    var myService = injector.get<MyServiceInterface>();
    
    // just as you were going to do in your real MyServiceImpl
    var result = myService.getAll();
    
    
  })
  
```
