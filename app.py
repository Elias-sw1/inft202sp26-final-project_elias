import os

import psycopg2
from dotenv import load_dotenv
from flask import Flask, render_template, request
from psycopg2.extras import RealDictCursor

load_dotenv()

app = Flask(__name__)


def get_connection():
    return psycopg2.connect(
        dbname=os.getenv("DB_NAME", "final"),
        user=os.getenv("DB_USER", "postgres"),
        password=os.getenv("DB_PASSWORD", "postgres"),
        host=os.getenv("DB_HOST", "postgres"),
        port=os.getenv("DB_PORT", "5432"),
    )


def fetch_all(sql, params=None):
    with get_connection() as conn:
        with conn.cursor(cursor_factory=RealDictCursor) as cur:
            cur.execute(sql, params or [])
            return cur.fetchall()


def fetch_one(sql, params=None):
    rows = fetch_all(sql, params)
    return rows[0] if rows else {}


@app.route("/")
def index():
    stats = fetch_one(
        """
        SELECT
            COUNT(*) AS total_movies,
            COUNT(*) FILTER (WHERE release_date IS NOT NULL) AS dated_movies,
            ROUND(AVG(runtime) FILTER (WHERE runtime > 0), 1) AS avg_runtime,
            COUNT(*) FILTER (WHERE s.revenue > 0) AS movies_with_revenue
        FROM movie
        JOIN movie_stats s ON movie.movie_id = s.movie_id;
        """
    )

    runtime_counts = fetch_all(
        """
        SELECT runtime, COUNT(*) AS movie_count
        FROM movie
        WHERE runtime > 0
        GROUP BY runtime
        ORDER BY COUNT(*) DESC
        LIMIT 10;
        """
    )

    average_revenue = fetch_all(
        """
        SELECT movie.runtime, ROUND(AVG(movie_stats.revenue), 0) AS avg_revenue
        FROM movie
        JOIN movie_stats ON movie.movie_id = movie_stats.movie_id
        WHERE movie_stats.revenue > 0 AND movie.runtime > 0
        GROUP BY movie.runtime
        ORDER BY AVG(movie_stats.revenue) DESC
        LIMIT 10;
        """
    )

    return render_template(
        "index.html",
        stats=stats,
        runtime_counts=runtime_counts,
        average_revenue=average_revenue,
    )


@app.route("/browse")
def browse():
    q = request.args.get("q", "").strip()
    page = max(request.args.get("page", 1, type=int), 1)
    per_page = 25
    offset = (page - 1) * per_page

    where = ""
    params = []
    if q:
        where = "WHERE LOWER(movie.title) LIKE LOWER(%s)"
        params.append(f"%{q}%")

    rows = fetch_all(
        f"""
        SELECT
            movie.movie_id,
            movie.title,
            movie.release_date,
            movie.runtime,
            movie_stats.popularity,
            movie_stats.vote_average,
            movie_stats.vote_count,
            movie_stats.budget,
            movie_stats.revenue
        FROM movie
        JOIN movie_stats ON movie.movie_id = movie_stats.movie_id
        {where}
        ORDER BY movie.title
        LIMIT %s OFFSET %s;
        """,
        params + [per_page, offset],
    )

    total = fetch_one(
        f"""
        SELECT COUNT(*) AS count
        FROM movie
        JOIN movie_stats ON movie.movie_id = movie_stats.movie_id
        {where};
        """,
        params,
    ).get("count", 0)

    return render_template(
        "browse.html",
        rows=rows,
        q=q,
        page=page,
        total=total,
        has_next=offset + per_page < total,
    )


@app.route("/insights")
def insights():
    discussion_one = fetch_all(
        """
        SELECT movie.title, movie_stats.vote_average, movie_stats.vote_count
        FROM movie
        JOIN movie_stats ON movie.movie_id = movie_stats.movie_id
        WHERE movie_stats.vote_average > 9 AND movie_stats.vote_count < 10
        ORDER BY movie_stats.vote_average DESC, movie_stats.vote_count ASC
        LIMIT 25;
        """
    )
    discussion_two = fetch_all(
        """
        SELECT movie.title, movie.runtime, movie_stats.popularity
        FROM movie
        JOIN movie_stats ON movie.movie_id = movie_stats.movie_id
        WHERE movie.runtime > 0
        ORDER BY movie.runtime DESC
        LIMIT 25;
        """
    )

    cards = [
        {
            "question": "Which movies have very high vote averages but very low vote counts?",
            "explanation": "Yes, its on par with Cinemascore, and how Letterboxd users rate. When only a few people vote, it can limit the variety of opinions. This could be misleading because it could be due to influence culture.",
            "rows": discussion_one,
        },
        {
            "question": "Do longer movies tend to have higher popularity scores?",
            "explanation": "The longest movies also high popularity either its a superhero film or a indie epic. The pattern is diverse and mixed. That suggest that no more the runtime or popularity, a movie can be popularity or not, regetless of the runtime.",
            "rows": discussion_two,
        },
    ]
    return render_template("insights.html", cards=cards)


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
