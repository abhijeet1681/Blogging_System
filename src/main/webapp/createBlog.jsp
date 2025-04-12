<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Create Blog</title>
    <link href="https://fonts.cdnfonts.com/css/outrun-future" rel="stylesheet" />
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        :root {
            --neon-pink: #ff00cc;
            --neon-blue: #36e2f8;
            --neon-purple: #b026ff;
            --dark-bg: #0f0c29;
        }

        body {
            background-color: var(--dark-bg);
            color: white;
            font-family: 'Outrun', sans-serif;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px 20px;
        }

        h2 {
            text-align: center;
            font-size: 2.5rem;
            color: var(--neon-blue);
            text-shadow: 0 0 10px var(--neon-blue);
            margin-bottom: 30px;
        }

        form {
            background: rgba(0, 0, 0, 0.5);
            padding: 30px;
            border-radius: 15px;
            max-width: 500px;
            width: 100%;
            border: 1px solid rgba(54, 226, 248, 0.4);
            box-shadow: 0 0 20px rgba(176, 38, 255, 0.3);
        }

        label {
            display: block;
            margin-bottom: 10px;
            font-weight: bold;
            color: var(--neon-pink);
        }

        input[type="text"],
        textarea,
        input[type="file"] {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid var(--neon-purple);
            border-radius: 5px;
            background: rgba(255, 255, 255, 0.1);
            color: white;
        }

        input[type="submit"] {
            background: linear-gradient(to right, var(--neon-purple), var(--neon-pink));
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
            font-size: 1rem;
            width: 100%;
            transition: all 0.3s;
            box-shadow: 0 0 15px rgba(255, 0, 204, 0.6);
        }

        input[type="submit"]:hover {
            background: linear-gradient(to right, var(--neon-pink), var(--neon-purple));
            box-shadow: 0 0 25px rgba(255, 0, 204, 0.8);
            transform: scale(1.02);
        }

        @media (max-width: 600px) {
            h2 {
                font-size: 2rem;
            }

            form {
                padding: 20px;
            }
        }
    </style>
</head>
<body>

<div>
    <h2>Post a Blog</h2>

    <form action="CreateBlogServlet" method="post" enctype="multipart/form-data">
        <label>Blog Title:</label>
        <input type="text" name="title" required />

        <label>Content:</label>
        <textarea name="content" rows="6" required></textarea>

        <label>Optional Image:</label>
        <input type="file" name="image" accept="image/*" />

        <input type="submit" value="Submit Blog" />
    </form>
</div>

</body>
</html>
