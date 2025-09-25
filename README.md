#Introduction of Netlify

Netlify is a cloud platform for deploying and hosting websites and web applications. It is especially popular for static sites and modern frontend frameworks.

#Step to Install Netlify

1. ติดตั้ง CLI
    npm install -g netlify-cli

2. ล็อกอิน
    netlify login

#Step to Deploy Godot Project with Netlify

1. Export GodotProject
    - Project -> Export -> HTML5 -> Export Project -> Name == index -> Create Directory Name is Product in Project Directory -> Save index.html in Product Directory -> Uncheck Export With Debug(important!) -> Save
2. Netlify Deploy
    - cmd in Product Directory(important!) -> Type netlify deploy and wait -> Type Team Name and Project Name -> wait -> deploy successful -> copy netlify url(link to your website)