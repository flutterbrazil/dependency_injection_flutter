part of '../injector.dart';

class _Factory<T> {
  T? _instance;
  InstanceFunction<T> instanceFunction;
  InjectionType type;

  _Factory({required this.instanceFunction, required this.type}) {
    if (type == InjectionType.singleton) {
      _instance = instanceFunction();
    }
  }

  T getInstance<T extends Object>() {
    T instanceToEject;

    switch (type) {
      case InjectionType.lazySingleton:
      case InjectionType.singleton:
        if (_instance == null) {
          _instance = instanceFunction();
        }
        instanceToEject = _instance! as T;
        break;

      case InjectionType.factory:
      default:
        instanceToEject = instanceFunction()! as T;
    }

    return instanceToEject;
  }

  void resetInstance() {
    _instance = null;
    _instance = instanceFunction();
  }
}

typedef InstanceFunction<T> = T Function();
