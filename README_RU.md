# Debang Lints

[![Pub](https://img.shields.io/pub/v/debang_lints.svg)](https://pub.dartlang.org/packages/debang_lints)

[En](README.md) | **Ru**

Кастомный плагин анализатора Dart, который проверяет качество сообщений
для `debang()`.

## О пакете Debang

[`debang`](https://github.com/pavluke/debang) — это библиотека для отладки,
предоставляющая расширение `.debang()` для nullable-типов с
сообщениями-утверждениями и конструктор `Debang()` для значений по умолчанию.
Этот линтер обеспечивает описательность и осмысленность всех
сообщений-утверждений.

<p align="center">Для лучшего понимания работы перейдите на <a href="https://pavluke.github.io/packages/?pkg=debang_lints">демо</a> страницу</p>

<div align="center">
  <a href="https://pavluke.github.io/packages/?pkg=debang_lints" 
     style="background: #10ac84; color: white; padding: 12px 24px; 
            text-decoration: none; border-radius: 6px; 
            font-weight: bold; display: inline-block;">
    Открыть демо
  </a>
</div>

## Описание

Плагин помогает поддерживать качество кода, гарантируя, что все отладочные
сообщения, переданные в `debang()`, являются описательными и полезными. Короткие
невнятные сообщения вроде `''` (пустая строка) или `'не будет null'` помечаются
как ошибки, а сообщения без имени автора — помечаются отдельно, побуждая
разработчиков писать осмысленный и ответственный отладочный вывод.

## Правила

| Правило | Описание | По умолчанию |
|---|---|---|
| `debang_message_too_short` | Сообщение должно быть не короче заданного количества символов | отключено |
| `debang_missing_author` | Сообщение должно начинаться с имени автора `(username):` | отключено |

## Установка

### 1. Добавьте в `analysis_options.yaml`

```yaml
plugins:
  debang_lints: ^1.1.0
```

> **Важно:** В новой системе плагинов Dart линт-правила отключены по умолчанию.
> Каждое правило нужно явно включить в секции `diagnostics:`.

### 2. Перезапустите Analysis Server

Выполните `dart pub get`, затем:

**VS Code:** Command Palette → `Dart: Restart Analysis Server`

**IntelliJ/Android Studio:** File → Invalidate Caches / Restart

## Примеры использования

### `debang_message_too_short`

#### ❌ Плохо (вызывает ошибку)

```dart
import 'package:debang/debang.dart';

void main() {
  int? value;
  value.debang('Не будет null.');  // Ошибка: сообщение слишком короткое
}
```

#### ✅ Хорошо (проходит проверку)

```dart
import 'package:debang/debang.dart';

void main() {
  int? value;
  value.debang(
    'Переменная не будет null, поскольку после авторизации значение будет записано в локальное хранилище.'
  );  // OK
}
```

---

### `debang_missing_author`

Сообщение должно начинаться с `(username):` — по аналогии с соглашением `TODO(username):`.

#### ❌ Плохо (вызывает ошибку)

```dart
import 'package:debang/debang.dart';

void main() {
  int? value;
  value.debang('Не будет null после авторизации');  // Ошибка: отсутствует имя автора
}
```

#### ✅ Хорошо (проходит проверку)

```dart
import 'package:debang/debang.dart';

void main() {
  int? value;
  value.debang('(ivan): Не будет null, значение записывается после авторизации');  // OK
}
```

## Changelog

Список изменений доступен в файле
[CHANGELOG.md](https://github.com/pavluke/debang_lints/blob/main/CHANGELOG.md).

## Contributions

Не стесняйтесь вносить свой вклад в этот проект. Если вы обнаружили ошибку или
хотите добавить новую функцию, но не знаете, как её реализовать, пожалуйста,
напишите в [issues](https://github.com/pavluke/debang_lints/issues). Если вы
исправили ошибку или внедрили функцию, сделайте
[pull request](https://github.com/pavluke/debang_lints/pulls).

## Лицензия

MIT License — см. файл LICENSE.
