<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.io.*, java.util.*" %>
<%
    String csvPath = "C:/Users/ABHIJEET JADHAV/IdeaProjects/project/src/blogs.csv";
    List<String[]> blogs = new ArrayList<>();

    try (BufferedReader br = new BufferedReader(new FileReader(csvPath))) {
        String line;
        while ((line = br.readLine()) != null) {
            List<String> fields = new ArrayList<>();
            boolean inQuotes = false;
            StringBuilder sb = new StringBuilder();
            for (char c : line.toCharArray()) {
                if (c == '"') {
                    inQuotes = !inQuotes;
                } else if (c == ',' && !inQuotes) {
                    fields.add(sb.toString().trim());
                    sb.setLength(0);
                } else {
                    sb.append(c);
                }
            }
            fields.add(sb.toString().trim());
            if (fields.size() == 4) {
                blogs.add(fields.toArray(new String[0]));
            }
        }
    } catch (IOException e) {
        out.println("<p>Error reading blog data.</p>");
    }

    int blogsPerPage = 5;
    int totalBlogs = blogs.size();
    int totalPages = (int) Math.ceil((double) totalBlogs / blogsPerPage);

    String pageParam = request.getParameter("page");
    int currentPage = 1;

    if (pageParam != null) {
        try {
            currentPage = Integer.parseInt(pageParam);
            if (currentPage < 1) currentPage = 1;
            if (currentPage > totalPages) currentPage = totalPages;
        } catch (NumberFormatException ignored) {}
    }

    int startIndex = totalBlogs - (currentPage * blogsPerPage);
    int endIndex = startIndex + blogsPerPage;

    if (startIndex < 0) startIndex = 0;
    if (endIndex > totalBlogs) endIndex = totalBlogs;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Blogging Platform</title>
    <link rel="stylesheet" href="css/styles.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f3f3f3;
            margin: 0;
            padding: 0;
        }
        .post {
            background-color: white;
            padding: 20px;
            margin: 30px;
            border-radius: 6px;
            box-shadow: 0 0 8px rgba(0,0,0,0.1);
        }
        .post-title {
            font-size: 24px;
            color: #333;
        }
        .post-meta {
            font-size: 14px;
            color: #777;
            margin-bottom: 15px;
        }
        .post-content {
            font-size: 16px;
            color: #444;
        }
        .post img {
            max-width: 100%;
            margin-top: 10px;
            border-radius: 4px;
        }
        .pagination {
            text-align: center;
            margin-bottom: 30px;
        }
        .pagination a {
            display: inline-block;
            padding: 8px 12px;
            margin: 0 4px;
            border: 1px solid #ccc;
            background-color: white;
            color: #333;
            text-decoration: none;
            border-radius: 4px;
        }
        .pagination a.active {
            background-color: #007bff;
            color: white;
            border-color: #007bff;
        }
    </style>
</head>
<body>
<div class="scene-container" aria-hidden="true">
    <div class="background"></div>
    <div class="stars" id="stars"></div>
    <div class="sun"></div>
    <div class="mountains">
        <div class="mountain mountain1"></div>
        <div class="mountain mountain2"></div>
        <div class="mountain mountain3"></div>
        <div class="mountain mountain4"></div>
        <div class="mountain mountain5"></div>
    </div>
    <div class="grid"></div>
    <div class="overlay"></div>
    <div class="vignette"></div>
</div>

<div class="page-container">
    <header>
        <h1 class="logo">SPIT BLOG</h1>
        <p class="tagline">SEE WHATS HAPPENING IN THE COLLEGE</p>
        <nav aria-label="Main Navigation">
            <a href="index.jsp" aria-current="page">Home</a>
            <a href="#">Articles</a>
            <a href="#">About</a>
            <a href="#">Contact</a>
            <a href="createBlog.jsp">Add Blog</a>
            <a href="login.jsp">Login/Register</a>
        </nav>
    </header>

    <main class="main-content">
        <h1>Welcome to My Blog!</h1>
        <% for (int i = endIndex - 1; i >= startIndex; i--) {
            String[] blog = blogs.get(i);
            String title = blog[0];
            String content = blog[1];
            String imageFile = blog[2];
            String timestamp = blog[3];
        %>
        <article class="post">
            <h2 class="post-title"><%= title %></h2>
            <div class="post-meta">
                <time class="post-date"><%= timestamp %></time>
            </div>
            <div class="post-content">
                <p><%= content %></p>
                <% if (!imageFile.isEmpty()) { %>
                    <img src="images/<%= imageFile %>" alt="Blog Image" />
                <% } %>
            </div>
        </article>
        <% } %>

        <nav class="pagination" aria-label="Pagination">
            <% if (currentPage > 1) { %>
                <a href="index.jsp?page=<%= currentPage - 1 %>" aria-label="Previous page">&laquo;</a>
            <% } %>

            <% for (int i = 1; i <= totalPages; i++) { %>
                <a href="index.jsp?page=<%= i %>" class="<%= (i == currentPage) ? "active" : "" %>"><%= i %></a>
            <% } %>

            <% if (currentPage < totalPages) { %>
                <a href="index.jsp?page=<%= currentPage + 1 %>" aria-label="Next page">&raquo;</a>
            <% } %>
        </nav>
    </main>

    <aside class="sidebar">
        <section class="widget">
            <h3 class="widget-title">Search</h3>
            <form class="search-form" role="search">
                <label for="search-input" class="visually-hidden">Search the blog</label>
                <input type="search" id="search-input" class="search-input" placeholder="Search...">
                <button type="submit" class="search-button">Go</button>
            </form>
        </section>

        <section class="widget">
            <h3 class="widget-title">Categories</h3>
            <nav aria-label="Categories">
                <ul class="categories-list">
                    <li><a href="#">Synthwave Music</a></li>
                    <li><a href="#">Retro Gaming</a></li>
                    <li><a href="#">Digital Art</a></li>
                    <li><a href="#">Cyberpunk Culture</a></li>
                    <li><a href="#">Technology</a></li>
                    <li><a href="#">Film Reviews</a></li>
                </ul>
            </nav>
        </section>

        <section class="widget">
            <h3 class="widget-title">Recent Posts</h3>
            <nav aria-label="Recent Posts">
                <ul class="recent-posts-list">
                    <li><a href="#">The Evolution of VR Technology</a></li>
                    <li><a href="#">Top 10 Synthwave Albums of 2024</a></li>
                    <li><a href="#">The Art of Pixel Animation</a></li>
                    <li><a href="#">Interview: The Midnight</a></li>
                    <li><a href="#">Neon and Chrome: Aesthetic Guide</a></li>
                </ul>
            </nav>
        </section>
    </aside>
</div>

<footer>
    <nav class="footer-links" aria-label="Footer Navigation">
        <a href="#">About</a>
        <a href="#">Contact</a>
        <a href="#">Privacy Policy</a>
        <a href="#">Terms of Service</a>
    </nav>
    <p class="copyright">© 2025 Retrowave Blog. All rights reserved.</p>
</footer>
</body>
</html>
