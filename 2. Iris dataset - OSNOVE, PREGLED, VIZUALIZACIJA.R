#U?ENJE R-ja

#OSNOVE:
# -------------------- PREGLED PODATKOV IN OSNOVEN PRIKAZ LE-TEH ------------------ #

#//////////////////////////// 1.
  #Dataset je lahko:
# structured
# unstructured
# numeric
# quantitative 
# qualitative
# clean (no missing values)
# not clean

#/////////////////////////// 2.
  # potem more? razumet podatke --> EXPLORATORY Data Analysis:

# BASIC STATISTICS:
#   distribution
#   min
#   max
#   standard deviation
#   mean
#   median
#   mode 

# prikazat grafe (barplot, histogram, scatterplot, boxplot)

# PCA (principle component analysis)
# SOM (self organization map)
# kak?ne teste??

#/////////////////////////// 3. potem se lahko loti? kak?nih testov in machine learning

### spremenljivke so lahko kategori?ne(character), numeri?ne(integer)
### faktor = kategori?na, dbl = numeri?na (7.42; 4.05; ...)


#______________________________________ IRIS PACKAGE - PREGLED PODATKOV _______________________#

datasets::iris #load dataset
library(iris)
View(iris) #pogled podatkov v novem zavihku
iris <- datasets::iris # KOMAJ TUKAJ NAREDI? SPREMENLJIVKO, ki se ti poka?e v environmentu (ALT + - = <- )

# ?e napi?e? iris$Sepal.Width (al karkoli pa?) ti poka?e podatke v obliki VEKTORJA ali kot LIST
# in lahko tudi napi?e? ?IRINA <- iris$Sepal.Width IN s tem ne naredi? nove spremenljivke ampak dobi? samo vektor
  sirina <- iris$Sepal.Width
  rm(sirina) # tako se baje brise posamezne "stolpce"

#//////////////////////// 1.
  head(iris, 5)  #ti da prvih 5 vrstic
  tail(iris, 5)  #ti da zadnjih 5 vrstic
  
#//////////////////////// 2.
  summary(iris) # ti da podatke za vsak stolpec posebej
  summary(iris$Sepal.Length) #ti poda samo za dolo?en stolpec
  
#//////////////////////// 3.
  sum(is.na(iris)) # to ti poka?e ?e so kak?ne manjkajo?e enote N/A
 
   
#//////////////////////// 4. 
   install.packages("skimr") #ima dodatne statistike 
   library(skimr)
   skim(iris) #ti da ime paketa, koli?ino vrstic/stolpcev, ?e so numeric/factor(Species)
              # in ti pove za vsako svoje statistike

#//////////////////////// 5.   
  iris %>%  # CTRL + SHIFT + M = PIPA
    dplyr::group_by(Species) %>% 
    skim()
            #TO jih torej pogrupira po "Species" in ti poda statistike
  
  
  
  #______________________________________ IRIS PACKAGE - VIZUALIZACIJA _______________________#  

#//////////////////////// 1.  - KARKOLI?
plot(iris)
plot(iris, col = "red")

#//////////////////////// 2.  - SCATTER PLOT
plot(x = iris$Sepal.Width, y = iris$Sepal.Length) # vedno lahko pi?e? "x = ...", "y = ..." ampak ni potrebno, razen zdej ker se u?im.
plot(x = iris$Sepal.Width, y = iris$Sepal.Length, col = "red") 
plot(x = iris$Sepal.Width, y = iris$Sepal.Length, col = "green",
     xlab = "?irina cveta", #tako preimenuje? x in y os v karkoli ?eli?
     ylab = "Dol?ina cveta")


#//////////////////////// 3.  - HISTOGRAM
hist(iris) #ta prvi ne dela ker more bit vstavljena numeri?na spremenljivka 
hist(iris$Species) #zato isto ta ne dela, ker je kategori?na spr. ne pa numeri?na
hist(iris$Sepal.Width)
hist(iris$Sepal.Width, col = "red") #ga pobarva? :)

#//////////////////////// 4.  - BOX PLOT 
boxplot(x = iris[,1:4])





#////////////////////////////////////////////////////////////////////////////////////////////////#

#/////////////////////// ?I??ENJE - STARWARS ///////////////////////////////#


library(tidyverse)
view(starwars)
head(starwars)

