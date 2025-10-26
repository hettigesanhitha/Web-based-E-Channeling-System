<%@page import="com.hms.db.DBConnection"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- for jstl tag -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- end of jstl tag -->

<%@page isELIgnored="false"%>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Home Page | Doctor Patient Portal</title>
	<%@include file="component/allcss.jsp"%>

	<!-- Custom CSS for this page -->
	<style type="text/css">
		* {
			margin: 0;
			padding: 0;
			box-sizing: border-box;
		}

		body {
			font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Oxygen', 'Ubuntu', sans-serif;
			background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
			color: #2c3e50;
			min-height: 100vh;
		}

		.page-wrapper {
			max-width: 1400px;
			margin: 0 auto;
			padding: 30px 20px;
		}

		.page-header {
			margin-bottom: 40px;
			text-align: center;
		}

		.page-header h1 {
			font-size: 2.5rem;
			color: #1a5490;
			font-weight: 700;
			letter-spacing: -0.5px;
			margin-bottom: 10px;
		}

		.page-header p {
			color: #7f8c8d;
			font-size: 1rem;
		}

		.section {
			background: white;
			border-radius: 12px;
			box-shadow: 0 4px 6px rgba(0, 0, 0, 0.07), 0 10px 20px rgba(0, 0, 0, 0.05);
			margin-bottom: 40px;
			padding: 0;
			overflow: hidden;
		}

		.section-header {
			background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
			color: white;
			padding: 25px 30px;
			text-align: center;
		}

		.section-header h2 {
			font-size: 1.5rem;
			font-weight: 600;
			letter-spacing: -0.3px;
			margin: 0;
		}

		.section-content {
			padding: 30px;
		}

		.carousel-inner img {
			height: 500px;
			object-fit: cover;
			width: 100%;
		}

		.carousel-control-prev-icon,
		.carousel-control-next-icon {
			background-color: rgba(44, 62, 80, 0.5);
			border-radius: 50%;
			padding: 15px;
		}

		.carousel-indicators button {
			background-color: #7f8c8d;
		}

		.carousel-indicators .active {
			background-color: #667eea;
		}

		.feature-card {
			background: white;
			border-radius: 8px;
			box-shadow: 0 4px 6px rgba(0, 0, 0, 0.07);
			padding: 20px;
			height: 100%;
			transition: transform 0.2s ease;
		}

		.feature-card:hover {
			transform: translateY(-5px);
		}

		.feature-card h3 {
			font-size: 1.2rem;
			font-weight: 600;
			color: #1a5490;
			margin-bottom: 10px;
		}

		.feature-card p {
			font-size: 0.95rem;
			color: #2c3e50;
		}

		.team-card {
			background: white;
			border-radius: 8px;
			box-shadow: 0 4px 6px rgba(0, 0, 0, 0.07);
			padding: 20px;
			text-align: center;
			height: 100%;
			transition: transform 0.2s ease;
		}

		.team-card:hover {
			transform: translateY(-5px);
		}

		.team-card img {
			border-radius: 8px;
			width: 100%;
			height: 250px;
			object-fit: cover;
			margin-bottom: 15px;
		}

		.team-card h3 {
			font-size: 1.2rem;
			font-weight: 600;
			color: #2c3e50;
			margin-bottom: 5px;
		}

		.team-card p {
			font-size: 0.85rem;
			color: #7f8c8d;
		}

		.feature-image {
			border-radius: 8px;
			width: 100%;
			height: 400px;
			object-fit: cover;
		}

		hr {
			border: 0;
			height: 1px;
			background: #e0e0e0;
			margin: 40px 0;
		}

		@media (max-width: 768px) {
			.page-header h1 {
				font-size: 1.8rem;
			}

			.section-content {
				padding: 20px;
			}

			.carousel-inner img {
				height: 300px;
			}

			.feature-card h3 {
				font-size: 1.1rem;
			}

			.feature-card p {
				font-size: 0.85rem;
			}

			.team-card img {
				height: 200px;
			}

			.team-card h3 {
				font-size: 1.1rem;
			}

			.team-card p {
				font-size: 0.8rem;
			}

			.feature-image {
				height: 300px;
			}
		}
	</style>
	<!-- End of custom CSS -->
