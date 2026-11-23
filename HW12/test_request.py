import requests
import json

BASE = "http://127.0.0.1:5000"

result_file = open("results.txt", "w", encoding="utf-8")


def save(title, response):

    text = f"""
    {title}
    Status: {response.status_code}
    {json.dumps(response.json(), indent=4, ensure_ascii=False)}"""

    print(text)
    result_file.write(text)

#Отримати всіх наявних студентів (GET).
r = requests.get(BASE + "/students")
save("GET ALL", r)

#Створити трьох студентів (POST).
r = requests.post(
    BASE + "/students",
    json={
        "first_name": "Іван",
        "last_name": "Іванов",
        "age": 20
    }
)

save("POST 1", r)

r = requests.post(
    BASE + "/students",
    json={
        "first_name": "Степан",
        "last_name": "Степанов",
        "age": 21
    }
)

save("POST 2", r)

r = requests.post(
    BASE + "/students",
    json={
        "first_name": "Василь",
        "last_name": "Васильєв",
        "age": 19
    }
)

save("POST 3", r)

#Отримати інформацію про всіх наявних студентів (GET).
r = requests.get(BASE + "/students")
save("GET ALL", r)

#Оновити вік другого студента (PATCH).
r = requests.patch(
    BASE + "/students/2",
    json={
        "age": 30
    }
)

save("PATCH student 2", r)
#Отримати інформацію про другого студента (GET).
r = requests.get(BASE + "/students?id=2")
save("GET student 2", r)

#Оновити імʼя, прізвище та вік третього студента (PUT).
r = requests.put(
    BASE + "/students/3",
    json={
        "first_name": "Андрій",
        "last_name": "Коваленко",
        "age": 25
    }
)

save("PUT student 3", r)

#Отримати інформацію про третього студента (GET).
r = requests.get(BASE + "/students?id=3")
save("GET student 3", r)

#Отримати всіх наявних студентів (GET).
r = requests.get(BASE + "/students")
save("GET ALL", r)

#Видалити першого користувача (DELETE).
r = requests.delete(BASE + "/students/1")
save("DELETE student 1", r)

r = requests.get(BASE + "/students")
save("GET ALL", r)

result_file.close()