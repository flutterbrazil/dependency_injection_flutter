part of 'injector.dart';

class InjectionArgs {
  Map<String, dynamic> args = <String, dynamic>{};
}

mixin InjectionMixin<T> {
  T get controller => Injector.instance.get<T>();
}
