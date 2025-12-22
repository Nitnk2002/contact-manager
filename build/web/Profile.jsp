<%-- 
    Document   : Profile
    Created on : 14-Dec-2025, 3:16:49 pm
    Author     : Nitra
--%>

<%@page import="model.UserModel"%>
<%@page import="dto.UserDTO"%>
<%@page import="model.ContactModel"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile | Connect</title>
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        /* --- 1. SHARED STYLES (Matches Dashboard) --- */
        :root {
            --primary: #4f46e5;
            --primary-light: #eef2ff;
            --text-dark: #111827;
            --text-gray: #6b7280;
            --bg-body: #f3f4f6;
            --bg-white: #ffffff;
            --border: #e5e7eb;
            --sidebar-width: 70px;
        }

        * { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: var(--bg-body);
            color: var(--text-dark);
            height: 100vh;
            overflow: hidden;
        }

        .app-container {
            display: flex;
            height: 100vh;
            width: 100vw;
        }

        /* --- Sidebar --- */
        .sidebar-icon-only {
            width: var(--sidebar-width);
            background-color: var(--bg-white);
            border-right: 1px solid var(--border);
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 1.5rem 0;
            flex-shrink: 0;
        }
        .brand-icon { font-size: 1.5rem; color: var(--primary); margin-bottom: 3rem; }
        .nav-icons { display: flex; flex-direction: column; gap: 1.5rem; flex: 1; }
        .nav-icons a { color: var(--text-gray); font-size: 1.25rem; padding: 0.75rem; border-radius: 12px; transition: all 0.2s; }
        .nav-icons a:hover, .nav-icons a.active { color: var(--primary); background-color: var(--primary-light); }
        .user-avatar-small img { width: 40px; height: 40px; border-radius: 50%; border: 2px solid var(--border); cursor: pointer;}


        /* --- 2. PROFILE PAGE SPECIFIC STYLES --- */
        
        /* Main Scrollable Area */
        .main-content {
            flex: 1;
            overflow-y: auto;
            padding: 2rem 3rem;
        }

        .page-title {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 2rem;
            color: var(--text-dark);
        }

        /* Profile Header Card (Top) */
        .profile-header-card {
            background: var(--bg-white);
            border-radius: 16px;
            padding: 2.5rem;
            display: flex;
            align-items: center;
            gap: 2rem;
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05);
            margin-bottom: 2rem;
        }

        /* Avatar with Camera Overlay */
        .avatar-container {
            position: relative;
            width: 120px;
            height: 120px;
        }

        .avatar-container img {
            width: 100%;
            height: 100%;
            border-radius: 50%;
            object-fit: cover;
            border: 4px solid var(--bg-body);
        }

        .upload-icon {
            position: absolute;
            bottom: 5px;
            right: 5px;
            background: var(--primary);
            color: white;
            width: 32px;
            height: 32px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            border: 2px solid white;
            transition: transform 0.2s;
        }
        .upload-icon:hover { transform: scale(1.1); }

        .profile-info h1 { font-size: 1.8rem; margin-bottom: 0.25rem; }
        .profile-info p { color: var(--text-gray); font-size: 1rem; }
        .role-badge { 
            display: inline-block; 
            background: var(--primary-light); 
            color: var(--primary); 
            padding: 4px 12px; 
            border-radius: 20px; 
            font-size: 0.8rem; 
            font-weight: 600; 
            margin-top: 0.5rem; 
        }

        /* Form Section */
        .form-card {
            background: var(--bg-white);
            border-radius: 16px;
            padding: 2.5rem;
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05);
            max-width: 800px;
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid var(--border);
        }

        .section-header h3 { font-size: 1.2rem; font-weight: 600; }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr; /* Two Columns */
            gap: 1.5rem;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        .form-group.full-width {
            grid-column: span 2; /* Span across both columns */
        }

        label {
            font-size: 0.85rem;
            font-weight: 600;
            color: var(--text-gray);
            text-transform: uppercase;
        }

        input, textarea {
            padding: 0.85rem;
            border: 1px solid var(--border);
            border-radius: 8px;
            font-family: inherit;
            font-size: 0.95rem;
            background-color: #f9fafb;
            transition: border-color 0.2s;
            outline: none;
        }

        input:focus, textarea:focus {
            border-color: var(--primary);
            background-color: white;
        }

        textarea { resize: vertical; min-height: 100px; }

        /* Action Buttons */
        .form-actions {
            margin-top: 2rem;
            display: flex;
            justify-content: flex-end;
            gap: 1rem;
        }

        .btn-cancel {
            background: white;
            border: 1px solid var(--border);
            color: var(--text-gray);
            padding: 0.75rem 1.5rem;
            border-radius: 8px;
            font-weight: 500;
            cursor: pointer;
        }

        .btn-save {
            background: var(--primary);
            color: white;
            border: none;
            padding: 0.75rem 2rem;
            border-radius: 8px;
            font-weight: 500;
            cursor: pointer;
            box-shadow: 0 4px 6px -1px rgba(79, 70, 229, 0.3);
        }

        .btn-save:hover { background-color: #4338ca; }

        /* Mobile Responsive */
        @media (max-width: 768px) {
            .form-grid { grid-template-columns: 1fr; }
            .profile-header-card { flex-direction: column; text-align: center; }
            .main-content { padding: 1rem; }
        }
    </style>
</head>
<body>

    <div class="app-container">

        <aside class="sidebar-icon-only">
            <div class="brand-icon"><i class="fa-solid fa-address-book"></i></div>
            <nav class="nav-icons">
                <a href="Dashboard.jsp" title="Contacts"><i class="fa-solid fa-user-group"></i></a>
                <a href="Messages.jsp" title="Messages"><i class="fa-solid fa-comment-dots"></i></a>
                <a href="Calendar.jsp" title="Calendar"><i class="fa-solid fa-calendar-days"></i></a>
                <a href="Profile.jsp" class="active" title="Settings"><i class="fa-solid fa-gear"></i></a>
                <a href="LogoutServlet" class="logout-btn" title="Logout">
                <i class="fa-solid fa-right-from-bracket"></i>
            </a>
            </nav>
            <div class="user-avatar-small">
                <a href="Profile.jsp"><img src="https://i.pravatar.cc/100?img=3" alt="User"></a>
            </div>
        </aside>

        <main class="main-content">
            <h2 class="page-title">Account Settings</h2>

            <div class="profile-header-card">
                <div class="avatar-container">
                    <img src="https://i.pravatar.cc/150?img=3" alt="Profile Photo">
                    <label class="upload-icon" title="Change Photo">
                        <i class="fa-solid fa-camera"></i>
                        <input type="file" style="display: none;">
                    </label>
                </div>
                <%
                    HttpSession hs = request.getSession();
                    String userEmail = (String) hs.getAttribute("user-email");
                    UserModel cm = new UserModel();
                    UserDTO udto = cm.getUser(userEmail);
                %>
                <div class="profile-info">
                    <h1><%=udto.getFullName()%></h1>
                    <p><%=userEmail%></p>
                    <span class="role-badge">Administrator</span>
                </div>
            </div>

            <div class="form-card">
                <form action="UpdateProfileServlet" method="POST">
                    
                    <div class="section-header">
                        <h3>Personal Information</h3>
                    </div>
                    <%
                      String[] firstName = udto.getFullName().split(" ");
                    %>
                    <div class="form-grid">
                        <div class="form-group">
                            <label>First Name</label>
                            <input type="text" name="firstName" value="<%=firstName[0]%>">
                        </div>

                        <div class="form-group">
                            <label>Last Name</label>
                            <input type="text" name="lastName" value="<%=firstName[1]%>">
                        </div>

                        <div class="form-group">
                            <label>Email Address</label>
                            <input type="email" name="email" value="<%=userEmail%>">
                        </div>

                        <div class="form-group">
                            <label>Phone Number</label>
                            <input type="tel" name="phone" value="<%=udto.getPhone()%>">
                        </div>

                        <div class="form-group">
                            <label>Job Title</label>
                            <input type="text" name="jobTitle" value="<%=udto.getJobTitle()%>">
                        </div>

                        <div class="form-group">
                            <label>Location</label>
                            <input type="text" name="location" value="<%=udto.getLocation()%>">
                        </div>

                        <div class="form-group full-width">
                            <label>Bio</label>
                            <textarea name="bio" placeholder="Write a short bio...">Passionate developer with 1 years of experience in Java and Spring Boot. I love building clean user interfaces and scalable backends.</textarea>
                        </div>
                    </div>

                    <div class="form-actions">
                        <button type="button" class="btn-cancel" onclick="window.history.back()">Cancel</button>
                        <button type="submit" class="btn-save">Save Changes</button>
                    </div>

                </form>
            </div>

        </main>
    </div>

</body>
</html>
