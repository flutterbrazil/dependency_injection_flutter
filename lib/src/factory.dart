part of 'injector.dart';

class _Factory<T> {
  T instance;
  InstanceFunction<T> instanceFunction;
  InjectionType type;

  _Factory({this.instanceFunction, this.type}) {
    if (type == InjectionType.singleton) {
      instance = instanceFunction();
    }
  }

  T getInstance({Map<String, dynamic> args = const <String, dynamic>{}}) {
    var instanceToEject;

    switch (type) {
      case InjectionType.lazySingleton:
      case InjectionType.singleton:
        if (instance == null) {
          instance = instanceFunction();
        }
        instanceToEject = instance;
        break;

      case InjectionType.factory:
      default:
        instanceToEject = instanceFunction();
    }

    if (instanceToEject is InjectionArgs && args != null && args.isNotEmpty) {
      instanceToEject.args = (args);
    }

    return instanceToEject;
    ;
  }
}

typedef InstanceFunction<T> = T Function();
