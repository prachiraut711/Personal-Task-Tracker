<h1 align="center">🚀 Mini TaskHub</h1>

<p align="center">
  <strong>A modern Task Management App built with Flutter, GetX, and Supabase.</strong>
</p>

<div align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" />
  <img src="https://img.shields.io/badge/Supabase-3ECF8E?style=for-the-badge&logo=supabase&logoColor=white" />
  <img src="https://img.shields.io/badge/GetX-800080?style=for-the-badge&logo=dart&logoColor=white" />
</div>

<hr />

## 📦 Deliverables
* **GitHub Repo:** https://github.com/prachiraut711/Personal-Task-Tracker
* **Demo Video:** [PASTE_YOUR_VIDEO_LINK_HERE]

<hr />

## 🔥 Supabase Setup Steps

### 1️⃣ Project Creation
* Go to [Supabase](https://supabase.com) and create a new project named **mini_taskhub**.
* Select your nearest region (e.g., Mumbai).

### 2️⃣ Database Configuration
Open the **SQL Editor** in Supabase and run the following code to create the tasks table:

```sql
create table tasks (
  id uuid default uuid_generate_v4() primary key,
  user_id uuid references auth.users(id),
  title text not null,
  is_completed boolean default false,
  created_at timestamp with time zone default now()
);

3️⃣ Authentication Setup
Go to Authentication > Providers.

Enable Email.

Turn OFF "Confirm email" (to allow immediate login for testing).

4️⃣ API Keys
Go to Settings > API.

Copy your Project URL and anon public key into your main.dart initialization.

<hr />

🚀 Flutter Installation & Setup
Clone the project:

Bash

git clone [PASTE_YOUR_GITHUB_LINK_HERE]
Install dependencies:

Bash

flutter pub get
Run the app:

Bash

flutter run
<hr />

⚡ Hot Reload vs Hot Restart
Flutter provides powerful tools to speed up development. Understanding the difference is key:

<table width="100%"> <tr> <th width="20%">Feature</th> <th width="40%">Hot Reload ⚡</th> <th width="40%">Hot Restart 🔄</th> </tr> <tr> <td><b>Speed</b></td> <td>Extremely Fast (sub-second).</td> <td>Fast (but slower than reload).</td> </tr> <tr> <td><b>State</b></td> <td><b>Preserves State</b>. Text in fields or scroll positions stay exactly where they are.</td> <td><b>Resets State</b>. The app clears all data and restarts from the initial screen.</td> </tr> <tr> <td><b>Best For</b></td> <td>UI changes, fixing build logic, adjusting colors and padding.</td> <td>Changing <code>initState</code>, global variables, or static fields.</td> </tr> </table>

<hr />

<h3 align="center">Made with ❤️ for Task Management</h3>
