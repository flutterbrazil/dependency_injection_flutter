part of '../injector.dart';

class _InjectionHelper {
  static bool isRegistered<Type>(Map store) => store.containsKey(Type);

  static bool isNotRegistered<Type>(Map store) => !(isRegistered<Type>(store));
}