#/////////////////////// 1.
glimpse(starwars) #pregleda? TIP podatkov (zelo lepo)
class(starwars$gender) #ti napi?e to?en tip spremenljivke
unique(starwars$gender) #ti napi?e to?no katere vrednosti so v tej spremenljivki (tudi N/A)

#/////////////////////// 2.
#nevem zakaj ampak tukaj bomo zdej spremenili tip $gender-ja
starwars$gender <- as.factor(starwars$gender)
class(starwars$gender) #zdej je faktor

levels(starwars$gender) #tukaj ti pove vrstni red?#
#in ?e ho?e? spremenit vrstni red
starwars$gender <- factor((starwars$gender),
                           levels = c("masculine",
                                      "feminine"))
levels(starwars$gender) #zdej je naprej mo?ki in potem ?enska
#torej to dela? ?e rabi? pravi vrstni red (velik, ve?ji, najve?ji)




#!!!!!!!!!!!!!!!!!!!!!!!!! 3. POMEMBNO %>% !!!!!!!!!!!!!!!!!!!!!!


#TOREJ lahko napi?emo normalno tako:
select(starwars, name, height, ends_with("color"))

#TO lahko napi?e? tudi tako:
starwars %>% 
  select(name, height, ends_with("color")) #tukaj ti poka?e samo to kar si napisal
#plus ti poka?e vse kategorije ki se kon?ajo z COLOR (?e ima? ve? enakih imen...)


#?E ?eli? ?e filtrirat stvari
starwars %>% 
  filter(hair_color == c("blond", "brown"))

#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#AMPAK ?e dela? ve? stvari hkrat lahko uporabi? %>% da bo la?je
#npr. ?e ?elimo narediti in SELECT in FILTER v enem ?usu
starwars %>% 
  select(name, height, ends_with("color")) %>% 
  filter(hair_color == c("blond", "brown") &
                           height < 180)





#!!!!!!!!!!!!!!!!!!!!!!!!! 4. MISSING DATA %>% !!!!!!!!!!!!!!!!!!!!!!


#torej ?e ?eli? povpre?je od vi?ine:
mean(starwars$height) #dobi? NA, ker ima? noter MANJKAJO?E VREDNOSTI
#zato jih moremo izklju?it:
mean(starwars$height, na.rm = TRUE) #da? TRUE, ker re?e? ja je prav da odstranim NA vrednosti


#/////////////////////// 5.
#?e bi ?elel zbrisati vse NA 
starwars %>% 
  select(name, height, hair_color, height) %>% 
  na.omit() #AMPAK to ni dobro ker neve? kaj zbri?e?

# zato je bolj?e ?e naprej pregleda? KJE vse ima? NA
starwars %>% 
  select(name, gender, hair_color, height) %>% 
  filter(complete.cases(.))#to nam poka?e samo spr. kjer so spr CELE (brez NA)

#AMPAK ?e damo spredaj ! pomeni da bo naredilo RAVNO NASPROTNO kot zgoraj
#torej ti poka?e samo spr. kjer ima spr. nek NA nekje
starwars %>% 
  select(name, gender, hair_color, height) %>% 
  filter(!complete.cases(.))

#in potem ko vidi? kaj ?eli? zbrisat napi?e? drop_na(xyz)
starwars %>% 
  select(name, gender, hair_color, height) %>% 
  filter(!complete.cases(.)) %>%
  drop_na(height) #to


#/////////////////////// 6. - MUTATE
#mutate ti da mo?nost naredit novo spr. ali napi?e? stvari na ISTO spr. (rewrite)

#tukaj ?elimo spremenit NA v "hair_color" da bo pisalo "none" (ker lahko nima las, ne pa da nimamo podatka)
starwars %>% 
  select(name, gender, hair_color, height) %>% 
  filter(!complete.cases(.)) %>%
  drop_na(height) %>% 
  mutate(hair_color = replace_na(hair_color, "none")) 
#torej smo rekli, naredi stolpec hair_color, z vrednostmi iz hair_color, ampak spremeni vse NA v "none"

#?e bi ?elel narediti nov stolpec bi blo tako
starwars %>% 
  select(name, gender, hair_color, height) %>% 
  filter(!complete.cases(.)) %>%
  drop_na(height) %>% 
  mutate(hair_color_2 = replace_na(hair_color, "none")) # tukaj vidi? ima? nov stolpec
           

