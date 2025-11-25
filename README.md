# uchiru_test — Rails API for internship task

## Запуск локально с Docker

1. Построить образы и поднять контейнеры:
```bash
docker compose up --build
```
2. Сервис будет доступен на http://localhost:3000.

Примеры запросов
Создать студента:

```bash
curl -X POST http://localhost:3000/students \
  -H "Content-Type: application/json" \
  -d '{"first_name":"Иван","last_name":"Иванов","surname":"Иванович","class_id":1,"school_id":1}'
  ```

Ответ 201 + header X-Auth-Token.
Удалить студента:
```bash
curl -X DELETE http://localhost:3000/students/10 \
  -H "Authorization: Bearer <token_from_X-Auth-Token>"
```

Список классов школы:
```bash
curl http://localhost:3000/schools/1/classes
```

Список студентов класса:
```bash
curl http://localhost:3000/schools/1/classes/1/students
```

Примечания
Для генерации токена используется SHA256(student_id + salt). По умолчанию salt берётся из Rails.application.credentials.auth_salt или переменной окружения AUTH_SALT.