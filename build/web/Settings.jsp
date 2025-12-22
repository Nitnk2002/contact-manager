<%-- 
    Document   : Settings
    Created on : 14-Dec-2025, 3:11:48 pm
    Author     : Nitra
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Settings | Connect</title>
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        /* --- 1. SHARED THEME (Matches Dashboard) --- */
        :root {
            --primary: #4f46e5;
            --primary-light: #eef2ff;
            --text-dark: #111827;
            --text-gray: #6b7280;
            --bg-body: #f3f4f6;
            --bg-white: #ffffff;
            --border: #e5e7eb;
            --sidebar-width: 70px;
            --danger: #ef4444; /* Red for dangerous actions */
        }

        * { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: var(--bg-body);
            color: var(--text-dark);
            height: 100vh;
            overflow: hidden;
        }

        .app-container { display: flex; height: 100vh; width: 100vw; }

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
        .user-avatar-small img { width: 40px; height: 40px; border-radius: 50%; border: 2px solid var(--border); }

        /* --- 2. SETTINGS SPECIFIC CSS --- */
        .main-content {
            flex: 1;
            overflow-y: auto;
            padding: 2rem 3rem;
        }

        .page-header { margin-bottom: 2rem; }
        .page-header h2 { font-size: 1.8rem; font-weight: 700; color: var(--text-dark); }
        .page-header p { color: var(--text-gray); }

        /* Settings Card Container */
        .settings-card {
            background: var(--bg-white);
            border-radius: 16px;
            padding: 0; /* Padding handled inside sections */
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05);
            max-width: 800px;
            overflow: hidden;
            margin-bottom: 2rem;
        }

        /* Section Styling */
        .settings-section {
            padding: 2rem;
            border-bottom: 1px solid var(--border);
        }
        .settings-section:last-child { border-bottom: none; }

        .section-title { font-size: 1.1rem; font-weight: 600; margin-bottom: 0.5rem; display: flex; align-items: center; gap: 0.75rem; }
        .section-title i { color: var(--primary); }
        .section-desc { font-size: 0.9rem; color: var(--text-gray); margin-bottom: 1.5rem; }

        /* Toggle Rows */
        .setting-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.25rem;
        }
        .setting-row:last-child { margin-bottom: 0; }
        
        .setting-info h4 { font-size: 0.95rem; font-weight: 500; margin-bottom: 0.25rem; }
        .setting-info p { font-size: 0.8rem; color: var(--text-gray); }

        /* --- TOGGLE SWITCH CSS --- */
        .switch { position: relative; display: inline-block; width: 44px; height: 24px; }
        .switch input { opacity: 0; width: 0; height: 0; }
        .slider {
            position: absolute; cursor: pointer; top: 0; left: 0; right: 0; bottom: 0;
            background-color: #ccc; transition: .4s; border-radius: 34px;
        }
        .slider:before {
            position: absolute; content: ""; height: 18px; width: 18px; left: 3px; bottom: 3px;
            background-color: white; transition: .4s; border-radius: 50%;
        }
        input:checked + .slider { background-color: var(--primary); }
        input:checked + .slider:before { transform: translateX(20px); }

        /* Inputs & Selects */
        .form-select {
            padding: 0.5rem 2rem 0.5rem 1rem;
            border: 1px solid var(--border);
            border-radius: 8px;
            background-color: white;
            font-family: inherit;
            cursor: pointer;
        }

        .btn-outline {
            padding: 0.5rem 1rem;
            border: 1px solid var(--border);
            background: transparent;
            border-radius: 6px;
            font-size: 0.9rem;
            cursor: pointer;
            transition: 0.2s;
        }
        .btn-outline:hover { background-color: var(--bg-body); }

        .btn-danger {
            background-color: #fef2f2;
            color: var(--danger);
            border: 1px solid #fecaca;
            padding: 0.5rem 1rem;
            border-radius: 6px;
            font-size: 0.9rem;
            cursor: pointer;
            font-weight: 500;
        }
        .btn-danger:hover { background-color: #fee2e2; }

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
                <a href="Settings.jsp" class="active" title="Settings"><i class="fa-solid fa-gear"></i></a>
                <a href="LogoutServlet" class="logout-btn" title="Logout">
                <i class="fa-solid fa-right-from-bracket"></i>
            </a>
            </nav>
            <div class="user-avatar-small">
                <a href="Profile.jsp"><img src="https://i.pravatar.cc/100?img=3" alt="User"></a>
            </div>
        </aside>

        <main class="main-content">
            
            <div class="page-header">
                <h2>Settings</h2>
                <p>Manage your application preferences and security.</p>
            </div>

            <div class="settings-card">
                
                <div class="settings-section">
                    <div class="section-title"><i class="fa-solid fa-sliders"></i> General</div>
                    <div class="section-desc">Customize your dashboard experience.</div>

                    <div class="setting-row">
                        <div class="setting-info">
                            <h4>Language</h4>
                            <p>Select your preferred interface language.</p>
                        </div>
                        <select class="form-select">
                            <option>English (US)</option>
                            <option>Hindi</option>
                        </select>
                    </div>

                    <div class="setting-row">
                        <div class="setting-info">
                            <h4>Dark Mode</h4>
                            <p>Switch between light and dark themes.</p>
                        </div>
                        <label class="switch">
                            <input type="checkbox">
                            <span class="slider"></span>
                        </label>
                    </div>
                </div>

                <div class="settings-section">
                    <div class="section-title"><i class="fa-regular fa-bell"></i> Notifications</div>
                    <div class="section-desc">Control when and how you want to be notified.</div>

                    <div class="setting-row">
                        <div class="setting-info">
                            <h4>Email Notifications</h4>
                            <p>Receive weekly summaries and major updates.</p>
                        </div>
                        <label class="switch">
                            <input type="checkbox" checked>
                            <span class="slider"></span>
                        </label>
                    </div>

                    <div class="setting-row">
                        <div class="setting-info">
                            <h4>New Contact Alerts</h4>
                            <p>Get notified when a team member adds a contact.</p>
                        </div>
                        <label class="switch">
                            <input type="checkbox" checked>
                            <span class="slider"></span>
                        </label>
                    </div>
                </div>

                <div class="settings-section">
                    <div class="section-title"><i class="fa-solid fa-shield-halved"></i> Security</div>
                    <div class="section-desc">Manage your password and account security.</div>

                    <div class="setting-row">
                        <div class="setting-info">
                            <h4>Change Password</h4>
                            <p>Last changed 3 months ago.</p>
                        </div>
                        <button class="btn-outline">Update</button>
                    </div>

                    <div class="setting-row">
                        <div class="setting-info">
                            <h4>Two-Factor Authentication</h4>
                            <p>Add an extra layer of security.</p>
                        </div>
                        <label class="switch">
                            <input type="checkbox">
                            <span class="slider"></span>
                        </label>
                    </div>
                </div>
                <<form action="DeleteAccountServlet" method="POST" >
                    <div class="settings-section" style="background-color: #fff1f2;">
                        <div class="section-title" style="color: var(--danger);"><i class="fa-solid fa-triangle-exclamation"></i> Danger Zone</div>

                        <div class="setting-row">
                            <div class="setting-info">
                                <h4>Delete Account</h4>
                                <p>Permanently remove your account and all data.</p>
                            </div>
                            <button value="submit" class="btn-danger">Delete Account</button>
                        </div>
                    </div>
                </form>
            </div>

        </main>
    </div>

</body>
</html>
