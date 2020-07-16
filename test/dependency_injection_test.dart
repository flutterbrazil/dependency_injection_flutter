import 'package:dependency_injection_flutter/src/injector.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Injector injector;

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
    var foo = injector.get<Foo>();

    expect(foo, null);
  });

  test("inject an instance and get it as brand new", () {
    final foo = Foo();

    injector.inject<Foo>(() => foo);

    expect(foo, isInstanceOf<Foo>());
  });

  test("removeAllInstances() from Injector", () {
    final foo = Foo();
    final fooNew = FooNew();
    injector.inject<Foo>(() => foo);
    injector.inject<FooNew>(() => fooNew);

    injector.removeAllInstances();

    var fooFromInjector = injector.get<Foo>();
    var fooNewFromInjector = injector.get<FooNew>();
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

    var fooAgain = injector.get<Foo>();

    expect(fooAgain, null);
  });

  test("test the args", () {
    injector.removeAllInstances();
    injector.inject<Foo>(() => Foo());

    var foo =
        injector.get<Foo>(args: {'test_key': 1, 'foo_new_instance': FooNew()});

    expect(foo.args['test_key'], 1);
    expect(foo.args['foo_new_instance'], isInstanceOf<FooNew>());
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

    expect(fooNewAfterGet, isInstanceOf<FooNew>());
    expect(fooNewAfterGet.value, "type test");

    expect(fooAfterGet, isInstanceOf<Foo>());
    expect(fooAfterGet.value, 1);
  });
}

class Foo implements InjectionArgs {
  int value = 0;

  void increment() => value++;

  @override
  Map<String, dynamic> args = <String, dynamic>{};
}

class FooNew {
  String value = '';

  void giveMeValue() => value = "value of FooNew";
}
