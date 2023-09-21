from flask import Flask
app = Flask(__name__)
@app.route("/service-1")
def hello():
    return "Hello World from service-1!"
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=int("5001"), debug=True)
