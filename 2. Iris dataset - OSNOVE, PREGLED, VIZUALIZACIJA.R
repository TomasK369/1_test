#UÈENJE R-ja

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
  # potem moreš razumet podatke --> EXPLORATORY Data Analysis:

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
# kakšne teste??

#/////////////////////////// 3. potem se lahko lotiš kakšnih testov in machine learning

### spremenljivke so lahko kategoriène(character), numeriène(integer)
### faktor = kategorièna, dbl = numerièna (7.42; 4.05; ...)


#______________________________________ IRIS PACKAGE - PREGLED PODATKOV _______________________#

datasets::iris #load dataset
library(iris)
View(iris) #pogled podatkov v novem zavihku
iris <- datasets::iris # KOMAJ TUKAJ NAREDIŠ SPREMENLJIVKO, ki se ti pokaže v environmentu (ALT + - = <- )

# èe napišeš iris$Sepal.Width (al karkoli paè) ti pokaže podatke v obliki VEKTORJA ali kot LIST
# in lahko tudi napišeš ŠIRINA <- iris$Sepal.Width IN s tem ne narediš nove spremenljivke ampak dobiš samo vektor
  sirina <- iris$Sepal.Width
  rm(sirina) # tako se baje brise posamezne "stolpce"

#//////////////////////// 1.
  head(iris, 5)  #ti da prvih 5 vrstic
  tail(iris, 5)  #ti da zadnjih 5 vrstic
  
#//////////////////////// 2.
  summary(iris) # ti da podatke za vsak stolpec posebej
  summary(iris$Sepal.Length) #ti poda samo za doloèen stolpec
  
#//////////////////////// 3.
  sum(is.na(iris)) # to ti pokaže èe so kakšne manjkajoèe enote N/A
 
   
#//////////////////////// 4. 
   install.packages("skimr") #ima dodatne statistike 
   library(skimr)
   skim(iris) #ti da ime paketa, kolièino vrstic/stolpcev, èe so numeric/factor(Species)
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
plot(x = iris$Sepal.Width, y = iris$Sepal.Length) # vedno lahko pišeš "x = ...", "y = ..." ampak ni potrebno, razen zdej ker se uèim.
plot(x = iris$Sepal.Width, y = iris$Sepal.Length, col = "red") 
plot(x = iris$Sepal.Width, y = iris$Sepal.Length, col = "green",
     xlab = "Širina cveta", #tako preimenuješ x in y os v karkoli želiš
     ylab = "Dolžina cveta")


#//////////////////////// 3.  - HISTOGRAM
hist(iris) #ta prvi ne dela ker more bit vstavljena numerièna spremenljivka 
hist(iris$Species) #zato isto ta ne dela, ker je kategorièna spr. ne pa numerièna
hist(iris$Sepal.Width)
hist(iris$Sepal.Width, col = "red") #ga pobarvaš :)

#//////////////////////// 4.  - BOX PLOT 
boxplot(x = iris[,1:4])





#////////////////////////////////////////////////////////////////////////////////////////////////#

#/////////////////////// ÈIŠÈENJE - STARWARS ///////////////////////////////#


library(tidyverse)
view(starwars)
head(starwars)

#/////////////////////// 1.
glimpse(starwars) #pregledaš TIP podatkov (zelo lepo)
class(starwars$gender) #ti napiše toèen tip spremenljivke
unique(starwars$gender) #ti napiše toèno katere vrednosti so v tej spremenljivki (tudi N/A)

#/////////////////////// 2.
#nevem zakaj ampak tukaj bomo zdej spremenili tip $gender-ja
starwars$gender <- as.factor(starwars$gender)
class(starwars$gender) #zdej je faktor

levels(starwars$gender) #tukaj ti pove vrstni red?#
#in èe hoèeš spremenit vrstni red
starwars$gender <- factor((starwars$gender),
                           levels = c("masculine",
                                      "feminine"))
levels(starwars$gender) #zdej je naprej moški in potem ženska
#torej to delaš èe rabiš pravi vrstni red (velik, veèji, najveèji)




#!!!!!!!!!!!!!!!!!!!!!!!!! 3. POMEMBNO %>% !!!!!!!!!!!!!!!!!!!!!!


#TOREJ lahko napišemo normalno tako:
select(starwars, name, height, ends_with("color"))

#TO lahko napišeš tudi tako:
starwars %>% 
  select(name, height, ends_with("color")) #tukaj ti pokaže samo to kar si napisal
#plus ti pokaže vse kategorije ki se konèajo z COLOR (èe imaš veè enakih imen...)


#ÈE želiš še filtrirat stvari
starwars %>% 
  filter(hair_color == c("blond", "brown"))

#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#AMPAK èe delaš veè stvari hkrat lahko uporabiš %>% da bo lažje
#npr. èe želimo narediti in SELECT in FILTER v enem šusu
starwars %>% 
  select(name, height, ends_with("color")) %>% 
  filter(hair_color == c("blond", "brown") &
                           height < 180)





#!!!!!!!!!!!!!!!!!!!!!!!!! 4. MISSING DATA %>% !!!!!!!!!!!!!!!!!!!!!!


#torej èe želiš povpreèje od višine:
mean(starwars$height) #dobiš NA, ker imaš noter MANJKAJOÈE VREDNOSTI
#zato jih moremo izkljuèit:
mean(starwars$height, na.rm = TRUE) #daš TRUE, ker reèeš ja je prav da odstranim NA vrednosti


