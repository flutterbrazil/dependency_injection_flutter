part of 'injector.dart';

class _InjectorImpl implements Injector {
  static final _registeredInstances = <Type, _Factory>{};

  @override
  T get<T>({Map<String, dynamic> args = const <String, dynamic>{}}) {
    if (_InjectionHelper.isRegistered<T>(_registeredInstances)) {
      var result = _registeredInstances[T];
      return result.getInstance(args: args);
    } else {
      return null;
    }
  }

  @override
  void inject<T>(InstanceFunction<T> instance,
      {InjectionType type = InjectionType.singleton,
      bool overrideInstance = false}) {
    if (_InjectionHelper.isNotRegistered<T>(_registeredInstances)) {
      _registeredInstances.putIfAbsent(
          T, () => _Factory<T>(instanceFunction: instance, type: type));
    } else {
      if (overrideInstance) {
        _registeredInstances[T] =
            _Factory<T>(instanceFunction: instance, type: type);
      }
    }
  }

  @override
  void remove<T>() {
    if (_InjectionHelper.isRegistered<T>(_registeredInstances)) {
      _registeredInstances.remove(T);
    }
  }

  @override
  void removeAllInstances() {
    _registeredInstances.clear();
  }
}
