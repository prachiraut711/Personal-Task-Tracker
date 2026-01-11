<h1 align="center">🚀 Mini TaskHub</h1>

<p align="center">
  <b>A modern Task Management App built using Flutter, GetX, and Supabase.</b><br/>
  Internship Assignment Project
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white"/>
  <img src="https://img.shields.io/badge/GetX-800080?style=for-the-badge&logo=dart&logoColor=white"/>
  <img src="https://img.shields.io/badge/Supabase-3ECF8E?style=for-the-badge&logo=supabase&logoColor=white"/>
</p>

<hr/>

<h2>📦 Deliverables</h2>
<ul>
  <li><b>GitHub Repository:</b> 
    <a href="https://github.com/YOUR_USERNAME/mini-taskhub-flutter">
      https://github.com/prachiraut711/Personal-Task-Tracker
    </a>
  </li>
  <li><b>Demo Video:</b> 
    <a href="https://youtu.be/PDHEOVLlLrk">Watch Demo</a>
  </li>
</ul>

<hr/>

<h2>✨ Features</h2>
<ul>
  <li>Email & Password Authentication (Supabase)</li>
  <li>Create and delete personal tasks</li>
  <li>User-specific data using Row Level Security (RLS)</li>
  <li>Supabase PostgreSQL backend</li>
  <li>Clean and responsive UI</li>
  <li>State management using GetX</li>
</ul>

<hr/>

<h2>🛠️ Tech Stack</h2>
<ul>
  <li>Flutter</li>
  <li>GetX</li>
  <li>Supabase (Auth + Database)</li>
  <li>PostgreSQL</li>
</ul>

<hr/>

<h2>🔥 Supabase Setup</h2>

<h3>1️⃣ Project Creation</h3>
<ul>
  <li>Create a new project named <b>mini-taskhub</b></li>
  <li>Select <b>Asia-Pacific</b> region</li>
</ul>

<h3>2️⃣ Database Table</h3>
<p>Run the following query in <b>SQL Editor</b>:</p>

<pre>
<code>
create table tasks (
  id uuid default gen_random_uuid() primary key,
  user_id uuid references auth.users(id),
  title text not null,
  is_completed boolean default false,
  created_at timestamp with time zone default now()
);
</code>
</pre>

<h3>3️⃣ Row Level Security (RLS)</h3>

<p><b>Read Policy</b></p>
<pre>
<code>
create policy "Users can read their own tasks"
on tasks
for select
using (auth.uid() = user_id);
</code>
</pre>

<p><b>Insert Policy</b></p>
<pre>
<code>
create policy "Users can add their own tasks"
on tasks
for insert
with check (auth.uid() = user_id);
</code>
</pre>

<p><b>Delete Policy</b></p>
<pre>
<code>
create policy "Users can delete their own tasks"
on tasks
for delete
using (auth.uid() = user_id);
</code>
</pre>

<hr/>

<h3>4️⃣ Authentication Setup</h3>
<ul>
  <li>Go to <b>Authentication → Sign In / Providers</b></li>
  <li>Enable <b>Email</b></li>
  <li>Disable <b>Confirm email</b> (for testing)</li>
</ul>

<h3>5️⃣ API Keys</h3>
<ul>
  <li>Go to <b>Settings → API</b></li>
  <li>Copy <b>Project URL</b> and <b>anon public key</b></li>
  <li>Paste them into <code>main.dart</code></li>
</ul>

<hr/>

<h2>🚀 Flutter Setup</h2>

<p><b>Clone the repository</b></p>
<pre><code>git clone https://github.com/prachiraut711/Personal-Task-Tracker</code></pre>

<p><b>Install dependencies</b></p>
<pre><code>flutter pub get</code></pre>

<p><b>Run the app</b></p>
<pre><code>flutter run</code></pre>

<hr/>

<h2>⚡ Hot Reload vs Hot Restart</h2>

<table border="1" cellpadding="8" cellspacing="0" width="100%">
  <tr>
    <th>Feature</th>
    <th>Hot Reload ⚡</th>
    <th>Hot Restart 🔄</th>
  </tr>
  <tr>
    <td>Speed</td>
    <td>Very Fast</td>
    <td>Slightly Slower</td>
  </tr>
  <tr>
    <td>State</td>
    <td>Preserved</td>
    <td>Reset</td>
  </tr>
  <tr>
    <td>Best Use</td>
    <td>UI changes</td>
    <td>initState changes</td>
  </tr>
</table>

<hr/>

<h2>🏁 Conclusion</h2>
<p>
Mini TaskHub demonstrates secure authentication, Supabase integration,
clean architecture, and effective state management using GetX.
</p>

<hr/>

<p align="center">
  <b>👩‍💻 Developed by Prachi Raut</b>
</p>
