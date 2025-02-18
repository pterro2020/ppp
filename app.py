from flask import Flask, request, redirect, render_template_string

app = Flask(__name__)
app.secret_key = "supersecretkey"  # Небезопасно! Для демонстрации.

# База данных "в памяти" (для примера)
users = {
    "admin": "admin123",
    "user": "password"
}

@app.route("/")
def home():
    return "<h1>Welcome to PPP App!</h1>"

@app.route("/login", methods=["GET", "POST"])
def login():
    if request.method == "POST":
        username = request.form.get("username")
        password = request.form.get("password")
        if users.get(username) == password:
            return f"<h2>Welcome, {username}!</h2>"
        else:
            return "<h2>Invalid credentials!</h2>"
    return '''
        <form method="post">
            <input type="text" name="username" placeholder="Username">
            <input type="password" name="password" placeholder="Password">
            <button type="submit">Login</button>
        </form>
    '''

@app.route("/search")
def search():
    query = request.args.get("q", "")
    # Уязвимость к XSS (для демонстрации)
    return f"<h2>Search results for: {query}</h2>"

@app.route("/profile/<user_id>")
def profile(user_id):
    # Уязвимость к SQL-инъекции (имитация)
    return f"<h2>Profile page for user ID: {user_id}</h2>"

if __name__ == "__main__":
    # Важно: host="0.0.0.0" для доступа извне контейнера
    app.run(host="0.0.0.0", port=8000, debug=True)
