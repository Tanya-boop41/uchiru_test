# uchiru_test — Rails API for internship task

## Запуск локально с Docker

1. Построить образы и поднять контейнеры:
```bash
docker compose up --build
```
2. Выполнить миграции и загрузить стартовые данные (сиды):

```bash
docker compose exec web bundle exec rails db:create db:migrate db:seed
```

3. Сервис будет доступен на http://localhost:3000.

------------------------------
## Стартовые данные (Seeds)

При выполнении rails db:seed автоматически создаются:

- школа с id=1
- классы (1А и 1Б)
- несколько тестовых студентов

Эти данные находятся в файле db/seeds.rb

------------------------------
## Примеры запросов

### Создать студента:

```bash
curl -X POST http://localhost:3000/students \
  -H "Content-Type: application/json" \
  -d '{
    "student": {
      "first_name": "Иван",
      "last_name": "Иванович",
      "surname": "Иванов",
      "class_id": 1,
      "school_id": 1
    }
  }'
  ```

### Удалить студента:
```bash
curl -X DELETE http://localhost:3000/students/10 \
  -H "Authorization: Bearer <token_from_X-Auth-Token>"
```

### Список классов школы:
```bash
curl http://localhost:3000/schools/1/classes
```

### Список студентов класса:
```bash
curl http://localhost:3000/schools/1/classes/1/students
```