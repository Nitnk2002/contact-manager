<%-- 
    Document   : Message
    Created on : 14-Dec-2025, 3:13:12 pm
    Author     : Nitra
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="dto.ContactDTO"%>
<%@page import="model.ContactModel"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Messages | Connect</title>
    
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


        /* --- 2. MESSAGES SPECIFIC STYLES --- */
        
        /* The main area needs to be a flex container for the 2 columns */
        .chat-layout {
            flex: 1;
            display: flex;
            overflow: hidden; /* Prevent page scroll */
            background-color: var(--bg-body);
            padding: 1.5rem;
            gap: 1.5rem;
        }

        /* --- LEFT COLUMN: Chat List --- */
        .chat-sidebar {
            width: 350px;
            background: var(--bg-white);
            border-radius: 16px;
            display: flex;
            flex-direction: column;
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05);
            border: 1px solid var(--border);
        }

        .chat-header {
            padding: 1.5rem;
            border-bottom: 1px solid var(--border);
        }
        .chat-header h2 { font-size: 1.25rem; font-weight: 700; margin-bottom: 1rem; }
        
        .search-bar {
            position: relative;
        }
        .search-bar i { position: absolute; left: 12px; top: 50%; transform: translateY(-50%); color: var(--text-gray); font-size: 0.9rem; }
        .search-bar input {
            width: 100%;
            padding: 0.6rem 1rem 0.6rem 2.2rem;
            border: 1px solid var(--border);
            border-radius: 8px;
            background: var(--bg-body);
            font-family: inherit;
            outline: none;
        }

        .conversation-list {
            flex: 1;
            overflow-y: auto;
            padding: 0.5rem;
        }

        .conversation-item {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 1rem;
            border-radius: 12px;
            cursor: pointer;
            transition: background 0.2s;
        }
        .conversation-item:hover { background-color: var(--bg-body); }
        .conversation-item.active { background-color: var(--primary-light); }

        .convo-avatar { position: relative; }
        .convo-avatar img { width: 48px; height: 48px; border-radius: 50%; object-fit: cover; }
        .online-status {
            position: absolute; bottom: 2px; right: 2px;
            width: 10px; height: 10px; border-radius: 50%;
            background-color: #22c55e; /* Green */
            border: 2px solid white;
        }

        .convo-info { flex: 1; min-width: 0; } /* min-width 0 allows text truncation */
        .convo-top { display: flex; justify-content: space-between; margin-bottom: 0.25rem; }
        .convo-name { font-weight: 600; font-size: 0.95rem; color: var(--text-dark); }
        .convo-time { font-size: 0.75rem; color: var(--text-gray); }
        .convo-last-msg {
            font-size: 0.85rem; color: var(--text-gray);
            white-space: nowrap; overflow: hidden; text-overflow: ellipsis;
        }
        .convo-item.active .convo-name { color: var(--primary); }
        .unread-badge { 
            background: var(--primary); color: white; 
            font-size: 0.7rem; padding: 2px 6px; 
            border-radius: 10px; margin-left: auto; 
        }

        /* --- RIGHT COLUMN: Chat Window --- */
        .chat-window {
            flex: 1;
            background: var(--bg-white);
            border-radius: 16px;
            display: flex;
            flex-direction: column;
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05);
            border: 1px solid var(--border);
            overflow: hidden;
        }

        /* Active Chat Header */
        .active-chat-header {
            padding: 1rem 1.5rem;
            border-bottom: 1px solid var(--border);
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: white;
        }
        .active-user { display: flex; align-items: center; gap: 1rem; }
        .active-user h3 { font-size: 1.1rem; font-weight: 600; margin: 0; }
        .active-user p { font-size: 0.8rem; color: #22c55e; margin: 0; } /* Online status text */
        
        .chat-actions i { 
            font-size: 1.1rem; color: var(--text-gray); 
            margin-left: 1rem; cursor: pointer; transition: 0.2s; 
        }
        .chat-actions i:hover { color: var(--primary); }

        /* Messages Area */
        .messages-area {
            flex: 1;
            padding: 1.5rem;
            overflow-y: auto;
            background-color: #fafafa;
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .message {
            display: flex;
            align-items: flex-end;
            gap: 0.5rem;
            max-width: 70%;
        }
        .message.sent { align-self: flex-end; flex-direction: row-reverse; }
        
        .message-bubble {
            padding: 0.75rem 1rem;
            font-size: 0.95rem;
            line-height: 1.5;
            position: relative;
        }

        /* Received Style */
        .message.received .message-bubble {
            background: white;
            border: 1px solid var(--border);
            color: var(--text-dark);
            border-radius: 12px 12px 12px 0; /* Bottom left corner square */
        }

        /* Sent Style */
        .message.sent .message-bubble {
            background: var(--primary);
            color: white;
            border-radius: 12px 12px 0 12px; /* Bottom right corner square */
            box-shadow: 0 2px 4px rgba(79, 70, 229, 0.2);
        }

        .msg-time {
            font-size: 0.7rem;
            margin-top: 4px;
            opacity: 0.7;
            text-align: right;
            display: block;
        }

        /* Input Area */
        .chat-input-area {
            padding: 1rem;
            background: white;
            border-top: 1px solid var(--border);
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .icon-btn {
            background: none; border: none; font-size: 1.2rem; 
            color: var(--text-gray); cursor: pointer; padding: 0.5rem;
            border-radius: 50%; transition: background 0.2s;
        }
        .icon-btn:hover { background-color: var(--bg-body); color: var(--text-dark); }

        .message-input {
            flex: 1;
            padding: 0.75rem 1rem;
            border: 1px solid var(--border);
            border-radius: 24px;
            background: var(--bg-body);
            font-family: inherit;
            outline: none;
        }
        .message-input:focus { border-color: var(--primary); background: white; }

        .btn-send {
            background: var(--primary); color: white;
            border: none; width: 42px; height: 42px;
            border-radius: 50%; display: flex; align-items: center; justify-content: center;
            cursor: pointer; transition: transform 0.2s;
        }
        .btn-send:hover { transform: scale(1.05); background-color: #4338ca; }

        /* Responsive */
        @media (max-width: 900px) {
            .chat-sidebar { width: 80px; } /* Compact mode */
            .convo-info, .chat-header h2, .search-bar { display: none; }
            .conversation-item { justify-content: center; padding: 1rem 0; }
        }
    </style>
</head>
<body>

    <div class="app-container">
        
        <aside class="sidebar-icon-only">
            <div class="brand-icon"><i class="fa-solid fa-address-book"></i></div>
            <nav class="nav-icons">
                <a href="Dashboard.jsp" title="Contacts"><i class="fa-solid fa-user-group"></i></a>
                <a href="Messages.jsp" class="active" title="Messages"><i class="fa-solid fa-comment-dots"></i></a>
                <a href="Calendar.jsp" title="Calendar"><i class="fa-solid fa-calendar-days"></i></a>
                <a href="Settings.jsp" title="Settings"><i class="fa-solid fa-gear"></i></a>
                <a href="LogoutServlet" class="logout-btn" title="Logout">
                <i class="fa-solid fa-right-from-bracket"></i>
            </a>
            </nav>
            <div class="user-avatar-small">
                <a href="Profile.jsp"><img src="https://i.pravatar.cc/100?img=3" alt="User"></a>
            </div>
        </aside>
        <%
            HttpSession hs = request.getSession();
            String userEmail = (String) hs.getAttribute("user-email");
            ContactModel cm = new ContactModel();
            ArrayList<ContactDTO> clist = cm.contactList(userEmail);
        %>
        <main class="chat-layout">
            
            <div class="chat-sidebar">
                <div class="chat-header">
                    <h2>Messages</h2>
                    <div class="search-bar">
                        <i class="fa-solid fa-magnifying-glass"></i>
                        <input type="text" placeholder="Search chats...">
                    </div>
                </div>

                <div class="conversation-list">
                    <div class="conversation-item active">
                        <div class="convo-avatar">
                            <img src="https://cdn-icons-png.flaticon.com/512/149/149071.png" alt="Alice">
                            <div class="online-status"></div>
                        </div>
                        <div class="convo-info">
                            <div class="convo-top">
                                <span class="convo-name"></span>
                                <span class="convo-time">Just now</span>
                            </div>
                            <p class="convo-last-msg">Sounds good! See you then.</p>
                        </div>
                    </div>

                    <div class="conversation-item">
                        <div class="convo-avatar">
                            <img src="https://cdn-icons-png.flaticon.com/512/149/149071.png" alt="Bob">
                        </div>
                        <div class="convo-info">
                            <div class="convo-top">
                                <span class="convo-name"></span>
                                <span class="convo-time">10:30 AM</span>
                            </div>
                            <div style="display:flex;">
                                <p class="convo-last-msg" style="font-weight:600; color:var(--text-dark);">Can you review the PR?</p>
                                <span class="unread-badge">2</span>
                            </div>
                        </div>
                    </div>

                    <div class="conversation-item">
                        <div class="convo-avatar">
                            <img src="https://cdn-icons-png.flaticon.com/512/149/149071.png" alt="Charlie">
                        </div>
                        <div class="convo-info">
                            <div class="convo-top">
                                <span class="convo-name"></span>
                                <span class="convo-time">Yesterday</span>
                            </div>
                            <p class="convo-last-msg">Thanks for the update.</p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="chat-window">
                
                <div class="active-chat-header">
                    <div class="active-user">
                        <img src="https://cdn-icons-png.flaticon.com/512/149/149071.png" style="width: 40px; height: 40px; border-radius: 50%;" alt="Alice">
                        <div>
                            <h3></h3>
                            <p>Online</p>
                        </div>
                    </div>
                    <div class="chat-actions">
                        <i class="fa-solid fa-phone" title="Call"></i>
                        <i class="fa-solid fa-video" title="Video Call"></i>
                        <i class="fa-solid fa-ellipsis-vertical" title="More"></i>
                    </div>
                </div>

                <div class="messages-area">
                    
                    <div class="message received">
                        <img src="https://cdn-icons-png.flaticon.com/512/149/149071.png" style="width: 32px; height: 32px; border-radius: 50%;" alt="Alice">
                        <div class="message-bubble">
                            Hey! Are we still on for the design review meeting?
                            <span class="msg-time">9:41 AM</span>
                        </div>
                    </div>

                    <div class="message sent">
                        <div class="message-bubble">
                            Yes, absolutely. I have the mockups ready to share.
                            <span class="msg-time">9:42 AM</span>
                        </div>
                    </div>

                    <div class="message received">
                        <img src="https://cdn-icons-png.flaticon.com/512/149/149071.png" style="width: 32px; height: 32px; border-radius: 50%;" alt="Alice">
                        <div class="message-bubble">
                            Great! Looking forward to seeing the new icons. 🎨
                            <span class="msg-time">9:45 AM</span>
                        </div>
                    </div>

                    <div class="message sent">
                        <div class="message-bubble">
                            Sounds good! See you then.
                            <span class="msg-time">Just now</span>
                        </div>
                    </div>

                </div>

                <div class="chat-input-area">
                    <button class="icon-btn"><i class="fa-solid fa-paperclip"></i></button>
                    <button class="icon-btn"><i class="fa-regular fa-face-smile"></i></button>
                    <input type="text" class="message-input" placeholder="Type a message...">
                    <button class="btn-send"><i class="fa-solid fa-paper-plane"></i></button>
                </div>

            </div>

        </main>
    </div>

</body>
</html>