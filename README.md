# Тестовое приложение
## Изображения

<p align="center">
  <img src="assets/screens/screen0.png" alt="Splash screen" width="200" />
  <img src="assets/screens/screen1.png" alt="Onboarding screen" width="200" />
  <img src="assets/screens/screen2.png" alt="Главная страница" width="200" />
</p>

## Установка и запуск проекта

### Предварительные требования

- Установлен Flutter SDK (см. официальную документацию по установке для вашей ОС).
- Установлен Git.
- Установлена IDE (Android Studio, VS Code, IntelliJ IDEA) или возможность запускать команды из терминала.
- Настроенные эмулятор/симулятор или реальное устройство (Android / iOS).

### Клонирование репозитория
```
git clone https://github.com/Drimkaa/TestProjectFlutter.git
cd TestProjectFlutter
```
### Установка зависимостей
```
flutter pub get
```
### Запуск приложения в режиме разработки (debug)
```
flutter run
```
Команда автоматически найдёт подключённое устройство или эмулятор и запустит приложение.

### Запуск в режиме release (Android)
```
flutter run --release
```

Или собрать APK:
```
flutter build apk --release
```
APK будет лежать по пути:
```
build/app/outputs/flutter-apk/app-release.apk
```
Его можно установить на устройство вручную или через `adb install`.
