<h1 align="center">🚀 Mini TaskHub</h1>

<p align="center">
  <strong>A sleek, high-performance Task Management App built with Flutter, GetX, and Supabase.</strong>
</p>

<div align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" />
  <img src="https://img.shields.io/badge/Supabase-3ECF8E?style=for-the-badge&logo=supabase&logoColor=white" />
  <img src="https://img.shields.io/badge/GetX-800080?style=for-the-badge&logo=dart&logoColor=white" />
</div>

<hr />

## 📦 Deliverables
<ul>
  <li><strong>GitHub Repo:</strong> <a href="INSERT_YOUR_LINK">View Repository</a></li>
  <li><strong>Demo Video:</strong> <a href="INSERT_YOUR_VIDEO_LINK">Watch Working Demo</a></li>
</ul>

<hr />

## 🔥 Supabase Setup (Step-by-Step)
<ol>
  <li><strong>Create Project:</strong> Sign up at <a href="https://supabase.com">Supabase</a> and create <code>mini_taskhub</code>.</li>
  <li><strong>SQL Configuration:</strong> Run the following in the SQL Editor:</li>
</ol>

```sql
create table tasks (
  id uuid default uuid_generate_v4() primary key,
  user_id uuid references auth.users(id),
  title text not null,
  is_completed boolean default false,
  created_at timestamp with time zone default now()
);

<ol start="3"> <li><strong>Authentication:</strong> Enable Email Provider. Turn <b>OFF</b> "Confirm Email" for development.</li> <li><strong>API Keys:</strong> Copy the Project URL and Anon Key into <code>main.dart</code>.</li> </ol>

<hr />

🚀 Flutter Setup
<pre>

flutter pub get

Replace Supabase keys in main.dart

flutter run </pre>

<hr />

⚡ Hot Reload vs Hot Restart
<table> <tr> <th>Feature</th> <th>Hot Reload ⚡</th> <th>Hot Restart 🔄</th> </tr> <tr> <td><b>Speed</b></td> <td>Sub-second (Fast)</td> <td>2-3 Seconds</td> </tr> <tr> <td><b>State</b></td> <td><b>Preserves State</b> (Text/Scroll remains)</td> <td><b>Resets State</b> (App restarts)</td> </tr> <tr> <td><b>Use Case</b></td> <td>UI tweaks, Color changes, Build logic</td> <td>InitState changes, Global variables</td> </tr> </table>

<hr />

<h3 align="center">Developed with ❤️ using Flutter</h3>
