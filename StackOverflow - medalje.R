library(haven)
Koncna_baza <- read_sav("Koncna baza.sav")
View(Koncna_baza)

library(tidyverse)
glimpse(Koncna_baza)
Koncna_baza %>% 
  select(Povezanost, Kompetence, Participacija) %>% 
  filter(Kompetence < 130) %>% 
  cor()

Koncna_baza %>% 
  select(Povezanost, Kompetence, Participacija) %>% 
  filter(Kompetence < 130) %>% 
  ggplot(aes(x = Participacija,
             y = Kompetence,
             size = Kompetence,
             color = Povezanost))+
  geom_point() +
  geom_smooth()+ 
  
  



#to ?e bo? hotel ve? medalj povezat med seboj kot ima? napisano za projekt
aggregate(cbind(Koncna_baza$Caucus, Koncna_baza$Constituent) ~ Koncna_baza$Uporabniki, Koncna_baza , FUN = sum)
#to je ?e ho?e? delat to kar si delal v SPSS - torej se?tel vrednosti medalj po uporabnikih

    