<%@page import="java.util.ArrayList"%>
<%@page import="dto.ContactDTO"%>
<%@page import="model.ContactModel"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contacts | Connect</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        /* --- CSS Variables --- */
        :root {
            --primary: #4f46e5;
            --primary-light: #eef2ff;
            --text-dark: #111827;
            --text-gray: #6b7280;
            --text-light: #9ca3af;
            --bg-body: #f3f4f6;
            --bg-white: #ffffff;
            --border: #e5e7eb;
            --sidebar-width: 70px;
            --list-width: 350px;
        }

        /* --- Reset & Base --- */
        * { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: var(--bg-body);
            color: var(--text-dark);
            height: 100vh;
            overflow: hidden;
        }

        /* --- Layout Container --- */
        .app-container {
            display: flex;
            height: 100vh;
            width: 100vw;
        }

        /* --- 1. Sidebar (Icon Only) --- */
        .sidebar-icon-only {
            width: var(--sidebar-width);
            background-color: var(--bg-white);
            border-right: 1px solid var(--border);
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 1.5rem 0;
            z-index: 10;
        }

        .brand-icon {
            font-size: 1.5rem;
            color: var(--primary);
            margin-bottom: 3rem;
        }

        .nav-icons {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
            flex: 1;
        }

        .nav-icons a {
            color: var(--text-gray);
            font-size: 1.25rem;
            padding: 0.75rem;
            border-radius: 12px;
            transition: all 0.2s ease;
        }

        .nav-icons a:hover, .nav-icons a.active {
            color: var(--primary);
            background-color: var(--primary-light);
        }

        .user-avatar-small img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid var(--border);
        }

        /* --- 2. Left Panel: List View --- */
        .list-panel {
            width: var(--list-width);
            background-color: var(--bg-white);
            border-right: 1px solid var(--border);
            display: flex;
            flex-direction: column;
        }

        .list-header {
            padding: 1.5rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .list-header h2 { font-size: 1.25rem; font-weight: 700; }
        .list-header .count {
            background: var(--primary-light);
            color: var(--primary);
            font-size: 0.8rem;
            padding: 2px 8px;
            border-radius: 12px;
            margin-left: 5px;
        }

        /* --- THE ADD BUTTON --- */
        .add-btn {
            background: var(--primary);
            color: white;
            border: none;
            width: 32px;
            height: 32px;
            border-radius: 8px;
            cursor: pointer;
            transition: 0.2s;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .add-btn:hover { background-color: #4338ca; }

        .search-box {
            margin: 0 1.5rem 1.5rem;
            background: var(--bg-body);
            padding: 0.75rem 1rem;
            border-radius: 8px;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: var(--text-gray);
        }

        .search-box input {
            border: none;
            background: transparent;
            outline: none;
            width: 100%;
            font-family: inherit;
        }

        /* Contact List Scroll Area */
        .contact-scroll-list {
            flex: 1;
            overflow-y: auto;
            padding: 0 0.5rem 1rem;
        }
        .contact-scroll-list::-webkit-scrollbar { width: 6px; }
        .contact-scroll-list::-webkit-scrollbar-thumb { background-color: #d1d5db; border-radius: 3px; }

        /* List Items */
        .contact-item {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 1rem 1.5rem;
            cursor: pointer;
            border-radius: 8px;
            margin: 0 0.5rem;
            transition: background 0.2s ease;
        }

        .contact-item:hover { background-color: #f9fafb; }
        .contact-item.active { background-color: var(--primary-light); }

        .contact-item img {
            width: 48px;
            height: 48px;
            border-radius: 50%;
            object-fit: cover;
        }

        .contact-item .info h3 { font-size: 1rem; font-weight: 600; color: var(--text-dark); }
        .contact-item.active .info h3 { color: var(--primary); }
        .contact-item .info p { font-size: 0.85rem; color: var(--text-gray); }

        /* --- 3. Right Panel: Detail View --- */
        .detail-panel {
            flex: 1;
            background-color: var(--bg-body);
            overflow-y: auto;
            padding: 2rem;
        }

        .hidden { display: none !important; }

        .contact-detail-view {
            max-width: 900px;
            margin: 0 auto;
            animation: fadeIn 0.3s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .detail-header {
            background-color: var(--bg-white);
            padding: 2.5rem;
            border-radius: 16px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 2rem;
        }

        .profile-main { display: flex; gap: 2rem; align-items: center; }
        .profile-pic-large { width: 120px; height: 120px; border-radius: 50%; object-fit: cover; border: 4px solid var(--primary-light); }
        .profile-names h1 { font-size: 2rem; margin-bottom: 0.25rem; }
        .job-title { display: block; color: var(--text-gray); font-size: 1.1rem; margin-bottom: 1rem; }
        .company { color: var(--text-dark); font-weight: 600; }
        .tags { display: flex; gap: 0.5rem; }
        .tag { font-size: 0.75rem; padding: 0.25rem 0.75rem; border-radius: 99px; font-weight: 600; text-transform: uppercase; }
        .tag-purple { background-color: #eef2ff; color: var(--primary); }
        .tag-green { background-color: #ecfdf5; color: #059669; }
        .tag-blue { background-color: #eff6ff; color: #2563eb; }

        .header-actions { display: flex; gap: 0.75rem; }
        .action-btn { padding: 0.6rem 1.2rem; border-radius: 8px; border: none; cursor: pointer; font-weight: 500; display: flex; align-items: center; gap: 0.5rem; background-color: var(--primary); color: white; }
        .action-btn.outline { background-color: transparent; border: 1px solid var(--border); color: var(--text-gray); }
        .action-btn:hover { opacity: 0.9; }

        .info-card { background-color: var(--bg-white); border-radius: 16px; padding: 2rem; margin-bottom: 1.5rem; box-shadow: 0 2px 4px rgba(0,0,0,0.05); }
        .info-card h3 { font-size: 1.1rem; margin-bottom: 1.5rem; padding-bottom: 1rem; border-bottom: 1px solid var(--border); }
        .info-grid { display: grid; grid-template-columns: repeat(2, 1fr); gap: 2rem; }
        .info-group label { display: block; font-size: 0.85rem; color: var(--text-light); margin-bottom: 0.5rem; text-transform: uppercase; font-weight: 600; }
        .info-group span, .info-group a { font-size: 1rem; color: var(--text-dark); font-weight: 500; text-decoration: none; }
        .info-group a { color: var(--primary); }
        .notes-area { width: 100%; border: 1px solid var(--border); border-radius: 8px; padding: 1rem; min-height: 100px; font-family: inherit; resize: vertical; outline: none; }
        .notes-area:focus { border-color: var(--primary); }
        .empty-state { text-align: center; padding-top: 5rem; color: var(--text-gray); }

        /* --- MODAL STYLES (CRITICAL) --- */
        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 1000;
            display: flex;
            justify-content: center;
            align-items: center;
            opacity: 0;
            pointer-events: none;
            transition: opacity 0.3s ease;
            backdrop-filter: blur(2px);
        }

        .modal-overlay.show {
            opacity: 1;
            pointer-events: auto;
        }

        .modal-card {
            background-color: var(--bg-white);
            width: 100%;
            max-width: 500px;
            border-radius: 16px;
            padding: 2rem;
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
            transform: translateY(20px);
            transition: transform 0.3s ease;
        }

        .modal-overlay.show .modal-card { transform: translateY(0); }

        .modal-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem; }
        .modal-header h3 { font-size: 1.25rem; font-weight: 700; }
        .close-modal-btn { background: none; border: none; font-size: 1.5rem; color: var(--text-gray); cursor: pointer; }

        .form-group { margin-bottom: 1.25rem; }
        .form-group.center { display: flex; flex-direction: column; align-items: center; margin-bottom: 2rem; }
        .form-row { display: flex; gap: 1rem; }
        .form-row .form-group { flex: 1; }
        .form-group label { display: block; font-size: 0.85rem; font-weight: 500; margin-bottom: 0.5rem; color: var(--text-dark); }
        .form-group input { width: 100%; padding: 0.75rem; border: 1px solid var(--border); border-radius: 8px; outline: none; transition: border-color 0.2s; }
        .form-group input:focus { border-color: var(--primary); }

        .photo-upload { width: 80px; height: 80px; background-color: var(--bg-body); border-radius: 50%; display: flex; justify-content: center; align-items: center; color: var(--text-gray); font-size: 1.5rem; cursor: pointer; border: 2px dashed var(--border); margin-bottom: 0.5rem; }
        .upload-label { font-size: 0.8rem; color: var(--primary); cursor: pointer; }

        .modal-footer { display: flex; justify-content: flex-end; gap: 1rem; margin-top: 2rem; }
        .btn-cancel { background: none; border: 1px solid var(--border); padding: 0.75rem 1.5rem; border-radius: 8px; cursor: pointer; font-weight: 500; color: var(--text-gray); }
        .btn-save { background-color: var(--primary); color: white; border: none; padding: 0.75rem 1.5rem; border-radius: 8px; cursor: pointer; font-weight: 500; }
        .logout-btn:hover {
    background-color: #fef2f2 !important; /* Light red background */
    color: #ef4444 !important; /* Red icon color */
}
    </style>
</head>
<body>
    <%
        HttpSession  hs = request.getSession();
        String userEmail = (String) hs.getAttribute("user-email");
        if(userEmail == null){
            response.sendRedirect("index.html");
        }
    %>
    <%
            ContactModel cm = new ContactModel();
            ArrayList<ContactDTO> clist = cm.contactList(userEmail);
            
    %>
    <div class="app-container">

        <aside class="sidebar-icon-only">
            <div class="brand-icon"><i class="fa-solid fa-address-book"></i></div>
        <nav class="nav-icons">
            <a href="Dashboard.jsp" class="active" title="Contacts">
                <i class="fa-solid fa-user-group"></i>
            </a>

            <a href="Messages.jsp" title="Messages">
                <i class="fa-solid fa-comment-dots"></i>
            </a>

            <a href="Calendar.jsp" title="Calendar">
                <i class="fa-solid fa-calendar-days"></i>
            </a>

            <a href="Settings.jsp" title="Settings">
                <i class="fa-solid fa-gear"></i>
            </a>
            <a href="LogoutServlet" class="logout-btn" title="Logout">
                <i class="fa-solid fa-right-from-bracket"></i>
            </a>
        </nav>
        <div class="user-avatar-small">
            <a href="Profile.jsp" title="My Profile">
                <img src="https://i.pravatar.cc/100?img=3" alt="User">
            </a>
        </div>
        </aside>

        <div class="list-panel">
            <div class="list-header">
                <h2>Contacts <span class="count"><%=clist.size()%></span></h2>
                <button type="button" class="add-btn" onclick="openModal()"><i class="fa-solid fa-plus"></i></button>
            </div>
            
            <div class="search-box">
                <i class="fa-solid fa-magnifying-glass"></i>
                <input type="text" placeholder="Search people...">
            </div>

            
            <div class="contact-scroll-list">
                <% 
                    int count= 1;
                    String active ="active";
                    for(ContactDTO contact : clist){
                %>
                <div class="contact-item <%=count==1?active:"" %>" onclick="selectContact(this, 'contact-<%=count%>')">
                    <img src="https://cdn-icons-png.flaticon.com/512/149/149071.png" alt="<%=contact.getFullName()%>">
                    <div class="info"><h3><%=contact.getFullName()%></h3><p><%=contact.getJobTitle()%></p></div>
                </div>
                    <%
                        count++;
                        }
                    %>
            </div>
        </div>
        
        <main class="detail-panel">
            <% 
                    int count1 = 1;
                    String hidden = "hidden";
                    for(ContactDTO contact : clist){
            %>
            <div id="contact-<%=count1%>" class="contact-detail-view <%=count1==1?"":hidden %>">
                <header class="detail-header">
                    <div class="profile-main">
                        <img src="https://cdn-icons-png.flaticon.com/512/149/149071.png" class="profile-pic-large" alt="Profile">
                        <div class="profile-names">
                            <h1><%= contact.getFullName() %></h1>
                            <span class="job-title"><%=contact.getJobTitle()%></span>
                            <div class="tags"><span class="tag tag-purple">Design</span><span class="tag tag-green">Active</span></div>
                        </div>
                    </div>
                    <div class="header-actions">

                        <button class="action-btn" 
                        onclick="openEditModal('<%=contact.getEmail()%>', '<%=contact.getFullName()%>', '<%=contact.getPhone()%>', '<%=contact.getJobTitle()%>')">
                        <i class="fa-solid fa-pen"></i> Edit
                        </button>

                        <form action="DeleteContactServlet" method="POST" onsubmit="return confirm('Are you sure you want to delete this contact?');">
                            <input type="hidden" name="email" value="<%= contact.getEmail() %>">
                            <button type="submit" class="action-btn btn-danger">
                            <i class="fa-solid fa-trash"></i> Delete
                            </button>
                        </form>

                    </div>
                </header>
                <div class="detail-body">
                    <section class="info-card">
                        <h3>Contact Information</h3>
                        <div class="info-grid">
                            <div class="info-group"><label>Email Address</label><a href="#"><%=contact.getEmail()%></a></div>
                            <div class="info-group"><label>Phone Number</label><a href="#"><%=contact.getPhone()%></a></div>
                        </div>
                    </section>
                </div>
            </div>
            <%
                count1++;
                }
            %>
            <div id="dynamic-contact-container"></div>
        </main>
    </div>


    <div class="modal-overlay" id="addContactModal">
    <div class="modal-card">
        <form action="AddContactServlet" method="POST">
            
            <div class="modal-header">
                <h3>Add New Contact</h3>
                <button type="button" class="btn-cancel" onclick="closeModal()" style="border:none; font-size:1.5rem;">&times;</button>
            </div>

            <div class="form-group">
                <label>Full Name</label>
                <input type="text" name="name" placeholder="e.g. Sarah Connor" required>
            </div>

            <div class="form-group">
                <label>Email Address</label>
                <input type="email" name="email" placeholder="sarah@example.com" required>
            </div>

            <div class="form-group">
                <label>Phone Number</label>
                <input type="tel" name="phone" placeholder="+91 98765 43210" required>
            </div>

            <div class="form-group">
                <label>Job Title / Role</label>
                <input type="text" name="jobTitle" placeholder="e.g. Software Engineer">
            </div>

            <div class="modal-footer">
                <button type="button" class="btn-cancel" onclick="closeModal()">Cancel</button>
                <button type="submit" class="btn-save">Save Contact</button>
            </div>

        </form>
    </div>
</div>


    <script>
        // --- 1. Selection Logic ---
        function selectContact(element, contactId) {
            // Remove 'active' class from all list items
            document.querySelectorAll('.contact-item').forEach(item => {
                item.classList.remove('active');
            });
            // Add active class to clicked item
            element.classList.add('active');

            // Hide all detail views
            document.querySelectorAll('.contact-detail-view').forEach(view => {
                view.classList.add('hidden');
            });

            // Try to find the detail view in static HTML
            let target = document.getElementById(contactId);
            
            // If found, show it
            if(target) {
                target.classList.remove('hidden');
            } else {
                console.log("Detail view not created for dynamic contact yet.");
            }
        }

        // --- 2. Modal Logic (Simpler Version) ---
    // Function to Open the Modal
    function openModal() {
        const modal = document.getElementById('addContactModal');
        modal.classList.add('show'); // Adds the CSS class that sets opacity to 1
    }

    // Function to Close the Modal
    function closeModal() {
        const modal = document.getElementById('addContactModal');
        modal.classList.remove('show');
    }

    // Optional: Close modal if clicking outside the white card
    window.onclick = function(event) {
        const modal = document.getElementById('addContactModal');
        if (event.target == modal) {
            closeModal();
        }
    }

        // --- 3. Form Submission (Add to List) ---
        // --- 3. Form Submission (Send to Servlet) ---
        function handleFormSubmit(event) {
            event.preventDefault(); // Prevent full page reload

            // 1. Gather form data automatically using the 'name' attributes
            const form = document.getElementById('addContactForm');
            const formData = new URLSearchParams(new FormData(form));

            // 2. Send Data to Java Servlet using AJAX (Fetch)
            // REPLACE 'AddContactServlet' with your actual Servlet URL
            fetch('AddContactServlet', { 
                method: 'POST',
                body: formData
            })
            .then(response => {
                if (response.ok) {
                    // Success: Update the UI
                    addContactToUI(); 
                    closeModal();
                    // Optional: Show success message
                    // alert("Saved to database!");
                } else {
                    alert("Error saving contact to database.");
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert("Connection failed.");
            });
        }

        // Helper function to update UI immediately (makes it feel fast)
        function addContactToUI() {
            // Get values directly for visual update
            const fName = document.getElementById('firstName').value;
            const lName = document.getElementById('lastName').value;
            const job = document.getElementById('jobTitle').value;
            const fullName = fName + " " + lName;
            const newId = 'contact-' + Date.now();

            // The HTML Template for the list item
            const newListHTML = `
                <div class="contact-item active" onclick="selectContact(this, '${newId}')">
                    <img src="https://i.pravatar.cc/150?img=${Math.floor(Math.random() * 70)}" alt="${fullName}">
                    <div class="info">
                        <h3>${fullName}</h3>
                        <p>${job}</p>
                    </div>
                </div>
            `;

            // Add to list visually
            document.querySelectorAll('.contact-item').forEach(item => item.classList.remove('active'));
            document.querySelectorAll('.contact-detail-view').forEach(view => view.classList.add('hidden'));

            const listContainer = document.querySelector('.contact-scroll-list');
            listContainer.insertAdjacentHTML('afterbegin', newListHTML);

            // Update count
            const countSpan = document.querySelector('.count');
            if(countSpan) countSpan.innerText = parseInt(countSpan.innerText) + 1;

            // Create Detail View for the new person
            const detailContainer = document.querySelector('.detail-panel');
            const newDetailHTML = `
                <div id="${newId}" class="contact-detail-view">
                    <header class="detail-header">
                        <div class="profile-main">
                            <img src="https://i.pravatar.cc/150?img=${Math.floor(Math.random() * 70)}" class="profile-pic-large" alt="Profile">
                            <div class="profile-names">
                                <h1>${fullName}</h1>
                                <span class="job-title">${job}</span>
                                <div class="tags"><span class="tag tag-green">New</span></div>
                            </div>
                        </div>
                    </header>
                    <div class="detail-body">
                         <div class="empty-state"><p>Saved to database successfully.</p></div>
                    </div>
                </div>
            `;
            detailContainer.insertAdjacentHTML('beforeend', newDetailHTML);
        }
            function openEditModal(email, name, phone, job) {
            // 1. Open the Modal (Reuse your existing openModal function)
            const modal = document.getElementById('addContactModal'); 
            modal.classList.add('show');

            // 2. Change Modal Title (Optional)
            document.querySelector('#addContactModal h3').innerText = "Edit Contact";

            // 3. Pre-fill the inputs with existing data
            document.querySelector('input[name="email"]').value = email;
            document.querySelector('input[name="name"]').value = name;
            document.querySelector('input[name="phone"]').value = phone;
            document.querySelector('input[name="jobTitle"]').value = job;

            // 4. (Important) Make Email Read-only so they can't break the ID
            document.querySelector('input[name="email"]').readOnly = true;
            document.querySelector('input[name="email"]').style.backgroundColor = "#e5e7eb";

            // 5. Change Form Action to UpdateContactServlet
            document.querySelector('#addContactModal form').action = "UpdateContactServlet";
        }
    </script>
</body>
</html>