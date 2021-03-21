import 'package:dependency_injection_flutter/src/injector.dart';
import 'package:test/test.dart';

void main() {
  late Injector injector;

  setUpAll(() {
    injector = Injector.instance;
  });

  test("test the inject of singleton in normal conditions", () {
    var fooFirst = Foo();

    fooFirst.increment();

    injector.inject<Foo>(() => fooFirst, type: InjectionType.singleton);

    var foo = injector.get<Foo>();
    foo.increment();

    expect(foo.value, 2);
  });

  test("test the inject of a LAZY singleton in normal conditions", () {
    var fooFirst = Foo();

    fooFirst.increment();

    injector.inject<Foo>(() => fooFirst,
        type: InjectionType.lazySingleton, overrideInstance: true);

    var foo = injector.get<Foo>();
    foo.increment();

    expect(foo.value, 2);
  });

  test("try to get a singleton that was not injected", () {
    injector.removeAllInstances();
    Foo? foo;
    try {
      foo = injector.get<Foo>();
    } catch (e) {}

    expect(foo, null);
  });

  test("inject an instance and get it as brand new", () {
    final foo = Foo();

    injector.inject<Foo>(() => foo);

    expect(foo, isA<Foo>());
  });

  test("removeAllInstances() from Injector", () {
    final foo = Foo();
    final fooNew = FooNew();
    injector.inject<Foo>(() => foo);
    injector.inject<FooNew>(() => fooNew);

    injector.removeAllInstances();

    Foo? fooFromInjector;
    FooNew? fooNewFromInjector;
    try {
      fooFromInjector = injector.get<Foo>();
      fooNewFromInjector = injector.get<FooNew>();
    } catch (e) {}

    expect(fooFromInjector, null);
    expect(fooNewFromInjector, null);
  });

  test("test the remove of an injector", () {
    var fooFirst = Foo();

    fooFirst.increment();

    injector.inject<Foo>(() => fooFirst);

    var foo = injector.get<Foo>();
    foo.increment();

    expect(foo.value, 2);

    injector.remove<Foo>();

    Foo? fooAgain;
    try {
      fooAgain = injector.get<Foo>();
    } catch (e) {}

    expect(fooAgain, null);
  });

  test("test inject without type", () {
    injector.removeAllInstances();

    var fooNew = FooNew();
    fooNew.value = "type test";
    injector.inject(() => fooNew);
    var foo = Foo();
    foo.value = 1;
    injector.inject(() => foo);

    var fooNewAfterGet = injector.get<FooNew>();
    var fooAfterGet = injector.get<Foo>();

    expect(fooNewAfterGet, isA<FooNew>());
    expect(fooNewAfterGet.value, "type test");

    expect(fooAfterGet, isA<Foo>());
    expect(fooAfterGet.value, 1);
  });

  test("Reset an instance", () {
    injector.removeAllInstances();

    injector.inject(() => Foo());

    final foo = injector.get<Foo>();

    foo.increment(); // 1
    foo.increment(); // 2

    injector.reset<Foo>();

    expect(injector.get<Foo>().value, 0);
  });

  test("Reset all instances", () {
    injector.removeAllInstances();

    injector.inject(() => Foo());
    injector.inject(() => FooNew());

    final foo = injector.get<Foo>();
    final fooNew = injector.get<FooNew>();

    foo.increment(); // 1
    foo.increment(); // 2

    fooNew.giveMeValue();

    injector.resetAllInstances();

    expect(injector.get<Foo>().value, 0);
    expect(injector.get<FooNew>().value.isEmpty, true);
  });
}

class Foo {
  int value = 0;

  void increment() => value++;
}

class FooNew {
  String value = '';

  void giveMeValue() => value = "value of FooNew";
}
