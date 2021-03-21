part of 'injector.dart';

class _InjectorImpl implements Injector {
  static final _registeredInstances = <Type, _Factory>{};

  @override
  T get<T extends Object>() {
    if (_InjectionHelper.isRegistered<T>(_registeredInstances)) {
      final result = _registeredInstances[T];

      assert(
          result != null,
          "instance of $T is null. Inject it before"
          "getting it.");

      return result!.getInstance();
    } else {
      print("dependency_injection_flutter: no instance of $T was found");
      throw InjectorException("no instance of $T was found."
          " Inject it before getting it");
    }
  }

  @override
  void inject<T extends Object>(InstanceFunction<T> instance,
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
  void remove<T extends Object>() {
    if (_InjectionHelper.isRegistered<T>(_registeredInstances)) {
      _registeredInstances.remove(T);
    } else {
      print("dependency_injection_flutter: no instance $T to be removed");
    }
  }

  @override
  void removeAllInstances() {
    _registeredInstances.clear();
  }

  @override
  void reset<T extends Object>() {
    if (_InjectionHelper.isRegistered<T>(_registeredInstances)) {
      final result = _registeredInstances[T];
      assert(
          result != null,
          "Instance of $T is null. "
          "You can't reset an instance that was not injected");
      result!.resetInstance();
    }
  }

  @override
  void resetAllInstances() {
    for (var factory in _registeredInstances.entries) {
      factory.value.resetInstance();
    }
  }
}
