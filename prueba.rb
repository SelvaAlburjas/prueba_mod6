=begin
Crear un método llamado build_web_page que reciba el hash de respuesta con todos
los datos y construya una página web. Se evaluará la página creada y tiene que tener
este formato:
=end
require "uri"
require "net/http"
require "byebug"
require "json"
require 'faraday'

def request(url, api_key)
    respuesta = Faraday.get(url + api_key) # Enviar
    json = JSON.parse(respuesta.body) #transformar texto de respuesta a HASH
end

url = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10&api_key="
api_key = "jOLeUmTthh5Kc1KLb9Bbc1tINATbtL6V2OdCQ8x8"
respuesta_hash = request(url, api_key)

File.open('output.html', "w") do |html|
    html.write("<html>\n")
    html.write("\t<head>\n\t\t<title>Desafio Nasa</title>\n\t</head>\n")
    html.write("\t<body>\n")
    html.write("\t\t<ul>\n")
    respuesta_hash['photos'].each do |elemento|
        photo =  elemento['img_src']
        html.write("\t\t\t<li>\n")
        html.write("\t\t\t\t<img src='#{photo}'>\n")
        html.write("\t\t\t</li>\n")
    end
    html.write("\t\t</ul>\n")
    html.write("\t</body>\n")
    html.write("</html")
end