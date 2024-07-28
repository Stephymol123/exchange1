<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mary's Exchange Agency</title>
    <meta name="description" content="Mary's Exchange is your go-to platform for swapping items with ease and trust. Join now to discover the joy of item exchange.">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        :root {
            --primary-color: #14397d;
            --secondary-color: #d7eaf3;
            --accent-color: #ffc107;
            --text-color: #333;
            --light-text-color: #6c757d;
        }
        body {
            font-family: 'Roboto', sans-serif;
            color: var(--text-color);
            background-color: #f8f9fa;
        }
        .hero {
            background: linear-gradient(rgba(20, 57, 125, 0.7), rgba(20, 57, 125, 0.7)), url('https://www.shutterstock.com/image-illustration/currency-exchange-money-foreign-transactions-260nw-1976307275.jpg');
            background-size: cover;
            background-position: center;
            color: #fff;
            padding: 100px 0;
            text-align: center;
        }
        .hero h1 {
            font-size: 3.5rem;
            font-weight: 700;
            margin-bottom: 1rem;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
        }
        .hero p {
            font-size: 1.25rem;
            margin-bottom: 2rem;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.5);
        }
        .btn-custom {
            padding: 12px 30px;
            font-size: 1.1rem;
            font-weight: 600;
            text-transform: uppercase;
            border-radius: 30px;
            transition: all 0.3s ease;
        }
        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }
        .btn-primary:hover {
            background-color: #0f2c99;
            border-color: #0f2c99;
        }
        .btn-secondary {
            background-color: var(--secondary-color);
            border-color: var(--secondary-color);
            color: var(--primary-color);
        }
        .btn-secondary:hover {
            background-color: #b9d7e0;
            border-color: #b9d7e0;
        }
        .section-title {
            color: var(--primary-color);
            font-weight: 700;
            margin-bottom: 2rem;
            text-align: center;
            position: relative;
            padding-bottom: 15px;
        }
        .section-title::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 50px;
            height: 3px;
            background-color: var(--accent-color);
        }
        .featured-items .card {
            height: 100%;
            display: flex;
            flex-direction: column;
        }
        .featured-items .card-body {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }
        .featured-items .card-img-top {
            height: 200px;
            object-fit: cover;
        }
        .featured-items .card-title {
            color: var(--primary-color);
            font-weight: 600;
        }
        .featured-items .card-text {
            font-size: 0.9rem;
            margin-bottom: 0.5rem;
            max-height: 3.6em;
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
        }
        .featured-items .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.15);
        }
        .alert-info {
            background-color: var(--secondary-color);
            border-color: var(--primary-color);
            color: var(--primary-color);
        }
        .how-it-works {
            background-color: var(--secondary-color);
            padding: 80px 0;
        }
        .how-it-works .icon-box {
            text-align: center;
            padding: 30px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
        }
        .how-it-works .icon-box:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.15);
        }
        .how-it-works img {
            height: 80px;
            margin-bottom: 20px;
        }
        .testimonials {
            background-color: var(--primary-color);
            color: #fff;
            padding: 80px 0;
        }
        .testimonials blockquote {
            font-size: 1.1rem;
            font-style: italic;
        }
        .testimonials .blockquote-footer {
            color: var(--accent-color);
        }
    </style>
</head>
<body>

<jsp:include page="navbar.jsp"/>

<!-- Hero Section -->
<section class="hero">
    <div class="container">
        <h1 style="color: #fff">Mary's Exchange</h1>
        <p class="lead">Swap.SHARE.Smile</p>
    </div>
</section>




<!-- User Testimonials -->
<section class="testimonials">
    <div class="container">
        <h2 class="section-title">User Experiences</h2>
        <div id="testimonialsCarousel" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <blockquote class="blockquote text-center">
                        <p class="mb-0">"MangoEx has made swapping items so easy and fun. Highly recommend it!"</p>
                        <footer class="blockquote-footer">Jane Doe</footer>
                    </blockquote>
                </div>
                <div class="carousel-item">
                    <blockquote class="blockquote text-center">
                        <p class="mb-0">"Great platform with a friendly community. I found exactly what I needed."</p>
                        <footer class="blockquote-footer">John Smith</footer>
                    </blockquote>
                </div>
                <div class="carousel-item">
                    <blockquote class="blockquote text-center">
                        <p class="mb-0">"Easy to use and lots of interesting items available for exchange."</p>
                        <footer class="blockquote-footer">Sarah Lee</footer>
                    </blockquote>
                </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#testimonialsCarousel" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#testimonialsCarousel" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </button>
        </div>
    </div>
    </div>
</section>

<jsp:include page="footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
