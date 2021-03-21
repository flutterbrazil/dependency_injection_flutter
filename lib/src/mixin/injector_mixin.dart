import '../../dependency_injection_flutter.dart';

mixin InjectionMixin<T extends Object> {
  T get controller => Injector.instance.get<T>();
}
