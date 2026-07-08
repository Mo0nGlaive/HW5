from flask import Flask, request, jsonify
import csv, os

app = Flask(__name__)

FILE_NAME = "students.csv"
FIELDS = ["id", "first_name", "last_name", "age"]


def init_csv():
    if not os.path.exists(FILE_NAME):
        with open(FILE_NAME, "w", newline="", encoding="utf-8") as f:
            writer = csv.DictWriter(f, fieldnames=FIELDS)
            writer.writeheader()


def read_students():
    init_csv()

    with open(FILE_NAME, newline="", encoding="utf-8") as f:
        reader = csv.DictReader(f)
        return list(reader)


def write_students(students):
    with open(FILE_NAME, "w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=FIELDS)
        writer.writeheader()
        writer.writerows(students)


def next_id(students):
    if not students:
        return 1
    return max(int(s["id"]) for s in students) + 1


init_csv()


@app.route("/students", methods=["GET"])
def get_students():

    students = read_students()

    student_id = request.args.get("id")
    last_name = request.args.get("last_name")

    if student_id:
        for s in students:
            if s["id"] == student_id:
                return jsonify(s)
        return jsonify({"error": "Student not found"}), 404

    if last_name:
        result = [s for s in students if s["last_name"] == last_name]

        if not result:
            return jsonify({"error": "Student not found"}), 404

        return jsonify(result)

    return jsonify(students)


@app.route("/students", methods=["POST"])
def create_student():

    data = request.json

    if not data:
        return jsonify({"error": "Empty body"}), 400

    allowed = {"first_name", "last_name", "age"}

    if set(data.keys()) != allowed:
        return jsonify({"error": "Invalid fields"}), 400

    students = read_students()

    student = {
        "id": str(next_id(students)),
        "first_name": data["first_name"],
        "last_name": data["last_name"],
        "age": str(data["age"])
    }

    students.append(student)
    write_students(students)

    return jsonify(student), 201


@app.route("/students/<int:id>", methods=["PUT"])
def update_student(id):

    data = request.json

    if not data:
        return jsonify({"error": "Empty body"}), 400

    allowed = {"first_name", "last_name", "age"}

    if set(data.keys()) != allowed:
        return jsonify({"error": "Invalid fields"}), 400

    students = read_students()

    for s in students:
        if int(s["id"]) == id:
            s["first_name"] = data["first_name"]
            s["last_name"] = data["last_name"]
            s["age"] = str(data["age"])

            write_students(students)
            return jsonify(s)

    return jsonify({"error": "Student not found"}), 404


@app.route("/students/<int:id>", methods=["PATCH"])
def patch_student(id):

    data = request.json

    if not data:
        return jsonify({"error": "Empty body"}), 400

    if set(data.keys()) != {"age"}:
        return jsonify({"error": "Only age can be updated"}), 400

    students = read_students()

    for s in students:
        if int(s["id"]) == id:
            s["age"] = str(data["age"])
            write_students(students)
            return jsonify(s)

    return jsonify({"error": "Student not found"}), 404


@app.route("/students/<int:id>", methods=["DELETE"])
def delete_student(id):

    students = read_students()

    for s in students:
        if int(s["id"]) == id:
            students.remove(s)
            write_students(students)

            return jsonify({
                "message": "Student deleted successfully"
            })

    return jsonify({"error": "Student not found"}), 404


if __name__ == "__main__":
    app.run(debug=True)