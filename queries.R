
MyDataBase <- dbConnect(
  drv = RMySQL::MySQL(),
  dbname = "shinydemo",
  host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
  username = "guest",
  password = "guest")

#Una vez hecha la conexión a la BDD, generar una búsqueda con dplyr que devuelva 
#el porcentaje de personas que hablan español en todos los países

dbListTables(MyDataBase)
dbListFields(MyDataBase, 'CountryLanguage')
#Guardamos la tabla CountryLanguage en un DataFrame
DataDB <- dbGetQuery(MyDataBase, "select * from CountryLanguage")
#Analizamos el DataFrame
head(DataDB)
summary(DataDB)
#Realizamos la consulta del porcentaje de personas de habla español
library(dplyr)
pop.esp <-  DataDB %>% filter(Language == "Spanish")
pop.esp

#Realizar una gráfica con ggplot que represente este porcentaje de tal modo que 
#en el eje de las Y aparezca el país y en X el porcentaje, y que diferencíe entre 
#aquellos que es su lengua oficial y los que no, con diferente color 
#(puedes utilizar geom_bin2d() ó geom_bar() y coord_flip(), si es necesario para 
#visualizar mejor tus gráficas)
install.packages("ggplot2")
library(ggplot2)
ggplot(pop.esp, aes(x = Percentage, y = CountryCode, colour = IsOfficial)) + 
  geom_point() + 
  theme_grey() + ggtitle("Porcentaje de habla española por pais")
