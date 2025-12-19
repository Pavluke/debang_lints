# Debang Lints

[![Pub](https://img.shields.io/pub/v/debang_lints.svg)](https://pub.dartlang.org/packages/debang_lints)

[En](README.md) | **Ru**

Кастомный плагин анализатора Dart, который проверяет минимальную длину сообщений
для `debang()`.

## О пакете Debang

[`debang`](https://github.com/pavluke/debang) — это библиотека для отладки,
предоставляющая расширение `.debang()` для nullable-типов с
сообщениями-утверждениями и конструктор `Debang()` для значений по умолчанию.
Этот линтер обеспечивает описательность и осмысленность всех
сообщений-утверждений.

## Описание

Плагин помогает поддерживать качество кода, гарантируя, что все отладочные
сообщения, переданные в `debang()`, являются описательными и полезными. Короткие
невнятные сообщения вроде `''` (пустая строка) или `'не будет null'` помечаются
как ошибки, побуждая разработчиков писать осмысленный отладочный вывод.

## Возможности

- ✅ Проверяет длину сообщений для конструктора `Debang()`
- ✅ Проверяет длину сообщений для расширения `.debang()`
- ✅ Работает в IDE (VS Code, IntelliJ, Android Studio)
- ✅ Работает с `dart analyze` CLI

## Установка

### 1. Добавьте в проект

**analysis_options.yaml:**

```yaml
plugins:
  debang_lints: ^1.0.0
```

### 2. Перезапустите Analysis Server

Выполните `dart pub get`, затем:

**VS Code:** Command Palette → `Dart: Restart Analysis Server`

**IntelliJ/Android Studio:** File → Invalidate Caches / Restart

## Примеры использования

### ❌ Плохо (вызывает ошибку)

```dart
import 'package:debang/debang.dart';

void main() {
  int? value;
  value.debang('Не будет null.');  // Ошибка: сообщение слишком короткое
}
```

### ✅ Хорошо (проходит проверку)

```dart
import 'package:debang/debang.dart';

void main() {
  int? value;
  value.debang('Переменная не будет null, поскольку после авторизации значение будет записано в локальное хранилище.');  // OK
}
```

## Changelog

Список изменений доступен в файле
[CHANGELOG.md](https://github.com/pavluke/debang_lints/blob/main/CHANGELOG.md)

## Contributions

Не стесняйтесь вносить свой вклад в этот проект.

Если вы обнаружили ошибку или хотите добавить новую функцию, но не знаете, как
ее исправить/внедрить, пожалуйста, напишите в
[issues](https://github.com/pavluke/debang_lints/issues). Если вы исправили
ошибку или внедрили какую-либо функцию, пожалуйста, сделайте
[pull request](https://github.com/pavluke/debang_lints/pulls).

## Лицензия

MIT License - см. файл LICENSE
