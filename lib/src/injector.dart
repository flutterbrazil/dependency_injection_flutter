part 'factory.dart';
part 'helper/factory_helper.dart';
part 'injection_args.dart';
part 'injector_impl.dart';

abstract class Injector {
  static Injector _instance;

  /// access to the Singleton instance of Injector.
  static Injector get instance {
    _instance ??= _InjectorImpl();
    return _instance;
  }

  /// Retrieve a brand new instance of Injector.
  factory Injector.newInstance() {
    return _InjectorImpl();
  }

  /// Get the instance that was injected.
  T get<T>({Map<String, dynamic> args = const <String, dynamic>{}});

  /// Inject a factory
  ///
  /// By default, the injection type will be [InjectionType.singleton]
  /// If an instance is already injected and you wan't to override it
  /// you may wan't to replace it with the overrideInstance flag.
  void inject<T>(InstanceFunction<T> instance,
      {InjectionType type = InjectionType.singleton,
      bool overrideInstance = false});

  /// Removes the instance.
  void remove<T>();

  /// Removes all instances.
  void removeAllInstances();
}

enum InjectionType { singleton, factory, lazySingleton }
