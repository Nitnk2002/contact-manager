<%-- 
    Document   : Calender
    Created on : 14-Dec-2025, 3:13:29 pm
    Author     : Nitra
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Calendar | Connect</title>
    
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

        /* --- 2. CALENDAR SPECIFIC STYLES --- */
        .main-content {
            flex: 1;
            display: flex;
            flex-direction: column;
            padding: 2rem;
            overflow: hidden; /* Prevent full page scroll, let grid scroll if needed */
        }

        /* Calendar Header (Title + Controls) */
        .calendar-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .calendar-title h2 { font-size: 1.8rem; font-weight: 700; color: var(--text-dark); }
        .calendar-title p { color: var(--text-gray); font-size: 0.9rem; }

        .calendar-actions { display: flex; gap: 1rem; align-items: center; }
        
        .btn-nav {
            background: var(--bg-white);
            border: 1px solid var(--border);
            color: var(--text-dark);
            width: 36px; height: 36px;
            border-radius: 8px;
            cursor: pointer;
            display: flex; align-items: center; justify-content: center;
        }
        .btn-nav:hover { background: var(--bg-body); }
        
        .btn-today {
            background: var(--bg-white);
            border: 1px solid var(--border);
            padding: 0.5rem 1rem;
            border-radius: 8px;
            font-weight: 500;
            cursor: pointer;
        }

        .btn-add-event {
            background: var(--primary);
            color: white;
            border: none;
            padding: 0.6rem 1.2rem;
            border-radius: 8px;
            font-weight: 500;
            cursor: pointer;
            display: flex; align-items: center; gap: 0.5rem;
        }

        /* The Grid */
        .calendar-container {
            flex: 1;
            background: var(--bg-white);
            border-radius: 16px;
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05);
            display: flex;
            flex-direction: column;
            overflow: hidden;
            border: 1px solid var(--border);
        }

        /* Weekday Headers (Mon, Tue...) */
        .weekdays {
            display: grid;
            grid-template-columns: repeat(7, 1fr);
            border-bottom: 1px solid var(--border);
            background: #fafafa;
        }
        .weekday {
            padding: 1rem;
            text-align: center;
            font-weight: 600;
            color: var(--text-gray);
            font-size: 0.9rem;
            text-transform: uppercase;
        }

        /* Days Grid */
        .days-grid {
            flex: 1;
            display: grid;
            grid-template-columns: repeat(7, 1fr);
            grid-template-rows: repeat(5, 1fr); /* 5 rows for typical month */
        }

        .day-cell {
            border-right: 1px solid var(--border);
            border-bottom: 1px solid var(--border);
            padding: 0.5rem;
            position: relative;
            background: white;
            min-height: 100px; /* Ensure cells have height */
            transition: background 0.1s;
        }
        .day-cell:hover { background-color: #fcfcfc; }
        
        /* Remove right border for last column */
        .day-cell:nth-child(7n) { border-right: none; }

        .date-number {
            font-weight: 500;
            color: var(--text-dark);
            margin-bottom: 0.5rem;
            display: inline-block;
            width: 28px; height: 28px;
            text-align: center;
            line-height: 28px;
            border-radius: 50%;
        }

        /* Styling for Today */
        .day-cell.today .date-number {
            background-color: var(--primary);
            color: white;
        }

        /* Previous/Next month dates (faded) */
        .day-cell.other-month {
            background-color: #fafafa;
        }
        .day-cell.other-month .date-number {
            color: #d1d5db;
        }

        /* --- EVENTS Styling --- */
        .event-chip {
            font-size: 0.75rem;
            padding: 2px 6px;
            border-radius: 4px;
            margin-bottom: 2px;
            cursor: pointer;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            font-weight: 500;
        }
        
        .event-blue { background-color: var(--primary-light); color: var(--primary); }
        .event-green { background-color: #d1fae5; color: #059669; }
        .event-red { background-color: #fee2e2; color: #dc2626; }
        .event-purple { background-color: #f3e8ff; color: #9333ea; }

    </style>
</head>
<body>

    <div class="app-container">
        
        <aside class="sidebar-icon-only">
            <div class="brand-icon"><i class="fa-solid fa-address-book"></i></div>
            <nav class="nav-icons">
                <a href="Dashboard.jsp" title="Contacts"><i class="fa-solid fa-user-group"></i></a>
                <a href="Messages.jsp" title="Messages"><i class="fa-solid fa-comment-dots"></i></a>
                <a href="Calendar.jsp" class="active" title="Calendar"><i class="fa-solid fa-calendar-days"></i></a>
                <a href="Settings.jsp" title="Settings"><i class="fa-solid fa-gear"></i></a>
                <a href="LogoutServlet" class="logout-btn" title="Logout">
                <i class="fa-solid fa-right-from-bracket"></i>
            </a>
            </nav>
            <div class="user-avatar-small">
                <a href="Profile.jsp"><img src="https://i.pravatar.cc/100?img=3" alt="User"></a>
            </div>
        </aside>

        <main class="main-content">
            
            <header class="calendar-header">
                <div class="calendar-title">
                    <h2>October 2025</h2>
                    <p>Manage your meetings and follow-ups.</p>
                </div>
                <div class="calendar-actions">
                    <button class="btn-nav"><i class="fa-solid fa-chevron-left"></i></button>
                    <button class="btn-today">Today</button>
                    <button class="btn-nav"><i class="fa-solid fa-chevron-right"></i></button>
                    <button class="btn-add-event"><i class="fa-solid fa-plus"></i> Add Event</button>
                </div>
            </header>

            <div class="calendar-container">
                
                <div class="weekdays">
                    <div class="weekday">Sun</div>
                    <div class="weekday">Mon</div>
                    <div class="weekday">Tue</div>
                    <div class="weekday">Wed</div>
                    <div class="weekday">Thu</div>
                    <div class="weekday">Fri</div>
                    <div class="weekday">Sat</div>
                </div>

                <div class="days-grid">
                    
                    <div class="day-cell other-month"><span class="date-number">24</span></div>
                    <div class="day-cell other-month"><span class="date-number">25</span></div>
                    <div class="day-cell other-month"><span class="date-number">26</span></div>
                    <div class="day-cell other-month"><span class="date-number">27</span></div>
                    <div class="day-cell other-month"><span class="date-number">28</span></div>
                    <div class="day-cell other-month"><span class="date-number">29</span></div>
                    <div class="day-cell other-month"><span class="date-number">30</span></div>

                    <div class="day-cell"><span class="date-number">1</span></div>
                    <div class="day-cell">
                        <span class="date-number">2</span>
                        <div class="event-chip event-blue">Project Kickoff</div>
                    </div>
                    <div class="day-cell"><span class="date-number">3</span></div>
                    <div class="day-cell"><span class="date-number">4</span></div>
                    <div class="day-cell">
                        <span class="date-number">5</span>
                        <div class="event-chip event-green">Client Lunch</div>
                    </div>
                    <div class="day-cell"><span class="date-number">6</span></div>
                    <div class="day-cell"><span class="date-number">7</span></div>

                    <div class="day-cell"><span class="date-number">8</span></div>
                    <div class="day-cell"><span class="date-number">9</span></div>
                    <div class="day-cell"><span class="date-number">10</span></div>
                    <div class="day-cell">
                        <span class="date-number">11</span>
                        <div class="event-chip event-purple">Design Review</div>
                        <div class="event-chip event-red">Urgent: Bug Fix</div>
                    </div>
                    <div class="day-cell"><span class="date-number">12</span></div>
                    <div class="day-cell"><span class="date-number">13</span></div>
                    <div class="day-cell"><span class="date-number">14</span></div>

                    <div class="day-cell"><span class="date-number">15</span></div>
                    <div class="day-cell today">
                        <span class="date-number">16</span>
                        <div class="event-chip event-blue">Team Sync</div>
                    </div>
                    <div class="day-cell"><span class="date-number">17</span></div>
                    <div class="day-cell"><span class="date-number">18</span></div>
                    <div class="day-cell"><span class="date-number">19</span></div>
                    <div class="day-cell">
                        <span class="date-number">20</span>
                        <div class="event-chip event-green">Product Demo</div>
                    </div>
                    <div class="day-cell"><span class="date-number">21</span></div>

                    <div class="day-cell"><span class="date-number">22</span></div>
                    <div class="day-cell"><span class="date-number">23</span></div>
                    <div class="day-cell"><span class="date-number">24</span></div>
                    <div class="day-cell"><span class="date-number">25</span></div>
                    <div class="day-cell"><span class="date-number">26</span></div>
                    <div class="day-cell"><span class="date-number">27</span></div>
                    <div class="day-cell"><span class="date-number">28</span></div>

                </div>
            </div>

        </main>
    </div>

</body>
</html>