#/////////////////////// 6. - RECODE
starwars %>% 
  select(name, gender) %>% 
  mutate(spol = recode(gender, "masculine" = 1, "feminine" = 2)) #VIDI? da je isti format kot zgoraj MUTATE
#tukaj sem poimenoval gender kot spol, torej format je tak;
#mutiraj/naredi nov stolpec "spol" in ga rekodiraj/mu dodaj vrednosti iz "gender", AMPAK napi?i mo?ki in ?enski kot 1 in 2

#za lep?e brat da? tako, ampak je isto
starwars %>% 
  select(name, gender) %>% 
  mutate(gender = recode(gender,
                         "masculine" = 1,
                         "feminine" = 2))






#////////////////////////////////////////////////////////////////////////////////////////////////#

#/////////////////////// VIZUALIZACIJA -gapminder ///////////////////////////////#


#TRI GLAVNE KOMPONENTE: (potem lahko dela? ?e druge stvari...teme...)
#1. define the data
#2. define the estetics (mapping)
#3. define the geometry


#TIPI GRAFOV:
# - ZA ENO NUMERI?NO SPR..
  # - histogram, density plot, box plot, violin plot
# - ZA ENO ali VE? KATEGORI?NIH SPR.
  # - barplot (samo za eno), stacked plot (barplot z obema spr.), Grouped plot (obe spr. zraven skupaj), percentage plot
# - ZA DVE KATEGORI?NI IN ENO NUMERI?NO (kategori?na spr. vpliva/dolo?a kako se numeri?na porazdeljuje)
  # - density plot, boxplot (lahko vklju?i? samo eno spr. ali pa obe - in dobi? vsak graf posebej)
# - ZA DVE NUMERI?NI IN ENO KATEGORI?NO 
  # - scatter plot za dve numeri?ni spr. (in regression line)(in se porazdeljujejo glede na kategori?no spr (spol))


#/////////////////////// 1.
library(tidyverse)
view(population)
install.packages("gapminder")
library(gapminder)

glimpse(gapminder)
summary(gapminder)



gapminder %>%
  filter(continent %in% c("Africa", "Europe")) %>%
  filter(gdpPercap < 30000) %>% 
  ggplot(mapping = aes(x = gdpPercap, #TUKAJ JE POMEMBNO VEDET DA PRAVILOMA BI MOGLI NAPISAT najprej 1. del (define data)
                       y = lifeExp,   #ggplot(data = gapminder, mapping = aes(x=..., y= ...)) 
                       size = pop,    # ampak ker uporabljamo pipe operator, gremo lahko takoj na 2. del (aestetics/mapping)
                       color = year,
                       shape = continent)) +
  geom_point() + #IN TO JE 3. del (define geometry) (tukaj napi?e? kak?en tip grafa ?eli? (histogram, barplot,boxplot...))


#______________________ facet_wrap(~ continent)
  # zgoraj sem napisal "shape = continent" - ampak ?e bi ?elel posebej narediti dva grafa po kontintentih dodam "facet_wrap(~ continent)"
gapminder %>%
  filter(continent %in% c("Africa", "Europe")) %>%
  filter(gdpPercap < 30000) %>% 
  ggplot(mapping = aes(x = gdpPercap, #TUKAJ JE POMEMBNO VEDET DA PRAVILOMA BI MOGLI NAPISAT najprej 1. del (define data)
                       y = lifeExp,   #ggplot(data = gapminder, mapping = aes(x=..., y= ...)) 
                       size = pop,    # ampak ker uporabljamo pipe operator, gremo lahko takoj na 2. del (aestetics/mapping)
                       color = year)) +
  geom_point() + #IN TO JE 3. del (define geometry) (tukaj napi?e? kak?en tip grafa ?eli? (histogram, barplot,boxplot...))
# geom_smooth(method = lm) + to je za ?RTO in ?e da? method = lm (linear model) ti da RAVNO ?RTO
  facet_wrap(~continent) +
labs(title = "?ivljenska doba po GDP per Capita",
     x = "GDP per Capita",
     y = "?ivljenska doba") #LABS = ZA OZNA?IT/POIMENOVAT GRAF


