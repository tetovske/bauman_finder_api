# BaumanFinder API

Небольшое API позволяющее получить информацию об успеваемости студентов (пока что только ИУ6-3*), а также их данные при поступлении в МГТУ. Все работает с помощью JWT (немного криво, но все же работает).

## Регистрация

Запрос на регистрацию

```json
{ 
	"signup":
	{
		"email": "yay@email.com",
		"password": "password",
		"password_confirmation": "password"
	}
}
```

Ответ если все норм

```json
{
  "message": "user successfully registered!",
  "data": {
    "username": "yay",
    "token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2VtYWlsIjoieWF5QGVtYWlsLmNvbSIsImV4cGlyZXMiOiIyMDE5LTEyLTMxIDA0OjUzOjU5ICswMzAwIn0.hx8zb8WF2x0v0Kdy3n2bPSZOgtqKxNbMHpjwxxWG1WY"
  }
}
```
