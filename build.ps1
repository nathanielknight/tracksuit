Remove-Item -Recurse -Force build
New-Item -Type Directory .\build

Copy-Item static/* ./build

elm make ./src/Main.elm --output build/app.js