</head>
<body>
<%@include file="component/navbar.jsp"%>

<div class="page-wrapper">
	<!-- Carousel -->
	<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
		<div class="carousel-indicators">
			<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
			<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
			<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
			<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="3" aria-label="Slide 4"></button>
		</div>
		<div class="carousel-inner">
			<div class="carousel-item active">
				<img src="img/doctor_2.jpg" class="d-block w-100" alt="Doctor Image">
			</div>
			<div class="carousel-item">
				<img src="img/doctor_1.jpg" class="d-block w-100" alt="Doctor Image">
			</div>
			<div class="carousel-item">
				<img src="img/hospital4.jpg" class="d-block w-100" alt="Hospital Image">
			</div>
			<div class="carousel-item">
				<img src="img/doctor_3.jpg" class="d-block w-100" alt="Doctor Image">
			</div>
		</div>
		<button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
			<span class="carousel-control-prev-icon" aria-hidden="true"></span>
			<span class="visually-hidden">Previous</span>
		</button>
		<button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
			<span class="carousel-control-next-icon" aria-hidden="true"></span>
			<span class="visually-hidden">Next</span>
		</button>
	</div>

	<!-- Features Section -->
	<div class="section">
		<div class="section-header">
			<h2>🔑 Key Features of Our Portal</h2>
		</div>
		<div class="section-content">
			<div class="row">
				<div class="col-md-8">
					<div class="row">
						<div class="col-md-6 mb-4">
							<div class="feature-card">
								<h3>11,000+ Healing Hands</h3>
								<p>Largest network of the world’s finest and brightest medical experts who provide compassionate care using outstanding expertise.</p>
							</div>
						</div>
						<div class="col-md-6 mb-4">
							<div class="feature-card">
								<h3>Most Advanced Healthcare Technology</h3>
								<p>E-Hospitals has been the pioneer in bringing ground-breaking health care technologies to Bangladesh.</p>
							</div>
						</div>
						<div class="col-md-6 mb-4">
							<div class="feature-card">
								<h3>Best Clinical Outcomes</h3>
								<p>Leveraging its vast medical expertise & technological advantage, E-Hospitals has consistently delivered best in class clinical outcomes.</p>
							</div>
						</div>
						<div class="col-md-6 mb-4">
							<div class="feature-card">
								<h3>500+ Pharmacies</h3>
								<p>E-Hospital Pharmacy is our first, largest and most trusted branded pharmacy network, with over 500 plus outlets covering the entire nation.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<img src="img/doctor_1.jpg" alt="Doctor Image" class="feature-image">
				</div>
			</div>
		</div>
	</div>

	<!-- Team Section -->
	<div class="section">
		<div class="section-header">
			<h2>👥 Our Team</h2>
		</div>
		<div class="section-content">
			<div class="row">
				<div class="col-md-3 mb-4">
					<div class="team-card">
						<img src="img/doc1.jpg" alt="Dr. John">
						<h3>Dr. John</h3>
						<p>CEO & Chairman</p>
					</div>
				</div>
				<div class="col-md-3 mb-4">
					<div class="team-card">
						<img src="img/doc2.jpg" alt="Dr. Brad">
						<h3>Dr. Brad</h3>
						<p>Chief Doctor</p>
					</div>
				</div>
				<div class="col-md-3 mb-4">
					<div class="team-card">
						<img src="img/doc3.jpg" alt="Dr. Jennifer">
						<h3>Dr. Jennifer</h3>
						<p>Chief Doctor</p>
					</div>
				</div>
				<div class="col-md-3 mb-4">
					<div class="team-card">
						<img src="img/doc4.jpg" alt="Dr. Maria">
						<h3>Dr. Maria</h3>
						<p>Dean</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<%@include file="/component/footer.jsp"%>

<!-- Footer -->
<%@include file="component/footer.jsp"%>
<!-- End Footer -->
</body>
</html>