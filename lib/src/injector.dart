import 'errors/injector_exception.dart';

part 'factory/factory.dart';
part 'helper/injection_helper.dart';
part 'injector_impl.dart';

abstract class Injector {
  static Injector? _instance;

  /// access to the Singleton instance of Injector.
  static Injector get instance {
    _instance ??= _InjectorImpl();
    return _instance!;
  }

  /// Short access to the Singleton instance of Injector.
  static Injector get I => instance;

  /// Retrieve a brand new instance of Injector.
  factory Injector.newInstance() {
    return _InjectorImpl();
  }

  /// Get the instance that was injected.
  T get<T extends Object>();

  /// Inject a factory
  ///
  /// By default, the injection type will be [InjectionType.singleton]
  /// If an instance is already injected and you wan't to override it
  /// you may wan't to replace it with the overrideInstance flag.
  void inject<T extends Object>(InstanceFunction<T> instance,
      {InjectionType type = InjectionType.singleton,
      bool overrideInstance = false});

  /// Removes the instance.
  void remove<T extends Object>();

  /// Removes all instances.
  void removeAllInstances();

  /// Resets the instance of [T] that was injected.
  void reset<T extends Object>();

  /// Resets all instances that were injected
  void resetAllInstances();
}

enum InjectionType { singleton, factory, lazySingleton }
