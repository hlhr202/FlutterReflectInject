import './reflector.dart';
import 'package:reflectable/reflectable.dart';

class Injector {
  final Map<int, dynamic> _instanceMap = new Map<int, dynamic>();

  T getSingleton<T>(
      {List arguments,
      String constructor,
      Map<Symbol, dynamic> namedArguments}) {
    if (T == null) {
      throw new ArgumentError("type: $T");
    }
    if (constructor == null) {
      constructor = "";
    }
    if (arguments == null) {
      arguments = const [];
    }

    ClassMirror typeMirror = reflector.reflectType(T);
    if (typeMirror is ClassMirror) {
      final hashCode = typeMirror.hashCode;
      if (_instanceMap.containsKey(hashCode)) {
        return _instanceMap[hashCode];
      } else {
        final T instance =
            typeMirror.newInstance(constructor, arguments, namedArguments);
        _instanceMap.putIfAbsent(hashCode, () => instance);
      }
      return _instanceMap[hashCode];
    } else {
      throw new ArgumentError("Cannot create the instance of the type '$T'.");
    }
  }
}