#/////////////////////// 5.
#èe bi želel zbrisati vse NA 
starwars %>% 
  select(name, height, hair_color, height) %>% 
  na.omit() #AMPAK to ni dobro ker neveš kaj zbrišeš

# zato je boljše èe naprej pregledaš KJE vse imaš NA
starwars %>% 
  select(name, gender, hair_color, height) %>% 
  filter(complete.cases(.))#to nam pokaže samo spr. kjer so spr CELE (brez NA)

#AMPAK èe damo spredaj ! pomeni da bo naredilo RAVNO NASPROTNO kot zgoraj
#torej ti pokaže samo spr. kjer ima spr. nek NA nekje
starwars %>% 
  select(name, gender, hair_color, height) %>% 
  filter(!complete.cases(.))

#in potem ko vidiš kaj želiš zbrisat napišeš drop_na(xyz)
starwars %>% 
  select(name, gender, hair_color, height) %>% 
  filter(!complete.cases(.)) %>%
  drop_na(height) #to


#/////////////////////// 6. - MUTATE
#mutate ti da možnost naredit novo spr. ali napišeš stvari na ISTO spr. (rewrite)

#tukaj želimo spremenit NA v "hair_color" da bo pisalo "none" (ker lahko nima las, ne pa da nimamo podatka)
starwars %>% 
  select(name, gender, hair_color, height) %>% 
  filter(!complete.cases(.)) %>%
  drop_na(height) %>% 
  mutate(hair_color = replace_na(hair_color, "none")) 
#torej smo rekli, naredi stolpec hair_color, z vrednostmi iz hair_color, ampak spremeni vse NA v "none"

#èe bi želel narediti nov stolpec bi blo tako
starwars %>% 
  select(name, gender, hair_color, height) %>% 
  filter(!complete.cases(.)) %>%
  drop_na(height) %>% 
  mutate(hair_color_2 = replace_na(hair_color, "none")) # tukaj vidiš imaš nov stolpec
           

#/////////////////////// 6. - RECODE
starwars %>% 
  select(name, gender) %>% 
  mutate(spol = recode(gender, "masculine" = 1, "feminine" = 2)) #VIDIŠ da je isti format kot zgoraj MUTATE
#tukaj sem poimenoval gender kot spol, torej format je tak;
#mutiraj/naredi nov stolpec "spol" in ga rekodiraj/mu dodaj vrednosti iz "gender", AMPAK napiši moški in ženski kot 1 in 2

#za lepše brat daš tako, ampak je isto
starwars %>% 
  select(name, gender) %>% 
  mutate(gender = recode(gender,
                         "masculine" = 1,
                         "feminine" = 2))






#////////////////////////////////////////////////////////////////////////////////////////////////#

#/////////////////////// VIZUALIZACIJA -gapminder ///////////////////////////////#


#TRI GLAVNE KOMPONENTE: (potem lahko delaš še druge stvari...teme...)
#1. define the data
#2. define the estetics (mapping)
#3. define the geometry


#TIPI GRAFOV:
# - ZA ENO NUMERIÈNO SPR..
  # - histogram, density plot, box plot, violin plot
# - ZA ENO ali VEÈ KATEGORIÈNIH SPR.
  # - barplot (samo za eno), stacked plot (barplot z obema spr.), Grouped plot (obe spr. zraven skupaj), percentage plot
# - ZA DVE KATEGORIÈNI IN ENO NUMERIÈNO (kategorièna spr. vpliva/doloèa kako se numerièna porazdeljuje)
  # - density plot, boxplot (lahko vkljuèiš samo eno spr. ali pa obe - in dobiš vsak graf posebej)
# - ZA DVE NUMERIÈNI IN ENO KATEGORIÈNO 
  # - scatter plot za dve numerièni spr. (in regression line)(in se porazdeljujejo glede na kategorièno spr (spol))


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
  geom_point() + #IN TO JE 3. del (define geometry) (tukaj napišeš kakšen tip grafa želiš (histogram, barplot,boxplot...))


#______________________ facet_wrap(~ continent)
  # zgoraj sem napisal "shape = continent" - ampak èe bi želel posebej narediti dva grafa po kontintentih dodam "facet_wrap(~ continent)"
gapminder %>%
  filter(continent %in% c("Africa", "Europe")) %>%
  filter(gdpPercap < 30000) %>% 
  ggplot(mapping = aes(x = gdpPercap, #TUKAJ JE POMEMBNO VEDET DA PRAVILOMA BI MOGLI NAPISAT najprej 1. del (define data)
                       y = lifeExp,   #ggplot(data = gapminder, mapping = aes(x=..., y= ...)) 
                       size = pop,    # ampak ker uporabljamo pipe operator, gremo lahko takoj na 2. del (aestetics/mapping)
                       color = year)) +
  geom_point() + #IN TO JE 3. del (define geometry) (tukaj napišeš kakšen tip grafa želiš (histogram, barplot,boxplot...))
# geom_smooth(method = lm) + to je za ÈRTO in èe daš method = lm (linear model) ti da RAVNO ÈRTO
  facet_wrap(~continent) +
labs(title = "Življenska doba po GDP per Capita",
     x = "GDP per Capita",
     y = "Življenska doba") #LABS = ZA OZNAÈIT/POIMENOVAT GRAF


