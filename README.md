# RecSystemT_T

## Описание

**RESTaurant** — это iOS-приложение, которое помогает пользователю подобрать рестораны на основе выбранных кухонь. Приложение также анализирует близость ресторанов друг к другу по станциям метро, что позволяет находить наиболее удобные варианты для встреч и посещения.

## Основные возможности

- Получение списка рекомендуемых ресторанов
- Анализ и визуализация близости ресторанов по выбранной кухне
- Детальная информация о каждом ресторане

## Структура проекта

```
App/
Base.lproj/
CafeListPage/
    ├── Presenter/
    ├── View/
    └── SceneAssembler.swift
MainPage/
    ├── Presenter/
    ├── View/
    └── SceneAssembler.swift
MapPage/
    ├── Presenter/
    ├── View/
    └── SceneAssembler.swift
PlacePage/
    ├── Presenter/
    ├── View/
    └── SceneAssembler.swift
ResultPage/
    ├── Presenter/
    ├── View/
    └── SceneAssembler.swift
Router/
Models/
Info.plist
```

- Все папки с окончанием `Page` содержат подпапки `Presenter`, `View` и файл `SceneAssembler.swift`.
- Логика навигации вынесена в папку `Router`.
- Модели данных находятся в папке `Models`.
- Основные ресурсы и настройки — в `Base.lproj` и `Info.plist`.

## Тесты

В проекте реализованы модульные тесты:
- **MainTest** — тестирование главной страницы и бизнес-логики.
- **PlaceTest** — тестирование функционала страницы ресторана.

Для запуска тестов используйте стандартные средства Xcode (`Cmd+U`).

## Требования

- Xcode 14+
- iOS 15.0+

## Установка и запуск

1. Клонируйте репозиторий:
   ```bash
   git clone https://github.com/yourusername/restaurant-recommender.git
   ```
2. Откройте проект в Xcode.
3. Соберите и запустите приложение на симуляторе или устройстве.

## Технологии

- Swift
- UIKit
- Архитектура MVP с разделением на Presenter, View, SceneAssembler
