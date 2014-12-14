
path = require 'path'
app = require path.join(__dirname, '/config/application')

app.listen 3000, ->
  console.log "listening to port 3000"
