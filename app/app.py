from flask import Flask, render_template

from database import get_db_connection

app = Flask(__name__)

@app.route("/")
def home():
    connection = get_db_connection()

    try:
        cursor = connection.cursor()

        cursor.execute(
            "SELECT name, age, email FROM users ORDER BY id LIMIT 1;"
        )

        user = cursor.fetchone()

        cursor.close()

        return render_template("index.html", user=user)

    finally:
        connection.close()


@app.route("/health")
def health():
    return {"status": "healthy"}


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)